///|
/// Events produced while consuming an APRS-IS server stream.
pub(all) enum IsEvent {
  /// A `#` comment line from the server (greeting, login result, keepalive).
  Comment(String)
  /// A valid TNC2 packet.
  Packet(AprsPacket)
  /// A line that is neither a comment nor a valid packet.
  Malformed(String)
  /// An empty line.
  Ignored
}

///|
/// Client-side state for an APRS-IS connection.
///
/// Networking itself is left to the host application; this type owns the
/// protocol state (login line, keepalive, packet parsing and counters).
pub struct IsSession {
  callsign : String
  passcode : Int
  filter : String
  mut logged_in : Bool
  mut server : String
  mut received : Int
  mut comments : Int
}

///|
/// Create a session. Use passcode `-1` for a receive-only connection.
pub fn IsSession::new(callsign : String, passcode : Int, filter : String) -> IsSession {
  { callsign, passcode, filter, logged_in: false, server: "", received: 0, comments: 0 }
}

///|
/// The login line to send once the TCP connection is established.
pub fn IsSession::login_line(self : IsSession) -> String {
  login_line(self.callsign, self.passcode, self.filter)
}

///|
/// A keepalive comment. APRS-IS servers also send these every 20 seconds.
pub fn IsSession::keepalive(self : IsSession) -> String {
  ignore(self)
  "# MoonAPRS keepalive"
}

///|
/// Whether the server has confirmed the login.
pub fn IsSession::is_logged_in(self : IsSession) -> Bool {
  self.logged_in
}

///|
/// The server identification captured from the first comment line.
pub fn IsSession::server_name(self : IsSession) -> String {
  self.server
}

///|
/// Number of valid packets received.
pub fn IsSession::packet_count(self : IsSession) -> Int {
  self.received
}

///|
/// Number of comment lines received.
pub fn IsSession::comment_count(self : IsSession) -> Int {
  self.comments
}

///|
/// Consume one line from the server.
pub fn IsSession::handle_line(self : IsSession, line : String) -> IsEvent {
  let trimmed = line.trim().to_owned()
  if trimmed.length() == 0 {
    return Ignored
  }
  if trimmed.has_prefix("#") {
    self.comments = self.comments + 1
    if self.server.length() == 0 && trimmed.length() > 2 {
      self.server = chars_rest(trimmed, 2)
    }
    if trimmed.contains("verified") && !trimmed.contains("unverified") {
      self.logged_in = true
    }
    return Comment(trimmed)
  }
  match AprsPacket::parse(trimmed) {
    Ok(packet) => {
      self.received = self.received + 1
      Packet(packet)
    }
    Err(e) => Malformed(e)
  }
}

///|
/// A short label for an event, used by the CLI.
pub fn IsEvent::label(self : IsEvent) -> String {
  match self {
    Comment(text) => "comment: " + text
    Packet(packet) => "packet: " + packet.header().source().to_string()
    Malformed(e) => "malformed: " + e
    Ignored => "ignored"
  }
}
