///|
/// A packet in TNC2 monitor format, the text form used by APRS-IS and most
/// terminal programs: `SRC>DEST,PATH1,PATH2:info`.
pub struct Tnc2Packet {
  src : @ax25.Callsign
  dest : @ax25.Callsign
  path : Array[@ax25.Ax25Address]
  info : String
}

///|
/// The source callsign.
pub fn Tnc2Packet::source(self : Tnc2Packet) -> @ax25.Callsign {
  self.src
}

///|
/// The destination callsign.
pub fn Tnc2Packet::destination(self : Tnc2Packet) -> @ax25.Callsign {
  self.dest
}

///|
/// The digipeater path.
pub fn Tnc2Packet::path(self : Tnc2Packet) -> Array[@ax25.Ax25Address] {
  self.path
}

///|
/// The information field as text.
pub fn Tnc2Packet::info_field(self : Tnc2Packet) -> String {
  self.info
}

///|
/// Parse a TNC2 line.
pub fn Tnc2Packet::parse(line : String) -> Result[Tnc2Packet, String] {
  let trimmed = line.trim().to_owned()
  match split_once(trimmed, ':') {
    None => Err("missing ':' between header and information field")
    Some((header, info)) =>
      match split_once(header, '>') {
        None => Err("missing '>' between source and destination")
        Some((src_text, rest)) => {
          let src = match @ax25.Callsign::parse(src_text) {
            Some(c) => c
            None => return Err("invalid source callsign: " + src_text)
          }
          let fields = split_char(rest, ',')
          if fields.length() == 0 {
            return Err("missing destination callsign")
          }
          let dest = match @ax25.Callsign::parse(fields[0]) {
            Some(c) => c
            None => return Err("invalid destination callsign: " + fields[0])
          }
          let path : Array[@ax25.Ax25Address] = []
          for i in 1..<fields.length() {
            if fields[i].length() == 0 {
              continue
            }
            let entry = fields[i]
            let repeated = entry.length() > 0 &&
              entry.to_array()[entry.length() - 1] == '*'
            let call_text = if repeated { drop_last(entry) } else { entry }
            match @ax25.Callsign::parse(call_text) {
              Some(c) => path.push(@ax25.Ax25Address::new(c, repeated))
              None => return Err("invalid path element: " + entry)
            }
          }
          Ok({ src, dest, path, info, })
        }
      }
  }
}

///|
/// Render the packet back to TNC2 form.
pub fn Tnc2Packet::to_string(self : Tnc2Packet) -> String {
  let sb = StringBuilder()
  sb.write_string(self.src.to_string())
  sb.write_string(">")
  sb.write_string(self.dest.to_string())
  for entry in self.path {
    sb.write_string(",")
    sb.write_string(entry.callsign_of().to_string())
    if entry.is_repeated() {
      sb.write_string("*")
    }
  }
  sb.write_string(":")
  sb.write_string(self.info)
  sb.to_string()
}
