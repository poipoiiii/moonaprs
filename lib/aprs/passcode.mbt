///|
/// Compute the APRS-IS passcode for a callsign.
///
/// The SSID is ignored, letters are upper-cased and only `A-Z` / `0-9` are
/// accepted in the base call. The algorithm is the one published in the
/// APRS-IS specification: start with 0x73E2 and XOR character pairs, most
/// significant byte first, then keep the low 15 bits.
pub fn passcode(callsign : String) -> Result[Int32, String] {
  let parts = split_char(callsign.trim().to_owned(), '-')
  if parts.length() == 0 {
    return Err("empty callsign")
  }
  let base = parts[0].to_array()
  if base.length() == 0 || base.length() > 6 {
    return Err("callsign must be 1-6 characters")
  }
  let mut hash = 0x73E2
  let mut i = 0
  while i < base.length() {
    let c = base[i].to_ascii_uppercase()
    if !((c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9')) {
      return Err("callsign contains an invalid character")
    }
    hash = hash ^ (c.to_int() << 8)
    if i + 1 < base.length() {
      let d = base[i + 1].to_ascii_uppercase()
      if !((d >= 'A' && d <= 'Z') || (d >= '0' && d <= '9')) {
        return Err("callsign contains an invalid character")
      }
      hash = hash ^ d.to_int()
    }
    i = i + 2
  }
  Ok(hash & 0x7FFF)
}

///|
/// `true` when the callsign is a valid APRS-IS login identity (`-1` or `-15`
/// style SSIDs are allowed).
pub fn is_valid_login_call(callsign : String) -> Bool {
  match passcode(callsign) {
    Ok(_) => true
    Err(_) => false
  }
}

///|
/// Build the APRS-IS login line.
///
/// Pass `-1` as the passcode for a receive-only connection. `filter`, when
/// non-empty, is appended as an APRS-IS filter expression.
pub fn login_line(callsign : String, code : Int32, filter : String) -> String {
  let sb = StringBuilder()
  sb.write_string("user ")
  sb.write_string(callsign)
  sb.write_string(" pass ")
  sb.write_string(code.to_string())
  sb.write_string(" vers MoonAPRS 0.6.0")
  if filter.length() > 0 {
    sb.write_string(" filter ")
    sb.write_string(filter)
  }
  sb.to_string()
}
