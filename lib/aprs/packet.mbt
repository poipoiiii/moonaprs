///|
/// The decoded payload of an APRS packet.
pub(all) enum AprsBody {
  Position(Position)
  PositionWithWeather(Position, Weather)
  Weather(Weather)
  Telemetry(Telemetry)
  Status(Status)
  Message(Message)
  Object(ObjectReport)
  Item(ItemReport)
  MicE(MicE)
  Query(String)
  ThirdParty(String)
  Unknown(String)
}

///|
/// A TNC2 packet together with its decoded APRS payload.
pub struct AprsPacket {
  header : Tnc2Packet
  body : AprsBody
}

///|
/// The TNC2 header (source, destination, path).
pub fn AprsPacket::header(self : AprsPacket) -> Tnc2Packet {
  self.header
}

///|
/// The decoded payload.
pub fn AprsPacket::body(self : AprsPacket) -> AprsBody {
  self.body
}

///|
/// Parse an information field, with the APRS data type identifier still
/// present.
pub fn parse_info(info : String) -> Result[AprsBody, String] {
  parse_info_with_dest(info, "")
}

///|
/// Parse an information field using the AX.25 destination address, which is
/// required to decode Mic-E latitude.
pub fn parse_info_with_dest(
  info : String,
  dest : String,
) -> Result[AprsBody, String] {
  let cs = info.to_array()
  if cs.length() == 0 {
    return Err("empty information field")
  }
  let kind = cs[0]
  match kind {
    '`' | '\'' =>
      if dest.length() == 0 {
        Err("Mic-E packet requires the AX.25 destination address")
      } else {
        match parse_mice(dest, info) {
          Ok(m) => Ok(MicE(m))
          Err(e) => Err(e)
        }
      }
    '!' => position_body(chars_rest(info, 1), false)
    '=' => position_body(chars_rest(info, 1), false)
    '/' => position_body(chars_rest(info, 1), true)
    '@' => position_body(chars_rest(info, 1), true)
    ';' =>
      match parse_object(chars_rest(info, 1)) {
        Ok(o) => Ok(Object(o))
        Err(e) => Err(e)
      }
    ')' =>
      match parse_item(chars_rest(info, 1)) {
        Ok(i) => Ok(Item(i))
        Err(e) => Err(e)
      }
    '>' => Ok(Status(parse_status(chars_rest(info, 1))))
    '_' => Ok(Weather(parse_weather(info)))
    'T' => {
      let rest = chars_rest(info, 1)
      if rest.length() > 0 && rest.to_array()[0] == '#' {
        match parse_telemetry(chars_rest(rest, 1)) {
          Ok(t) => Ok(Telemetry(t))
          Err(e) => Err(e)
        }
      } else {
        Ok(Unknown(info))
      }
    }
    ':' =>
      match parse_message(chars_rest(info, 1)) {
        Ok(m) => Ok(Message(m))
        Err(e) => Err(e)
      }
    '?' => Ok(Query(chars_rest(info, 1)))
    '}' => Ok(ThirdParty(chars_rest(info, 1)))
    _ => Ok(Unknown(info))
  }
}

///|
fn position_body(
  body : String,
  allow_timestamp : Bool,
) -> Result[AprsBody, String] {
  match parse_position(body, allow_timestamp) {
    Err(e) => Err(e)
    Ok(position) =>
      match weather_from_position(position) {
        Some(weather) => Ok(PositionWithWeather(position, weather))
        None => Ok(Position(position))
      }
  }
}

///|
/// Parse a full TNC2 line into a header and a decoded payload.
pub fn AprsPacket::parse(line : String) -> Result[AprsPacket, String] {
  match Tnc2Packet::parse(line) {
    Err(e) => Err(e)
    Ok(header) =>
      match
        parse_info_with_dest(
          header.info_field(),
          header.destination().base_call(),
        ) {
        Ok(body) => Ok({ header, body, })
        Err(e) => Err(e)
      }
  }
}

///|
/// Render the packet back to a TNC2 line.
pub fn AprsPacket::to_tnc2(self : AprsPacket) -> String {
  self.header.to_string()
}

///|
/// A short human readable description of the payload, used by the CLI.
pub fn AprsBody::describe(self : AprsBody) -> String {
  match self {
    Position(p) =>
      "position " +
      format_fixed(p.latitude(), 4) +
      "," +
      format_fixed(p.longitude(), 4)
    PositionWithWeather(p, w) =>
      "position " +
      format_fixed(p.latitude(), 4) +
      "," +
      format_fixed(p.longitude(), 4) +
      " (" +
      w.summary() +
      ")"
    Weather(w) => "weather " + w.summary()
    Telemetry(t) => "telemetry " + t.to_string()
    Status(s) => "status " + s.text_of()
    Message(m) =>
      if m.is_ack() {
        "ack " + m.acked_id().unwrap()
      } else {
        "message to " + m.to_call() + ": " + m.body()
      }
    Object(o) =>
      "object " + o.object_name() + " " + o.position().to_uncompressed()
    Item(i) => "item " + i.item_name() + " " + i.position().to_uncompressed()
    MicE(m) =>
      "mic-e position " +
      format_fixed(m.latitude(), 4) +
      "," +
      format_fixed(m.longitude(), 4) +
      " " +
      m.speed_knots().to_string() +
      "kn " +
      m.course().to_string() +
      "°"
    Query(q) => "query " + q
    ThirdParty(inner) => "third-party " + inner
    Unknown(text) => "unknown " + text
  }
}
