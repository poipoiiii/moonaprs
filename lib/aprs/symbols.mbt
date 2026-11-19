///|
/// A decoded APRS symbol.
pub struct SymbolInfo {
  table : Char
  code : Char
  name : String
  category : String
}

///|
/// The symbol table character from the packet.
pub fn SymbolInfo::table_char(self : SymbolInfo) -> Char {
  self.table
}

///|
/// The symbol code character from the packet.
pub fn SymbolInfo::code_char(self : SymbolInfo) -> Char {
  self.code
}

///|
/// A human readable name such as `car` or `weather station`.
pub fn SymbolInfo::name_of(self : SymbolInfo) -> String {
  self.name
}

///|
/// A coarse category: `vehicle`, `weather`, `infrastructure`, `aircraft`,
/// `marine`, `person`, `emergency` or `other`.
pub fn SymbolInfo::category_of(self : SymbolInfo) -> String {
  self.category
}

///|
fn primary_name(code : Char) -> (String, String) {
  match code {
    '!' => ("police", "emergency")
    '#' => ("digipeater", "infrastructure")
    '$' => ("phone", "infrastructure")
    '%' => ("DX cluster", "infrastructure")
    '&' => ("HF gateway", "infrastructure")
    '\'' => ("small aircraft", "aircraft")
    '(' => ("mobile satellite", "aircraft")
    ')' => ("weather station (no position)", "weather")
    '*' => ("snowmobile", "vehicle")
    '+' => ("red cross", "emergency")
    ',' => ("boy scouts", "person")
    '-' => ("house", "infrastructure")
    '.' => ("X", "other")
    '/' => ("dot", "other")
    '0' => ("circle", "other")
    ':' => ("fire", "emergency")
    ';' => ("campground", "person")
    '<' => ("motorcycle", "vehicle")
    '=' => ("train", "vehicle")
    '>' => ("car", "vehicle")
    '?' => ("server", "infrastructure")
    'A' => ("aid station", "emergency")
    'B' => ("BBS", "infrastructure")
    'C' => ("canoe", "marine")
    'E' => ("eyeglasses", "other")
    'F' => ("tractor", "vehicle")
    'G' => ("grid square", "other")
    'H' => ("hotel", "infrastructure")
    'I' => ("TCP/IP", "infrastructure")
    'K' => ("school", "infrastructure")
    'L' => ("PC user", "person")
    'M' => ("MacAPRS", "infrastructure")
    'N' => ("NTS", "infrastructure")
    'O' => ("balloon", "aircraft")
    'P' => ("police", "emergency")
    'R' => ("recreational vehicle", "vehicle")
    'S' => ("space shuttle", "aircraft")
    'T' => ("SSTV", "other")
    'U' => ("bus", "vehicle")
    'V' => ("ATV", "vehicle")
    'W' => ("weather station", "weather")
    'X' => ("helicopter", "aircraft")
    'Y' => ("yacht", "marine")
    'Z' => ("WinAPRS", "infrastructure")
    '[' => ("jogger", "person")
    '\\' => ("triangle", "other")
    ']' => ("PBBS", "infrastructure")
    '^' => ("large aircraft", "aircraft")
    '_' => ("weather station", "weather")
    '`' => ("dish antenna", "infrastructure")
    'a' => ("ambulance", "emergency")
    'b' => ("bicycle", "vehicle")
    'c' => ("incident command post", "emergency")
    'd' => ("fire department", "emergency")
    'e' => ("horse", "vehicle")
    'f' => ("fire truck", "emergency")
    'g' => ("glider", "aircraft")
    'h' => ("hospital", "emergency")
    'i' => ("ionosphere", "other")
    'j' => ("jeep", "vehicle")
    'k' => ("truck", "vehicle")
    'l' => ("laptop", "person")
    'm' => ("mic repeater", "infrastructure")
    'n' => ("node", "infrastructure")
    'o' => ("balloon", "aircraft")
    'p' => ("police", "emergency")
    'q' => ("quad", "vehicle")
    'r' => ("recreational vehicle", "vehicle")
    's' => ("ship", "marine")
    't' => ("truck", "vehicle")
    'u' => ("truck", "vehicle")
    'v' => ("van", "vehicle")
    'w' => ("water station", "weather")
    'x' => ("X", "other")
    'y' => ("yacht", "marine")
    'z' => ("WinAPRS", "infrastructure")
    _ => ("unknown", "other")
  }
}

///|
fn alternate_name(code : Char) -> (String, String) {
  match code {
    '#' => ("digipeater", "infrastructure")
    '>' => ("car", "vehicle")
    'k' => ("truck", "vehicle")
    'j' => ("jeep", "vehicle")
    'b' => ("bicycle", "vehicle")
    '_' => ("weather station", "weather")
    'W' => ("weather station", "weather")
    '-' => ("house", "infrastructure")
    'R' => ("repeater", "infrastructure")
    '&' => ("gateway", "infrastructure")
    'Y' => ("yacht", "marine")
    'A' => ("aid station", "emergency")
    'P' => ("police", "emergency")
    'S' => ("satellite", "aircraft")
    _ => primary_name(code)
  }
}

///|
/// Look up an APRS symbol. A table character other than `/` or `\` is treated
/// as an overlay on the alternate table.
pub fn symbol_info(table : Char, code : Char) -> SymbolInfo {
  let (name, category) = if table == '/' {
    primary_name(code)
  } else {
    alternate_name(code)
  }
  { table, code, name, category }
}

///|
/// Shorthand for `symbol_info(table, code).name_of()`.
pub fn symbol_name_for(table : Char, code : Char) -> String {
  symbol_info(table, code).name
}

///|
/// Shorthand for `symbol_info(table, code).category_of()`.
pub fn symbol_category_for(table : Char, code : Char) -> String {
  symbol_info(table, code).category
}
