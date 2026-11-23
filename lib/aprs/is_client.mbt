///|
/// A bidirectional line stream the client engine drives (TCP, stdio, in-memory…).
///
/// `read_line` strips the trailing CRLF and returns `None` on EOF or a read
/// timeout, which the engine treats as a dead connection and reconnects.
/// `write_line` appends CRLF. Implementations own buffering and timing.
pub(open) trait IsTransport {
  fn read_line(Self) -> String?
  fn write_line(Self, String) -> Unit
  fn close(Self) -> Unit
}

///|
/// UTF-8 helpers shared with native transports, so `cmd/main` need not import
/// the encoding package directly (it would be flagged unused on Wasm/JS
/// targets, where the native transport file is excluded).
pub fn utf8_encode(s : String) -> Bytes {
  @utf8.encode(s)
}

///|
pub fn utf8_decode_lossy(b : BytesView) -> String {
  @utf8.decode_lossy(b)
}

///|
/// Events produced by `IsClient::process_line`.
pub(all) enum ClientLine {
  /// A `#` comment line from the server (greeting, keepalive, …).
  Comment(String)
  /// A valid, previously unseen TNC2 packet.
  Packet(AprsPacket)
  /// A line that is neither a comment nor a valid packet.
  Malformed(String)
  /// An empty line.
  Ignored
  /// The server confirmed the login (carries the confirming comment line).
  LoggedIn(String)
  /// The transport reported EOF / timeout; the loop reconnects.
  Eof
}

///|
/// A transport-agnostic APRS-IS client engine.
///
/// It owns the wire protocol: sending the login line, classifying server lines,
/// confirming login, duplicate suppression, counters and a reconnect loop with
/// exponential backoff. The actual networking is supplied by an `IsTransport`
/// implementation, so the library stays free of platform dependencies and the
/// same engine runs over TCP, stdio or a test double.
pub struct IsClient {
  session : IsSession
  dedupe : DedupeWindow
  mut was_logged_in : Bool
  mut duplicates : Int32
  mut reconnects : Int32
}

///|
/// Create a client. Use `passcode` `-1` for a receive-only connection.
pub fn IsClient::new(
  callsign : String,
  passcode : Int32,
  filter : String,
) -> IsClient {
  {
    session: IsSession::new(callsign, passcode, filter),
    dedupe: DedupeWindow::new(256),
    was_logged_in: false,
    duplicates: 0,
    reconnects: 0,
  }
}

///|
pub fn IsClient::login_line(self : IsClient) -> String {
  self.session.login_line()
}

///|
pub fn IsClient::is_logged_in(self : IsClient) -> Bool {
  self.session.is_logged_in()
}

///|
pub fn IsClient::server_name(self : IsClient) -> String {
  self.session.server_name()
}

///|
pub fn IsClient::packet_count(self : IsClient) -> Int32 {
  self.session.packet_count()
}

///|
pub fn IsClient::comment_count(self : IsClient) -> Int32 {
  self.session.comment_count()
}

///|
/// Number of packets dropped by the duplicate window.
pub fn IsClient::duplicate_count(self : IsClient) -> Int32 {
  self.duplicates
}

///|
/// Number of (re)connection attempts that established a transport.
pub fn IsClient::reconnect_count(self : IsClient) -> Int32 {
  self.reconnects
}

///|
/// Process one server line and classify it, applying duplicate suppression.
pub fn IsClient::process_line(self : IsClient, line : String) -> ClientLine {
  match self.session.handle_line(line) {
    Comment(text) => {
      let now_logged = self.session.is_logged_in()
      let event = if now_logged && !self.was_logged_in {
        LoggedIn(text)
      } else {
        Comment(text)
      }
      self.was_logged_in = now_logged
      event
    }
    Packet(packet) => {
      if !self.dedupe.is_new(packet) {
        self.duplicates = self.duplicates + 1
      }
      Packet(packet)
    }
    Malformed(err) => Malformed(err)
    Ignored => Ignored
  }
}

///|
/// Reset login state for a fresh connection (keeps cumulative counters).
fn IsClient::reset_login(self : IsClient) -> Unit {
  self.session.logged_in = false
  self.session.server = ""
  self.was_logged_in = false
}

///|
/// Connect and run forever, reconnecting on EOF/timeout with exponential backoff.
///
/// * `connect` dials and returns a fresh transport, or `None` on failure.
/// * `on_event` is invoked for every processed line; return `false` to stop.
/// * `sleep(ms)` is called between reconnect attempts (no-op in tests).
pub fn[T : IsTransport] IsClient::run(
  self : IsClient,
  connect : () -> T?,
  on_event : (ClientLine) -> Bool,
  sleep : (Int32) -> Unit,
) -> Unit {
  let mut backoff = 1000
  while true {
    match connect() {
      None => {
        sleep(backoff)
        if backoff < 30000 {
          backoff = backoff * 2
        }
      }
      Some(transport) => {
        self.reconnects = self.reconnects + 1
        self.reset_login()
        transport.write_line(self.login_line())
        let mut stop = false
        while true {
          match transport.read_line() {
            None => break
            Some(line) => {
              let event = self.process_line(line)
              if !on_event(event) {
                stop = true
                break
              }
            }
          }
        }
        transport.close()
        if stop {
          return
        }
        sleep(backoff)
        if backoff < 30000 {
          backoff = backoff * 2
        }
      }
    }
  }
}
