///|
/// One address in the AX.25 digipeater path, with its "has been repeated" flag.
pub struct Ax25Address {
  callsign : Callsign
  repeated : Bool
} derive(Eq, Debug)

///|
pub extend Ax25Address with Eq::{not_equal, equal}

///|
pub extend Ax25Address with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Build a path entry.
pub fn Ax25Address::new(callsign : Callsign, repeated : Bool) -> Ax25Address {
  { callsign, repeated, }
}

///|
/// The callsign of this path entry.
pub fn Ax25Address::callsign_of(self : Ax25Address) -> Callsign {
  self.callsign
}

///|
/// Whether a digipeater has already repeated this frame.
pub fn Ax25Address::is_repeated(self : Ax25Address) -> Bool {
  self.repeated
}

///|
/// A decoded AX.25 frame.
///
/// APRS uses UI frames (`control = 0x03`, `pid = 0xF0`), which is what
/// `Ax25Frame::ui` builds. Other control field types are preserved on decode so
/// that non-APRS traffic can still be inspected.
pub struct Ax25Frame {
  dest : Callsign
  src : Callsign
  digipeaters : Array[Ax25Address]
  control : Int32
  pid : Int32?
  info : Array[Byte]
}

///|
/// The destination callsign.
pub fn Ax25Frame::dest_callsign(self : Ax25Frame) -> Callsign {
  self.dest
}

///|
/// The source callsign.
pub fn Ax25Frame::src_callsign(self : Ax25Frame) -> Callsign {
  self.src
}

///|
/// The digipeater path in order.
pub fn Ax25Frame::path(self : Ax25Frame) -> Array[Ax25Address] {
  self.digipeaters
}

///|
/// The information field as raw bytes.
pub fn Ax25Frame::info_bytes(self : Ax25Frame) -> Array[Byte] {
  self.info
}

///|
/// The decoded control field.
pub fn Ax25Frame::control_field(self : Ax25Frame) -> Int32 {
  self.control
}

///|
/// The protocol identifier, when the control field carries one.
pub fn Ax25Frame::pid_field(self : Ax25Frame) -> Int32? {
  self.pid
}

///|
/// Build an APRS style UI frame.
pub fn Ax25Frame::ui(
  src : Callsign,
  dest : Callsign,
  path : Array[Callsign],
  info : Array[Byte],
) -> Ax25Frame {
  let digis : Array[Ax25Address] = []
  for c in path {
    digis.push({ callsign: c, repeated: false, })
  }
  { dest, src, digipeaters: digis, control: 0x03, pid: Some(0xF0), info, }
}

///|
/// Whether this frame is a UI frame.
pub fn Ax25Frame::is_ui(self : Ax25Frame) -> Bool {
  (self.control & 0x03) == 0x03
}

///|
/// Whether this frame carries a PID field (I frames and UI frames).
fn has_pid(control : Int32) -> Bool {
  (control & 0x01) == 0 || (control & 0x03) == 0x03
}

///|
fn encode_address(
  cs : Callsign,
  ssid_flags : Int32,
  last : Bool,
) -> Array[Byte] {
  let out : Array[Byte] = []
  for c in cs.field_chars() {
    out.push((c.to_int() << 1).to_byte())
  }
  let ext = if last { 1 } else { 0 }
  out.push((ssid_flags | (cs.ssid << 1) | ext).to_byte())
  out
}

///|
/// Encode the frame, including the trailing frame check sequence, ready for a
/// TNC or a KISS stream.
pub fn Ax25Frame::encode(self : Ax25Frame) -> Array[Byte] {
  let out : Array[Byte] = []
  let n = self.digipeaters.length()
  // Destination: reserved bits set, command bit (0x80) set for command frames.
  for b in encode_address(self.dest, 0xE0, false) {
    out.push(b)
  }
  for b in encode_address(self.src, 0x60, n == 0) {
    out.push(b)
  }
  for i in 0..<n {
    let digi = self.digipeaters[i]
    let flags = 0x60 | (if digi.repeated { 0x80 } else { 0x00 })
    for b in encode_address(digi.callsign, flags, i == n - 1) {
      out.push(b)
    }
  }
  out.push(self.control.to_byte())
  match self.pid {
    Some(p) => if has_pid(self.control) { out.push(p.to_byte()) }
    None => ()
  }
  for b in self.info {
    out.push(b)
  }
  append_fcs(out)
}

///|
fn decode_address_field(
  body : Array[Byte],
) -> Result[(Array[(Callsign, Int32)], Int32), String] {
  let addresses : Array[(Callsign, Int32)] = []
  let mut pos = 0
  let mut done = false
  while !done {
    if pos + 7 > body.length() {
      return Err("address field is truncated")
    }
    let chunk : Array[Byte] = []
    for i in 0..<6 {
      chunk.push(body[pos + i])
    }
    let ssid_byte = body[pos + 6].to_int()
    let ssid = (ssid_byte >> 1) & 0x0F
    match Callsign::from_field(chunk) {
      Some(cs) => addresses.push(({ call: cs.call, ssid, }, ssid_byte))
      None => return Err("address field has an empty callsign")
    }
    pos = pos + 7
    if (ssid_byte & 0x01) != 0 {
      done = true
    }
    if addresses.length() > 10 {
      return Err("too many addresses in the path")
    }
  }
  if addresses.length() < 2 {
    return Err("address field needs at least a source and a destination")
  }
  Ok((addresses, pos))
}

///|
/// Decode the body of a frame (addresses, control, optional PID, info), with no
/// trailing FCS.
pub fn decode_unchecked(body : Array[Byte]) -> Result[Ax25Frame, String] {
  match decode_address_field(body) {
    Err(e) => Err(e)
    Ok((addresses, start)) => {
      let mut pos = start
      if pos >= body.length() {
        return Err("control field is missing")
      }
      let control = body[pos].to_int()
      pos = pos + 1
      let mut pid : Int32? = None
      if has_pid(control) {
        if pos >= body.length() {
          return Err("PID field is missing")
        }
        pid = Some(body[pos].to_int())
        pos = pos + 1
      }
      let info : Array[Byte] = []
      while pos < body.length() {
        info.push(body[pos])
        pos = pos + 1
      }
      let digis : Array[Ax25Address] = []
      for i in 2..<addresses.length() {
        let (cs, ssid_byte) = addresses[i]
        digis.push({ callsign: cs, repeated: (ssid_byte & 0x80) != 0, })
      }
      Ok({
        dest: addresses[0].0,
        src: addresses[1].0,
        digipeaters: digis,
        control,
        pid,
        info,
      })
    }
  }
}

///|
/// Decode a wire frame, verifying and removing the trailing FCS.
pub fn decode(raw : Array[Byte]) -> Result[Ax25Frame, String] {
  match strip_fcs(raw) {
    None => Err("frame check sequence mismatch or frame too short")
    Some(body) => decode_unchecked(body)
  }
}

///|
/// Render the frame in TNC2 monitor format (`SRC>DEST,PATH:info`).
pub fn Ax25Frame::to_tnc2(self : Ax25Frame) -> String {
  let sb = StringBuilder()
  sb.write_string(self.src.to_string())
  sb.write_string(">")
  sb.write_string(self.dest.to_string())
  for digi in self.digipeaters {
    sb.write_string(",")
    sb.write_string(digi.callsign.to_string())
    if digi.repeated {
      sb.write_string("*")
    }
  }
  sb.write_string(":")
  for b in self.info {
    sb.write_char(b.to_int().unsafe_to_char())
  }
  sb.to_string()
}
