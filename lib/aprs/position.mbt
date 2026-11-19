///|
/// A parsed APRS position report.
pub struct Position {
  lat : Double
  lon : Double
  symbol_table : Char
  symbol_code : Char
  comment : String
  ambiguity : Int32
  timestamp : String?
  compressed : Bool
}

///|
/// Latitude in decimal degrees, positive north.
pub fn Position::latitude(self : Position) -> Double {
  self.lat
}

///|
/// Longitude in decimal degrees, positive east.
pub fn Position::longitude(self : Position) -> Double {
  self.lon
}

///|
/// The APRS symbol table identifier (`/`, `\`, or an overlay character).
pub fn Position::table(self : Position) -> Char {
  self.symbol_table
}

///|
/// The APRS symbol code.
pub fn Position::symbol(self : Position) -> Char {
  self.symbol_code
}

///|
/// The free-form comment that follows the position.
pub fn Position::comment_text(self : Position) -> String {
  self.comment
}

///|
/// Number of ambiguous digits that were blanked in the report (0 = exact).
pub fn Position::ambiguity_digits(self : Position) -> Int32 {
  self.ambiguity
}

///|
/// The raw timestamp, when the report carried one.
pub fn Position::timestamp_text(self : Position) -> String? {
  self.timestamp
}

///|
/// Whether the report used the compressed position format.
pub fn Position::is_compressed(self : Position) -> Bool {
  self.compressed
}

///|
fn digit_value(c : Char) -> Int32? {
  if c >= '0' && c <= '9' {
    Some(c.to_int() - '0'.to_int())
  } else {
    None
  }
}

///|
/// Decode `count` characters of base-91 (each character is the value plus 33).
fn base91_value(cs : Array[Char], start : Int32, count : Int32) -> Int32? {
  let mut value = 0
  for i in 0..<count {
    let c = cs[start + i]
    let v = c.to_int() - 33
    if v < 0 || v > 90 {
      return None
    }
    value = value * 91 + v
  }
  Some(value)
}

///|
fn parse_lat(
  cs : Array[Char],
  start : Int32,
) -> Result[(Double, Int32), String] {
  if start + 8 > cs.length() {
    return Err("latitude is truncated")
  }
  let mut value = 0.0
  let mut ambiguity = 0
  // ddmm.hh
  for i in 0..<7 {
    if i == 4 {
      if cs[start + i] != '.' {
        return Err("latitude is missing the decimal point")
      }
      continue
    }
    let c = cs[start + i]
    if c == ' ' {
      ambiguity = ambiguity + 1
    } else {
      match digit_value(c) {
        Some(d) => {
          let weight = match i {
            0 => 10.0
            1 => 1.0
            2 => 1.0 / 6.0
            3 => 1.0 / 60.0
            5 => 1.0 / 600.0
            _ => 1.0 / 6000.0
          }
          value = value + Double::from_int(d) * weight
        }
        None => return Err("latitude contains a non-digit")
      }
    }
  }
  let hemi = cs[start + 7]
  let signed = if hemi == 'N' || hemi == 'n' {
    value
  } else if hemi == 'S' || hemi == 's' {
    -value
  } else {
    return Err("latitude hemisphere must be N or S")
  }
  Ok((signed, ambiguity))
}

///|
fn parse_lon(
  cs : Array[Char],
  start : Int32,
) -> Result[(Double, Int32), String] {
  if start + 9 > cs.length() {
    return Err("longitude is truncated")
  }
  let mut value = 0.0
  let mut ambiguity = 0
  // dddmm.hh
  for i in 0..<8 {
    if i == 5 {
      if cs[start + i] != '.' {
        return Err("longitude is missing the decimal point")
      }
      continue
    }
    let c = cs[start + i]
    if c == ' ' {
      ambiguity = ambiguity + 1
    } else {
      match digit_value(c) {
        Some(d) => {
          let weight = match i {
            0 => 100.0
            1 => 10.0
            2 => 1.0
            3 => 1.0 / 6.0
            4 => 1.0 / 60.0
            6 => 1.0 / 600.0
            _ => 1.0 / 6000.0
          }
          value = value + Double::from_int(d) * weight
        }
        None => return Err("longitude contains a non-digit")
      }
    }
  }
  let hemi = cs[start + 8]
  let signed = if hemi == 'E' || hemi == 'e' {
    value
  } else if hemi == 'W' || hemi == 'w' {
    -value
  } else {
    return Err("longitude hemisphere must be E or W")
  }
  Ok((signed, ambiguity))
}

///|
fn chars_from(cs : Array[Char], start : Int32) -> String {
  let sb = StringBuilder()
  for i in start..<cs.length() {
    sb.write_char(cs[i])
  }
  sb.to_string()
}

///|
fn looks_like_timestamp(cs : Array[Char]) -> Bool {
  if cs.length() < 8 {
    return false
  }
  for i in 0..<6 {
    if digit_value(cs[i]) is None {
      return false
    }
  }
  cs[6] == 'z' || cs[6] == '/'
}

///|
fn parse_uncompressed(
  cs : Array[Char],
  start : Int32,
  timestamp : String?,
) -> Result[Position, String] {
  match parse_lat(cs, start) {
    Err(e) => Err(e)
    Ok((lat, lat_amb)) => {
      let table_pos = start + 8
      match parse_lon(cs, table_pos + 1) {
        Err(e) => Err(e)
        Ok((lon, lon_amb)) => {
          let symbol_pos = table_pos + 10
          if symbol_pos >= cs.length() {
            return Err("symbol is missing")
          }
          Ok({
            lat,
            lon,
            symbol_table: cs[table_pos],
            symbol_code: cs[symbol_pos],
            comment: chars_from(cs, symbol_pos + 1),
            ambiguity: if lat_amb > lon_amb {
              lat_amb
            } else {
              lon_amb
            },
            timestamp,
            compressed: false,
          })
        }
      }
    }
  }
}

///|
fn parse_compressed(
  cs : Array[Char],
  start : Int32,
  timestamp : String?,
) -> Result[Position, String] {
  if start + 13 > cs.length() {
    return Err("compressed position is truncated")
  }
  let lat_v = match base91_value(cs, start + 1, 4) {
    Some(v) => v
    None => return Err("invalid base-91 latitude")
  }
  let lon_v = match base91_value(cs, start + 5, 4) {
    Some(v) => v
    None => return Err("invalid base-91 longitude")
  }
  let lat = 90.0 - Double::from_int(lat_v) / 380926.0
  let lon = -180.0 + Double::from_int(lon_v) / 190463.0
  Ok({
    lat,
    lon,
    symbol_table: cs[start],
    symbol_code: cs[start + 9],
    comment: chars_from(cs, start + 13),
    ambiguity: 0,
    timestamp,
    compressed: true,
  })
}

///|
/// Parse the body of a position report.
///
/// `body` is the information field with the APRS data type identifier removed.
/// When `allow_timestamp` is true the body may start with a seven character
/// `DDHHMMz` / `DDHHMM/` timestamp, as used by the `/` and `@` data types.
pub fn parse_position(
  body : String,
  allow_timestamp : Bool,
) -> Result[Position, String] {
  let cs = body.to_array()
  if cs.length() == 0 {
    return Err("empty position report")
  }
  let mut start = 0
  let mut timestamp : String? = None
  if allow_timestamp && looks_like_timestamp(cs) {
    let sb = StringBuilder()
    for i in 0..<7 {
      sb.write_char(cs[i])
    }
    timestamp = Some(sb.to_string())
    start = 7
  }
  if start >= cs.length() {
    return Err("position is missing after the timestamp")
  }
  let first = cs[start]
  if first == '/' ||
    first == '\\' ||
    (first >= 'A' && first <= 'Z') ||
    (first >= 'a' && first <= 'z') {
    parse_compressed(cs, start, timestamp)
  } else if digit_value(first) is Some(_) {
    parse_uncompressed(cs, start, timestamp)
  } else {
    Err("unsupported position encoding")
  }
}

///|
fn format_lat(lat : Double) -> String {
  let hemi = if lat < 0.0 { "S" } else { "N" }
  let value = if lat < 0.0 { -lat } else { lat }
  let deg = value.to_int()
  let minutes = (value - Double::from_int(deg)) * 60.0
  let whole_min = minutes.to_int()
  let hundredths = ((minutes - Double::from_int(whole_min)) * 100.0 + 0.5).to_int()
  let sb = StringBuilder()
  if deg < 10 {
    sb.write_string("0")
  }
  sb.write_string(deg.to_string())
  if whole_min < 10 {
    sb.write_string("0")
  }
  sb.write_string(whole_min.to_string())
  sb.write_string(".")
  if hundredths < 10 {
    sb.write_string("0")
  }
  sb.write_string(hundredths.to_string())
  sb.write_string(hemi)
  sb.to_string()
}

///|
fn format_lon(lon : Double) -> String {
  let hemi = if lon < 0.0 { "W" } else { "E" }
  let value = if lon < 0.0 { -lon } else { lon }
  let deg = value.to_int()
  let minutes = (value - Double::from_int(deg)) * 60.0
  let whole_min = minutes.to_int()
  let hundredths = ((minutes - Double::from_int(whole_min)) * 100.0 + 0.5).to_int()
  let sb = StringBuilder()
  if deg < 100 {
    sb.write_string("0")
  }
  if deg < 10 {
    sb.write_string("0")
  }
  sb.write_string(deg.to_string())
  if whole_min < 10 {
    sb.write_string("0")
  }
  sb.write_string(whole_min.to_string())
  sb.write_string(".")
  if hundredths < 10 {
    sb.write_string("0")
  }
  sb.write_string(hundredths.to_string())
  sb.write_string(hemi)
  sb.to_string()
}

///|
/// Render the position in uncompressed APRS form, optionally including the
/// timestamp.
pub fn Position::to_uncompressed(self : Position) -> String {
  let sb = StringBuilder()
  match self.timestamp {
    Some(ts) => sb.write_string(ts)
    None => ()
  }
  sb.write_string(format_lat(self.lat))
  sb.write_string(self.symbol_table.to_string())
  sb.write_string(format_lon(self.lon))
  sb.write_string(self.symbol_code.to_string())
  sb.write_string(self.comment)
  sb.to_string()
}
