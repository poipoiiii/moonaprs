///|
/// An APRS status report (`>text`), optionally with a `DDHHMMz` timestamp.
pub struct Status {
  text : String
  timestamp : String?
}

///|
/// The status text.
pub fn Status::text_of(self : Status) -> String {
  self.text
}

///|
/// The embedded timestamp, when present.
pub fn Status::timestamp_text(self : Status) -> String? {
  self.timestamp
}

///|
/// Parse the body after `>`.
pub fn parse_status(body : String) -> Status {
  let cs = body.to_array()
  if cs.length() >= 8 {
    let mut looks_timestamp = true
    for i in 0..<6 {
      if cs[i] < '0' || cs[i] > '9' {
        looks_timestamp = false
      }
    }
    if looks_timestamp && (cs[6] == 'z' || cs[6] == '/') {
      let ts = StringBuilder()
      for i in 0..<7 {
        ts.write_char(cs[i])
      }
      let text = StringBuilder()
      for i in 7..<cs.length() {
        text.write_char(cs[i])
      }
      return { text: text.to_string(), timestamp: Some(ts.to_string()), }
    }
  }
  { text: body, timestamp: None, }
}

///|
/// An APRS object report: a named position that is not the station itself.
pub struct ObjectReport {
  name : String
  alive : Bool
  timestamp : String
  position : Position
}

///|
/// The object name.
pub fn ObjectReport::object_name(self : ObjectReport) -> String {
  self.name
}

///|
/// Whether the object is alive (`*`) or killed (`_`).
pub fn ObjectReport::is_alive(self : ObjectReport) -> Bool {
  self.alive
}

///|
/// The object timestamp.
pub fn ObjectReport::timestamp_text(self : ObjectReport) -> String {
  self.timestamp
}

///|
/// The object position.
pub fn ObjectReport::position(self : ObjectReport) -> Position {
  self.position
}

///|
/// Parse the body after `;`: nine character name, alive flag, seven character
/// timestamp, then a position without its own timestamp.
pub fn parse_object(body : String) -> Result[ObjectReport, String] {
  let cs = body.to_array()
  if cs.length() < 18 {
    return Err("object report is truncated")
  }
  let name_sb = StringBuilder()
  for i in 0..<9 {
    name_sb.write_char(cs[i])
  }
  let name = name_sb.to_string().trim().to_owned()
  if name.length() == 0 {
    return Err("object name is empty")
  }
  let alive = if cs[9] == '*' {
    true
  } else if cs[9] == '_' {
    false
  } else {
    return Err("object alive flag must be '*' or '_'")
  }
  let ts_sb = StringBuilder()
  for i in 10..<17 {
    ts_sb.write_char(cs[i])
  }
  let rest_sb = StringBuilder()
  for i in 17..<cs.length() {
    rest_sb.write_char(cs[i])
  }
  match parse_position(rest_sb.to_string(), false) {
    Ok(position) => Ok({ name, alive, timestamp: ts_sb.to_string(), position, })
    Err(e) => Err(e)
  }
}

///|
/// An APRS item report: a short named position.
pub struct ItemReport {
  name : String
  alive : Bool
  position : Position
}

///|
/// The item name.
pub fn ItemReport::item_name(self : ItemReport) -> String {
  self.name
}

///|
/// Whether the item is alive (`!`) or killed (`_`).
pub fn ItemReport::is_alive(self : ItemReport) -> Bool {
  self.alive
}

///|
/// The item position.
pub fn ItemReport::position(self : ItemReport) -> Position {
  self.position
}

///|
/// Parse the body after `)`: a name terminated by `!` (alive) or `_` (dead),
/// followed by a position without timestamp.
pub fn parse_item(body : String) -> Result[ItemReport, String] {
  let cs = body.to_array()
  let mut sep = -1
  let mut i = 0
  while i < cs.length() && i < 9 {
    if cs[i] == '!' || cs[i] == '_' {
      sep = i
      break
    }
    i = i + 1
  }
  if sep < 0 {
    return Err("item name is not terminated by '!' or '_'")
  }
  if sep == 0 {
    return Err("item name is empty")
  }
  let name_sb = StringBuilder()
  for j in 0..<sep {
    name_sb.write_char(cs[j])
  }
  let rest_sb = StringBuilder()
  for j in (sep + 1)..<cs.length() {
    rest_sb.write_char(cs[j])
  }
  match parse_position(rest_sb.to_string(), false) {
    Ok(position) =>
      Ok({ name: name_sb.to_string(), alive: cs[sep] == '!', position, })
    Err(e) => Err(e)
  }
}
