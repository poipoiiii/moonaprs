///|
/// A decoded Mic-E position report.
///
/// Mic-E packs latitude into the AX.25 destination address and longitude, speed
/// and course into the first bytes of the information field. It is the default
/// beacon format of Kenwood and Yaesu handhelds.
pub struct MicE {
  lat : Double
  lon : Double
  speed_knots : Int32
  course_deg : Int32
  symbol_table : Char
  symbol_code : Char
  status : String
  message_bits : Int32
  current_fix : Bool
  ambiguity : Int32
}

///|
pub fn MicE::latitude(self : MicE) -> Double {
  self.lat
}

///|
pub fn MicE::longitude(self : MicE) -> Double {
  self.lon
}

///|
/// Speed over ground in knots (0 when the radio did not report one).
pub fn MicE::speed_knots(self : MicE) -> Int32 {
  self.speed_knots
}

///|
/// Course over ground in degrees (0 when unknown).
pub fn MicE::course(self : MicE) -> Int32 {
  self.course_deg
}

///|
pub fn MicE::table(self : MicE) -> Char {
  self.symbol_table
}

///|
pub fn MicE::symbol(self : MicE) -> Char {
  self.symbol_code
}

///|
/// Free text after the symbol pair.
pub fn MicE::status_text(self : MicE) -> String {
  self.status
}

///|
/// The three Mic-E message bits (A, B, C) as a value from 0 to 7.
pub fn MicE::message_code(self : MicE) -> Int32 {
  self.message_bits
}

///|
/// Whether the radio reported a current GPS fix (`) or an old one (').
pub fn MicE::has_current_fix(self : MicE) -> Bool {
  self.current_fix
}

///|
/// Number of ambiguous latitude digits (0 = exact).
pub fn MicE::ambiguity_digits(self : MicE) -> Int32 {
  self.ambiguity
}

///|
/// Decode one destination address character into (digit, flag).
fn mice_char(c : Char) -> (Int32, Bool)? {
  let u = c.to_ascii_uppercase()
  if u >= '0' && u <= '9' {
    Some((u.to_int() - '0'.to_int(), false))
  } else if u >= 'A' && u <= 'J' {
    Some((u.to_int() - 'A'.to_int(), true))
  } else if u >= 'P' && u <= 'Y' {
    Some((u.to_int() - 'P'.to_int(), true))
  } else if u == 'K' || u == 'L' || u == 'Z' {
    // Space / position ambiguity.
    Some((0, false))
  } else {
    None
  }
}

///|
/// Parse a Mic-E information field. `dest` is the destination callsign of the
/// AX.25 frame, which carries the latitude.
pub fn parse_mice(dest : String, info : String) -> Result[MicE, String] {
  let ds = dest.to_array()
  if ds.length() < 6 {
    return Err("Mic-E destination must have six characters")
  }
  let cs = info.to_array()
  if cs.length() < 9 {
    return Err("Mic-E information field is truncated")
  }
  let dti = cs[0]
  if dti != '`' && dti != '\'' {
    return Err("Mic-E information field must start with '`' or '\\''")
  }
  let mut lat_digits = 0
  let mut ambiguity = 0
  let flags : Array[Bool] = []
  for i in 0..<6 {
    match mice_char(ds[i]) {
      Some((digit, flag)) =>
        if i < 3 {
          lat_digits = lat_digits * 10 + digit
          flags.push(flag)
        } else {
          if flag {
            flags.push(true)
          } else {
            // Distinguish explicit digits from ambiguity characters.
            let upper = ds[i].to_ascii_uppercase()
            if upper == 'K' || upper == 'L' || upper == 'Z' {
              ambiguity = ambiguity + 1
            }
            flags.push(false)
          }
          lat_digits = lat_digits * 10 + digit
        }
      None =>
        return Err("invalid Mic-E destination character: " + ds[i].to_string())
    }
  }
  // Latitude is ddmmhh with hundredths of a minute.
  let lat_deg = lat_digits / 10000
  let lat_min = lat_digits / 100 % 100
  let lat_hh = lat_digits % 100
  if lat_deg > 90 || lat_min > 59 {
    return Err("Mic-E latitude out of range")
  }
  let mut lat = Double::from_int(lat_deg) +
    Double::from_int(lat_min) / 60.0 +
    Double::from_int(lat_hh) / 6000.0
  let north = flags[3]
  if !north {
    lat = -lat
  }
  // Longitude: three bytes offset by 28.
  let mut lon_deg = cs[1].to_int() - 28
  let lon_min = cs[2].to_int() - 28
  let lon_hh = cs[3].to_int() - 28
  if lon_deg < 0 || lon_min < 0 || lon_hh < 0 {
    return Err("invalid Mic-E longitude byte")
  }
  if lon_min > 59 || lon_hh > 99 {
    return Err("Mic-E longitude out of range")
  }
  if flags[4] {
    lon_deg = lon_deg + 100
  }
  if lon_deg > 180 {
    return Err("Mic-E longitude out of range")
  }
  let mut lon = Double::from_int(lon_deg) +
    Double::from_int(lon_min) / 60.0 +
    Double::from_int(lon_hh) / 6000.0
  if flags[5] {
    lon = -lon
  }
  // Speed and course bytes.
  let v4 = cs[4].to_int() - 28
  let v5 = cs[5].to_int() - 28
  let v6 = cs[6].to_int() - 28
  if v4 < 0 || v5 < 0 || v6 < 0 {
    return Err("invalid Mic-E speed/course byte")
  }
  let mut speed = v4 * 10 + v5 / 10
  if speed >= 800 {
    speed = speed - 800
  } else if speed >= 600 {
    speed = speed - 600
  }
  let mut course = v5 % 10 * 100 + v6
  if course >= 400 {
    course = course - 400
  }
  let status_sb = StringBuilder()
  for i in 9..<cs.length() {
    status_sb.write_char(cs[i])
  }
  Ok({
    lat,
    lon,
    speed_knots: speed,
    course_deg: course,
    symbol_code: cs[7],
    symbol_table: cs[8],
    status: status_sb.to_string(),
    message_bits: (if flags[0] { 4 } else { 0 }) +
    (if flags[1] { 2 } else { 0 }) +
    (if flags[2] { 1 } else { 0 }),
    current_fix: dti == '`',
    ambiguity,
  })
}
