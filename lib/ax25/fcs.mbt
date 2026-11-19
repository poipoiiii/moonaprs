///|
/// CRC-16/X.25 as used for the AX.25 frame check sequence.
///
/// Polynomial `x^16 + x^12 + x^5 + 1` (0x1021) used reflected (0x8408), initial
/// value 0xFFFF, final XOR 0xFFFF. Check value for `"123456789"` is 0x906E.
pub fn crc16_x25(data : Array[Byte]) -> Int32 {
  let mut crc = 0xFFFF
  for b in data {
    crc = crc ^ b.to_int()
    for _ in 0..<8 {
      if (crc & 1) != 0 {
        crc = (crc >> 1) ^ 0x8408
      } else {
        crc = crc >> 1
      }
    }
  }
  crc ^ 0xFFFF
}

///|
/// Append the frame check sequence in AX.25 wire order (low byte first).
pub fn append_fcs(data : Array[Byte]) -> Array[Byte] {
  let out : Array[Byte] = []
  for b in data {
    out.push(b)
  }
  let fcs = crc16_x25(data)
  out.push((fcs & 0xFF).to_byte())
  out.push(((fcs >> 8) & 0xFF).to_byte())
  out
}

///|
/// Verify and strip the trailing frame check sequence.
/// Returns `None` when the frame is shorter than two bytes or the FCS does not
/// match the computed value.
pub fn strip_fcs(data : Array[Byte]) -> Array[Byte]? {
  let n = data.length()
  if n < 2 {
    return None
  }
  let body : Array[Byte] = []
  for i in 0..<(n - 2) {
    body.push(data[i])
  }
  let fcs = crc16_x25(body)
  let got = data[n - 2].to_int() | (data[n - 1].to_int() << 8)
  if fcs == got {
    Some(body)
  } else {
    None
  }
}
