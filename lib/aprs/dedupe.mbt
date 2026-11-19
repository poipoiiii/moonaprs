///|
/// A stable signature for duplicate detection.
///
/// The digipeater path is deliberately excluded: the same APRS payload arriving
/// through different digipeaters is the same packet.
pub fn packet_signature(packet : AprsPacket) -> String {
  let header = packet.header()
  header.source().to_string() +
  ">" +
  header.destination().to_string() +
  ":" +
  header.info_field()
}

///|
/// A fixed-size first-in-first-out window of recently seen packet signatures.
pub struct DedupeWindow {
  capacity : Int32
  mut keys : Array[String]
}

///|
/// Create a window that remembers the last `capacity` signatures.
pub fn DedupeWindow::new(capacity : Int32) -> DedupeWindow {
  { capacity: if capacity < 1 { 1 } else { capacity }, keys: [], }
}

///|
/// Number of signatures currently held.
pub fn DedupeWindow::size(self : DedupeWindow) -> Int32 {
  self.keys.length()
}

///|
fn DedupeWindow::contains(self : DedupeWindow, key : String) -> Bool {
  for existing in self.keys {
    if existing == key {
      return true
    }
  }
  false
}

///|
fn drop_first(items : Array[String]) -> Array[String] {
  let out : Array[String] = []
  for i in 1..<items.length() {
    out.push(items[i])
  }
  out
}

///|
/// Record a packet and report whether it had not been seen in the window.
pub fn DedupeWindow::is_new(self : DedupeWindow, packet : AprsPacket) -> Bool {
  let key = packet_signature(packet)
  if self.contains(key) {
    return false
  }
  self.keys.push(key)
  while self.keys.length() > self.capacity {
    self.keys = drop_first(self.keys)
  }
  true
}

///|
/// Parse a TNC2 line and test it against the window.
pub fn DedupeWindow::is_new_line(
  self : DedupeWindow,
  line : String,
) -> Result[Bool, String] {
  match AprsPacket::parse(line) {
    Ok(packet) => Ok(self.is_new(packet))
    Err(e) => Err(e)
  }
}
