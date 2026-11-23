///|
/// A scripted in-memory transport for exercising `IsClient` without a network.
struct MemTransport {
  mut lines : Array[String]
  written : Array[String]
}

///|
fn MemTransport::new(lines : Array[String]) -> MemTransport {
  { lines, written: [], }
}

///|
fn MemTransport::written_lines(self : MemTransport) -> Array[String] {
  self.written
}

///|
impl IsTransport for MemTransport with fn read_line(self) -> String? {
  if self.lines.length() == 0 {
    None
  } else {
    let first = self.lines[0]
    let rest : Array[String] = []
    for i in 1..<self.lines.length() {
      rest.push(self.lines[i])
    }
    self.lines = rest
    Some(first)
  }
}

///|
impl IsTransport for MemTransport with fn write_line(self, line : String) -> Unit {
  self.written.push(line)
}

///|
impl IsTransport for MemTransport with fn close(self) -> Unit {
  ignore(self)
}

///|
fn no_sleep(_ms : Int32) -> Unit {
  ()
}

///|
test "client sends login and confirms verified banner" {
  let client = IsClient::new("N0CALL", 13023, "")
  let transport = MemTransport::new([
    "# aprsc 2.1.11-gf5e77ce", "# logresp N0CALL verified, server TEST", "N0CALL-9>APRS,WIDE2-1:!4903.50N/07201.75W-Test",
  ])
  let mut seen_logged_in = false
  let mut seen_packet = false
  client.run(
    fn() { Some(transport) },
    fn(event) {
      match event {
        LoggedIn(_) => seen_logged_in = true
        Packet(_) => seen_packet = true
        _ => ()
      }
      !(seen_logged_in && seen_packet)
    },
    no_sleep,
  )
  assert_eq(client.is_logged_in(), true)
  assert_eq(client.reconnect_count(), 1)
  assert_eq(client.packet_count(), 1)
  assert_eq(transport.written_lines()[0], client.login_line())
}

///|
test "duplicate packets are suppressed" {
  let client = IsClient::new("N0CALL", -1, "")
  let dup = "N0CALL-9>APRS,WIDE2-1:!4903.50N/07201.75W-Test"
  let server = [dup, dup, dup]
  let mut packets = 0
  client.run(
    fn() { Some(MemTransport::new(server)) },
    fn(event) {
      match event {
        Packet(_) => packets = packets + 1
        _ => ()
      }
      packets < 3
    },
    no_sleep,
  )
  assert_eq(client.packet_count(), 3)
  assert_eq(client.duplicate_count(), 2)
}

///|
test "engine reconnects after EOF" {
  let client = IsClient::new("N0CALL", -1, "")
  let mut attempt = 0
  let mut total = 0
  client.run(
    fn() {
      attempt = attempt + 1
      if attempt == 1 {
        Some(MemTransport::new(["A>APRS:!4900.00N/07200.00W-"]))
      } else {
        Some(MemTransport::new(["B>APRS:!4900.00N/07200.00W-"]))
      }
    },
    fn(event) {
      match event {
        Packet(_) => total = total + 1
        _ => ()
      }
      total < 2
    },
    no_sleep,
  )
  assert_eq(client.reconnect_count(), 2)
  assert_eq(client.packet_count(), 2)
}

///|
test "failed connect backs off then succeeds" {
  let client = IsClient::new("N0CALL", -1, "")
  let mut attempts = 0
  let mut sleeps = 0
  client.run(
    fn() {
      attempts = attempts + 1
      if attempts < 3 {
        None
      } else {
        Some(MemTransport::new(["C>APRS:!4900.00N/07200.00W-"]))
      }
    },
    fn(event) {
      match event {
        Packet(_) => false
        _ => true
      }
    },
    fn(_) { sleeps = sleeps + 1 },
  )
  assert_eq(client.reconnect_count(), 1)
  assert_eq(sleeps, 2)
}
