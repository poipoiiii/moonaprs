///|
/// An APRS telemetry report: `T#NAME,seq,val1,...,val5,bbbbbbbb`.
pub struct Telemetry {
  name : String
  seq : Int32
  analog : Array[Int32]
  digital : String
}

///|
/// The telemetry channel name (for example `MIC`).
pub fn Telemetry::channel(self : Telemetry) -> String {
  self.name
}

///|
/// The sequence number.
pub fn Telemetry::sequence(self : Telemetry) -> Int32 {
  self.seq
}

///|
/// The analog values in order.
pub fn Telemetry::analog_values(self : Telemetry) -> Array[Int32] {
  self.analog
}

///|
/// The eight digital bits as a string of `0`/`1`.
pub fn Telemetry::digital_bits(self : Telemetry) -> String {
  self.digital
}

///|
/// Parse the body after the `T#` prefix.
pub fn parse_telemetry(body : String) -> Result[Telemetry, String] {
  let fields = split_char(body, ',')
  if fields.length() < 2 {
    return Err("telemetry needs a name and a sequence number")
  }
  let name = fields[0]
  if name.length() == 0 {
    return Err("telemetry channel name is empty")
  }
  let seq = match parse_digits(fields[1]) {
    Some(v) => v
    None => return Err("telemetry sequence is not a number")
  }
  let analog : Array[Int32] = []
  let mut digital = ""
  for i in 2..<fields.length() {
    let field = fields[i]
    if field.length() == 8 && all_digits(field) && i == fields.length() - 1 {
      digital = field
    } else {
      match parse_int_field(field) {
        Some(v) => analog.push(v)
        None => return Err("telemetry value is not a number: " + field)
      }
    }
  }
  Ok({ name, seq, analog, digital, })
}

///|
/// Render the telemetry report in APRS form (without the `T#` prefix).
pub fn Telemetry::to_string(self : Telemetry) -> String {
  let parts : Array[String] = [self.name, self.seq.to_string()]
  for v in self.analog {
    parts.push(v.to_string())
  }
  if self.digital.length() > 0 {
    parts.push(self.digital)
  }
  join_strings(parts, ",")
}
