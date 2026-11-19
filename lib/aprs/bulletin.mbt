///|
/// Classification of an APRS message.
pub(all) enum MessageKind {
  /// A normal message between two stations.
  Personal
  /// A bulletin addressed to `BLN0` … `BLN9`.
  Bulletin(Char)
  /// A National Weather Service message (`NWS-…`).
  Nws
}

///|
/// A short label for the message kind.
pub fn MessageKind::label(self : MessageKind) -> String {
  match self {
    Personal => "personal"
    Bulletin(n) => "bulletin-" + n.to_string()
    Nws => "nws"
  }
}

///|
fn starts_with(text : String, prefix : String) -> Bool {
  let cs = text.to_array()
  let ps = prefix.to_array()
  if ps.length() > cs.length() {
    return false
  }
  for i in 0..<ps.length() {
    if cs[i] != ps[i] {
      return false
    }
  }
  true
}

///|
/// Classify a message. Bulletin addressees are `BLN0`-`BLN9`; NWS messages use
/// an `NWS-` addressee.
pub fn classify_message(message : Message) -> MessageKind {
  let to = message.to_call()
  let upper = StringBuilder()
  for c in to.to_array() {
    upper.write_char(c.to_ascii_uppercase())
  }
  let name = upper.to_string()
  if name.length() >= 4 && starts_with(name, "BLN") {
    let digit = name.to_array()[3]
    if digit >= '0' && digit <= '9' {
      return Bulletin(digit)
    }
  }
  if starts_with(name, "NWS") {
    return Nws
  }
  Personal
}

///|
/// The five character bulletin subject (trimmed), or `None` when the message is
/// not a bulletin.
pub fn bulletin_subject(message : Message) -> String? {
  match classify_message(message) {
    Bulletin(_) => Some(chars_slice(message.body(), 0, 5).trim().to_owned())
    _ => None
  }
}

///|
/// The bulletin body after the five character subject.
pub fn bulletin_body(message : Message) -> String? {
  match classify_message(message) {
    Bulletin(_) => Some(chars_rest(message.body(), 5).trim().to_owned())
    _ => None
  }
}

///|
/// Render a one-line description of a message for logs.
pub fn describe_message(message : Message) -> String {
  match classify_message(message) {
    Bulletin(n) =>
      "bulletin " +
      n.to_string() +
      " [" +
      bulletin_subject(message).unwrap() +
      "] " +
      bulletin_body(message).unwrap()
    Nws => "NWS: " + message.body()
    Personal =>
      if message.is_ack() {
        "ack " + message.acked_id().unwrap()
      } else {
        "message to " + message.to_call() + ": " + message.body()
      }
  }
}
