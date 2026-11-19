///|
/// APRS weather report. Every field is optional because real packets carry
/// different subsets.
pub struct Weather {
  timestamp : String?
  wind_dir : Int32?
  wind_speed : Int32?
  gust : Int32?
  temperature_f : Int32?
  rain_last_hour : Int32?
  rain_last_24h : Int32?
  rain_since_midnight : Int32?
  humidity : Int32?
  pressure_tenths_hpa : Int32?
  luminosity : Int32?
}

///|
/// Wind direction in degrees, when present.
pub fn Weather::wind_direction(self : Weather) -> Int32? {
  self.wind_dir
}

///|
/// Wind speed in miles per hour, when present.
pub fn Weather::wind_speed_mph(self : Weather) -> Int32? {
  self.wind_speed
}

///|
/// Gust speed in miles per hour, when present.
pub fn Weather::gust_mph(self : Weather) -> Int32? {
  self.gust
}

///|
/// Temperature in degrees Fahrenheit, when present.
pub fn Weather::temperature(self : Weather) -> Int32? {
  self.temperature_f
}

///|
/// Rain in the last hour, in hundredths of an inch.
pub fn Weather::rain_1h(self : Weather) -> Int32? {
  self.rain_last_hour
}

///|
/// Rain in the last 24 hours, in hundredths of an inch.
pub fn Weather::rain_24h(self : Weather) -> Int32? {
  self.rain_last_24h
}

///|
/// Rain since midnight, in hundredths of an inch.
pub fn Weather::rain_midnight(self : Weather) -> Int32? {
  self.rain_since_midnight
}

///|
/// Relative humidity in percent.
pub fn Weather::humidity(self : Weather) -> Int32? {
  self.humidity
}

///|
/// Barometric pressure in tenths of a hectopascal (e.g. 10159 = 1015.9 hPa).
pub fn Weather::pressure(self : Weather) -> Int32? {
  self.pressure_tenths_hpa
}

///|
/// Luminosity / solar radiation, in watts per square metre.
pub fn Weather::luminosity_value(self : Weather) -> Int32? {
  self.luminosity
}

///|
/// The timestamp embedded in a positionless weather report.
pub fn Weather::timestamp_text(self : Weather) -> String? {
  self.timestamp
}

///|
fn field_width(c : Char) -> Int32? {
  match c {
    'c' => Some(3)
    's' => Some(3)
    'g' => Some(3)
    't' => Some(3)
    'r' => Some(3)
    'p' => Some(3)
    'P' => Some(3)
    'h' => Some(2)
    'b' => Some(5)
    'L' => Some(3)
    'l' => Some(3)
    '#' => Some(3)
    'V' => Some(3)
    _ => None
  }
}

///|
/// Parse a weather body such as `10090556c220s004g005t077r000p000P000h50b10159`.
///
/// A leading `_` (positionless report marker) is accepted, as is an eight
/// digit `MMDDHHMM` timestamp. Unknown fields stop parsing and are ignored.
pub fn parse_weather(body : String) -> Weather {
  let text = body.trim().to_owned()
  let cs0 = text.to_array()
  let mut start = 0
  if cs0.length() > 0 && cs0[0] == '_' {
    start = 1
  }
  let cs = text.to_array()
  let mut pos = start
  let mut timestamp : String? = None
  if pos + 8 <= cs.length() {
    let sb = StringBuilder()
    let mut all_digits = true
    for i in 0..<8 {
      let c = cs[pos + i]
      if c >= '0' && c <= '9' {
        sb.write_char(c)
      } else {
        all_digits = false
      }
    }
    if all_digits {
      timestamp = Some(sb.to_string())
      pos = pos + 8
    }
  }
  let mut wind_dir : Int32? = None
  let mut wind_speed : Int32? = None
  let mut gust : Int32? = None
  let mut temperature : Int32? = None
  let mut rain_1h : Int32? = None
  let mut rain_24h : Int32? = None
  let mut rain_mid : Int32? = None
  let mut humidity : Int32? = None
  let mut pressure : Int32? = None
  let mut luminosity : Int32? = None
  while pos < cs.length() {
    let key = cs[pos]
    let width = match field_width(key) {
      Some(w) => w
      None => break
    }
    if pos + 1 + width > cs.length() {
      break
    }
    let sb = StringBuilder()
    for i in 0..<width {
      sb.write_char(cs[pos + 1 + i])
    }
    let raw = sb.to_string()
    let value = parse_int_field(raw)
    pos = pos + 1 + width
    match value {
      None => break
      Some(v) =>
        match key {
          'c' => wind_dir = Some(v)
          's' => wind_speed = Some(v)
          'g' => gust = Some(v)
          't' => temperature = Some(v)
          'r' => rain_1h = Some(v)
          'p' => rain_24h = Some(v)
          'P' => rain_mid = Some(v)
          'h' => humidity = Some(v)
          'b' => pressure = Some(v)
          'L' => luminosity = Some(v)
          'l' => if luminosity is None { luminosity = Some(v) }
          _ => ()
        }
    }
  }
  {
    timestamp,
    wind_dir,
    wind_speed,
    gust,
    temperature_f: temperature,
    rain_last_hour: rain_1h,
    rain_last_24h: rain_24h,
    rain_since_midnight: rain_mid,
    humidity,
    pressure_tenths_hpa: pressure,
    luminosity,
  }
}

///|
/// Parse the weather suffix of a position comment, i.e. the part starting at
/// the first `_`. Returns `None` when the comment has no weather suffix.
pub fn weather_from_comment(comment : String) -> Weather? {
  let cs = comment.to_array()
  for i in 0..<cs.length() {
    if cs[i] == '_' {
      let sb = StringBuilder()
      for j in i..<cs.length() {
        sb.write_char(cs[j])
      }
      return Some(parse_weather(sb.to_string()))
    }
  }
  None
}

///|
/// `true` when the `count` characters starting at `start` are all digits.
fn digits_at(cs : Array[Char], start : Int32, count : Int32) -> Bool {
  if start + count > cs.length() {
    return false
  }
  for i in 0..<count {
    let c = cs[start + i]
    if c < '0' || c > '9' {
      return false
    }
  }
  true
}

///|
/// Parse a weather comment that starts with the compact `DDD/SSS` wind prefix
/// used when the position symbol is `_`, for example `220/004g005t077`.
pub fn parse_weather_with_prefix(text : String) -> Weather {
  let cs = text.to_array()
  let mut start = 0
  if digits_at(cs, 0, 8) {
    start = 8
  }
  if digits_at(cs, start, 3) &&
    start + 6 < cs.length() &&
    cs[start + 3] == '/' &&
    digits_at(cs, start + 4, 3) {
    let sb = StringBuilder()
    sb.write_string("c")
    sb.write_string(chars_slice(text, start, start + 3))
    sb.write_string("s")
    sb.write_string(chars_slice(text, start + 4, start + 7))
    sb.write_string(chars_rest(text, start + 7))
    parse_weather(sb.to_string())
  } else {
    parse_weather(text)
  }
}

///|
/// Extract weather from a position report. A `_` symbol marks a weather
/// station; otherwise a `_` marker inside the comment is used.
pub fn weather_from_position(position : Position) -> Weather? {
  if position.symbol_code == '_' {
    if position.comment.length() == 0 {
      None
    } else {
      Some(parse_weather_with_prefix(position.comment))
    }
  } else {
    weather_from_comment(position.comment)
  }
}

///|
/// One-line summary used by the CLI and the web demo.
pub fn Weather::summary(self : Weather) -> String {
  let parts : Array[String] = []
  match self.wind_dir {
    Some(v) => parts.push("wind " + v.to_string() + "°")
    None => ()
  }
  match self.wind_speed {
    Some(v) => parts.push("speed " + v.to_string() + " mph")
    None => ()
  }
  match self.gust {
    Some(v) => parts.push("gust " + v.to_string() + " mph")
    None => ()
  }
  match self.temperature_f {
    Some(v) => parts.push("temp " + v.to_string() + "F")
    None => ()
  }
  match self.humidity {
    Some(v) => parts.push("humidity " + v.to_string() + "%")
    None => ()
  }
  match self.pressure_tenths_hpa {
    Some(v) =>
      parts.push(
        "pressure " + format_fixed(Double::from_int(v) / 10.0, 1) + " hPa",
      )
    None => ()
  }
  match self.rain_last_hour {
    Some(v) => parts.push("rain 1h " + v.to_string())
    None => ()
  }
  join_strings(parts, ", ")
}
