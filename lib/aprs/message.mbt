///|
/// An APRS message: `:ADDRESSEE:text` with an optional `{message-id` suffix.
///
/// Acknowledgments are messages whose text is `ack` followed by the id of the
/// message being acknowledged.
pub struct Message {
  addressee : String
  text : String
  msg_id : String?
  ack_id : String?
}

///|
/// The addressed station, with padding removed.
pub fn Message::to_call(self : Message) -> String {
  self.addressee
}

///|
/// The message text without the message id suffix.
pub fn Message::body(self : Message) -> String {
  self.text
}

///|
/// The message id after `{`, when present.
pub fn Message::id(self : Message) -> String? {
  self.msg_id
}

///|
/// The acknowledged message id when this is an `ack` message.
pub fn Message::acked_id(self : Message) -> String? {
  self.ack_id
}

///|
/// Whether this message is an acknowledgment.
pub fn Message::is_ack(self : Message) -> Bool {
  self.ack_id is Some(_)
}

///|
/// Parse the body after the leading `:`.
pub fn parse_message(body : String) -> Result[Message, String] {
  let cs = body.to_array()
  if cs.length() < 10 {
    return Err("message must start with a nine character addressee")
  }
  let addressee_sb = StringBuilder()
  for i in 0..<9 {
    addressee_sb.write_char(cs[i])
  }
  let addressee = addressee_sb.to_string().trim().to_owned()
  if addressee.length() == 0 {
    return Err("message addressee is empty")
  }
  if cs.length() < 11 {
    return Err("message text is missing")
  }
  let text_sb = StringBuilder()
  for i in 10..<cs.length() {
    text_sb.write_char(cs[i])
  }
  let raw_text = text_sb.to_string()
  let mut text = raw_text
  let mut msg_id : String? = None
  let text_cs = raw_text.to_array()
  for i in 0..<text_cs.length() {
    if text_cs[i] == '{' {
      let id_sb = StringBuilder()
      for j in (i + 1)..<text_cs.length() {
        id_sb.write_char(text_cs[j])
      }
      msg_id = Some(id_sb.to_string())
      let head = StringBuilder()
      for j in 0..<i {
        head.write_char(text_cs[j])
      }
      text = head.to_string()
      break
    }
  }
  let mut ack_id : String? = None
  if text.length() >= 3 &&
    text.to_array()[0] == 'a' &&
    text.to_array()[1] == 'c' &&
    text.to_array()[2] == 'k' {
    let id_sb = StringBuilder()
    let tc = text.to_array()
    for i in 3..<tc.length() {
      id_sb.write_char(tc[i])
    }
    let id = id_sb.to_string()
    if all_digits(id) {
      ack_id = Some(id)
    }
  }
  Ok({ addressee, text, msg_id, ack_id, })
}
