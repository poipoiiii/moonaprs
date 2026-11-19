///|
/// Split `s` at the first occurrence of `sep`.
pub fn split_once(s : String, sep : Char) -> (String, String)? {
  let cs = s.to_array()
  for i in 0..<cs.length() {
    if cs[i] == sep {
      let left = StringBuilder()
      let right = StringBuilder()
      for j in 0..<i {
        left.write_char(cs[j])
      }
      for j in (i + 1)..<cs.length() {
        right.write_char(cs[j])
      }
      return Some((left.to_string(), right.to_string()))
    }
  }
  None
}

///|
/// Split `s` on every occurrence of `sep`. Empty fields are preserved.
pub fn split_char(s : String, sep : Char) -> Array[String] {
  let out : Array[String] = []
  let cs = s.to_array()
  let cur = StringBuilder()
  for c in cs {
    if c == sep {
      out.push(cur.to_string())
      cur.reset()
    } else {
      cur.write_char(c)
    }
  }
  out.push(cur.to_string())
  out
}

///|
/// Join strings with a separator.
pub fn join_strings(parts : Array[String], sep : String) -> String {
  let sb = StringBuilder()
  for i in 0..<parts.length() {
    if i > 0 {
      sb.write_string(sep)
    }
    sb.write_string(parts[i])
  }
  sb.to_string()
}

///|
/// Drop the final character of a string.
pub fn drop_last(s : String) -> String {
  let cs = s.to_array()
  let sb = StringBuilder()
  if cs.length() > 0 {
    for i in 0..<(cs.length() - 1) {
      sb.write_char(cs[i])
    }
  }
  sb.to_string()
}

///|
/// The characters in `[start, end)`.
pub fn chars_slice(s : String, start : Int32, end : Int32) -> String {
  let cs = s.to_array()
  let sb = StringBuilder()
  let mut i = start
  while i < end && i < cs.length() {
    sb.write_char(cs[i])
    i = i + 1
  }
  sb.to_string()
}

///|
/// The characters from `start` to the end.
pub fn chars_rest(s : String, start : Int32) -> String {
  chars_slice(s, start, s.to_array().length())
}

///|
fn is_digit(c : Char) -> Bool {
  c >= '0' && c <= '9'
}

///|
/// Parse a run of ASCII digits. Returns `None` on any non-digit character.
pub fn parse_digits(s : String) -> Int32? {
  if s.length() == 0 {
    return None
  }
  let mut value = 0
  for c in s.to_array() {
    if !is_digit(c) {
      return None
    }
    value = value * 10 + (c.to_int() - '0'.to_int())
  }
  Some(value)
}

///|
/// Parse an optionally signed integer, as used by weather and telemetry fields.
pub fn parse_int_field(s : String) -> Int32? {
  if s.length() == 0 {
    return None
  }
  let cs = s.to_array()
  if cs[0] == '-' || cs[0] == '+' {
    let rest = StringBuilder()
    for i in 1..<cs.length() {
      rest.write_char(cs[i])
    }
    match parse_digits(rest.to_string()) {
      Some(v) => Some(if cs[0] == '-' { -v } else { v })
      None => None
    }
  } else {
    parse_digits(s)
  }
}

///|
/// `true` when every character is an ASCII digit.
pub fn all_digits(s : String) -> Bool {
  if s.length() == 0 {
    return false
  }
  for c in s.to_array() {
    if !is_digit(c) {
      return false
    }
  }
  true
}

///|
/// Format a `Double` with a fixed number of decimal places, without relying on
/// platform-specific number formatting.
pub fn format_fixed(value : Double, decimals : Int32) -> String {
  let negative = value < 0.0
  let mut scaled = value
  if negative {
    scaled = -scaled
  }
  let factor = @math.pow(10.0, Double::from_int(decimals))
  let rounded = (scaled * factor + 0.5).to_int()
  let whole = rounded / factor.to_int()
  let frac = rounded % factor.to_int()
  let sb = StringBuilder()
  if negative {
    sb.write_string("-")
  }
  sb.write_string(whole.to_string())
  if decimals > 0 {
    sb.write_string(".")
    let digits = frac.to_string()
    for _ in 0..<(decimals - digits.length()) {
      sb.write_string("0")
    }
    sb.write_string(digits)
  }
  sb.to_string()
}
