///|
/// A KISS frame: the TNC port, the command nibble and the raw payload.
///
/// APRS data frames use command 0, so `payload` is the AX.25 frame including
/// its FCS.
pub struct KissFrame {
  port : Int32
  command : Int32
  payload : Array[Byte]
}

///|
/// The TNC port number.
pub fn KissFrame::port_number(self : KissFrame) -> Int32 {
  self.port
}

///|
/// The KISS command nibble (0 for data frames).
pub fn KissFrame::command_code(self : KissFrame) -> Int32 {
  self.command
}

///|
/// The payload, i.e. the AX.25 frame bytes.
pub fn KissFrame::payload_bytes(self : KissFrame) -> Array[Byte] {
  self.payload
}

///|
/// The KISS frame delimiter.
pub let kiss_fend : Byte = b'\xC0'

///|
/// The KISS escape byte.
pub let kiss_fesc : Byte = b'\xDB'

///|
/// Escaped representation of 0xC0.
pub let kiss_tfend : Byte = b'\xDC'

///|
/// Escaped representation of 0xDB.
pub let kiss_tfesc : Byte = b'\xDD'

///|
/// Encode one KISS frame, framed by 0xC0 delimiters.
pub fn kiss_encode(
  port : Int32,
  command : Int32,
  payload : Array[Byte],
) -> Array[Byte] {
  let out : Array[Byte] = []
  out.push(kiss_fend)
  out.push(((command << 4) | (port & 0x0F)).to_byte())
  for b in payload {
    if b == kiss_fend {
      out.push(kiss_fesc)
      out.push(kiss_tfend)
    } else if b == kiss_fesc {
      out.push(kiss_fesc)
      out.push(kiss_tfesc)
    } else {
      out.push(b)
    }
  }
  out.push(kiss_fend)
  out
}

///|
/// Parse a complete KISS byte stream into frames.
///
/// Empty delimiter runs are ignored. Returns an error when an escape sequence
/// is truncated at the end of a frame.
pub fn kiss_decode(data : Array[Byte]) -> Result[Array[KissFrame], String] {
  let frames : Array[KissFrame] = []
  let mut current : Array[Byte] = []
  let mut in_frame = false
  let mut escaped = false
  let mut i = 0
  while i < data.length() {
    let b = data[i]
    if b == kiss_fend {
      if in_frame && current.length() > 0 {
        match decode_kiss_body(current) {
          Some(f) => frames.push(f)
          None => return Err("truncated KISS escape sequence")
        }
      }
      current = []
      in_frame = true
      escaped = false
    } else if in_frame {
      if escaped {
        if b == kiss_tfend {
          current.push(kiss_fend)
        } else if b == kiss_tfesc {
          current.push(kiss_fesc)
        } else {
          current.push(b)
        }
        escaped = false
      } else if b == kiss_fesc {
        escaped = true
      } else {
        current.push(b)
      }
    }
    i = i + 1
  }
  Ok(frames)
}

///|
fn decode_kiss_body(body : Array[Byte]) -> KissFrame? {
  if body.length() == 0 {
    return None
  }
  let port_byte = body[0].to_int()
  let payload : Array[Byte] = []
  for i in 1..<body.length() {
    payload.push(body[i])
  }
  Some({ port: port_byte & 0x0F, command: (port_byte >> 4) & 0x0F, payload, })
}

///|
/// An incremental KISS decoder for a serial or TCP byte stream.
pub struct KissDecoder {
  mut buffer : Array[Byte]
  mut in_frame : Bool
  mut escaped : Bool
}

///|
pub fn KissDecoder::new() -> KissDecoder {
  { buffer: [], in_frame: false, escaped: false, }
}

///|
/// Feed received bytes and return every completed frame.
/// Malformed escape sequences are dropped rather than aborting the stream.
pub fn KissDecoder::feed(
  self : KissDecoder,
  data : Array[Byte],
) -> Array[KissFrame] {
  let frames : Array[KissFrame] = []
  for b in data {
    if b == kiss_fend {
      if self.in_frame && self.buffer.length() > 0 {
        match decode_kiss_body(self.buffer) {
          Some(f) => frames.push(f)
          None => ()
        }
      }
      self.buffer = []
      self.in_frame = true
      self.escaped = false
    } else if self.in_frame {
      if self.escaped {
        if b == kiss_tfend {
          self.buffer.push(kiss_fend)
        } else if b == kiss_tfesc {
          self.buffer.push(kiss_fesc)
        } else {
          self.buffer.push(b)
        }
        self.escaped = false
      } else if b == kiss_fesc {
        self.escaped = true
      } else {
        self.buffer.push(b)
      }
    }
  }
  frames
}
