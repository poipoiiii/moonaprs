///|
/// An amateur radio callsign with an optional SSID.
///
/// Callsigns are stored upper-cased. `N0CALL`, `N0CALL-9` and `n0call-09` all
/// normalise to the same value (`N0CALL`, SSID 9).
pub struct Callsign {
  call : String
  ssid : Int32
} derive(Eq, Debug)

///|
pub extend Callsign with Eq::{not_equal, equal}

///|
pub extend Callsign with @moonbitlang/core/debug.Debug::{to_repr}

///|
fn normalize_call(raw : String) -> String {
  let sb = StringBuilder()
  for c in raw.trim() {
    if c >= 'a' && c <= 'z' {
      sb.write_char(c.to_ascii_uppercase())
    } else if (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') {
      sb.write_char(c)
    }
  }
  sb.to_string()
}

///|
/// Build a callsign, normalising the base call to upper case.
pub fn Callsign::new(call : String, ssid : Int32) -> Callsign {
  { call: normalize_call(call), ssid, }
}

///|
/// Parse `CALL` or `CALL-SSID`. Returns `None` for malformed input: an empty
/// base call, a base call longer than 6 characters, or an SSID outside 0-15.
pub fn Callsign::parse(raw : String) -> Callsign? {
  let parts : Array[StringView] = raw.trim().split("-").collect()
  let call = normalize_call(parts[0].to_owned())
  if call.length() == 0 || call.length() > 6 {
    return None
  }
  let mut ssid = 0
  if parts.length() >= 2 {
    let digits = parts[1].to_owned()
    if digits.length() == 0 || digits.length() > 2 {
      return None
    }
    ssid = @string.parse_int(digits) catch { _ => return None }
    if ssid < 0 || ssid > 15 {
      return None
    }
  }
  Some({ call, ssid, })
}

///|
/// The base call without the SSID suffix.
pub fn Callsign::base_call(self : Callsign) -> String {
  self.call
}

///|
/// `CALL` when the SSID is zero, otherwise `CALL-SSID`.
pub fn Callsign::to_string(self : Callsign) -> String {
  if self.ssid == 0 {
    self.call
  } else {
    self.call + "-" + self.ssid.to_string()
  }
}

///|
/// The six characters written in the AX.25 address field, space padded.
pub fn Callsign::field_chars(self : Callsign) -> Array[Char] {
  let out : Array[Char] = []
  let chars = self.call.to_array()
  for i in 0..<6 {
    if i < chars.length() {
      out.push(chars[i])
    } else {
      out.push(' ')
    }
  }
  out
}

///|
/// Decode the six shifted characters of an AX.25 address field.
pub fn Callsign::from_field(bytes : Array[Byte]) -> Callsign? {
  let sb = StringBuilder()
  let mut i = 0
  while i < 6 && i < bytes.length() {
    let c = (bytes[i].to_int() >> 1).unsafe_to_char()
    if c == ' ' {
      i = 6
    } else {
      sb.write_char(c)
      i = i + 1
    }
  }
  let call = sb.to_string()
  if call.length() == 0 {
    None
  } else {
    Some({ call, ssid: 0, })
  }
}
