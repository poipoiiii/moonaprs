///|
/// The result of HDLC bit stuffing: packed bytes plus the number of significant
/// bits, i.e. excluding the zero padding added to reach a byte boundary.
pub struct Stuffed {
  bytes : Array[Byte]
  bit_len : Int32
}

///|
/// Insert a zero after every run of five consecutive one bits, as HDLC
/// transmitters do before sending a frame between flags.
pub fn bit_stuff(data : Array[Byte]) -> Stuffed {
  let bits : Array[Bool] = []
  let mut ones = 0
  for b in data {
    let value = b.to_int()
    for k in 0..<8 {
      let bit = ((value >> (7 - k)) & 1) != 0
      bits.push(bit)
      if bit {
        ones = ones + 1
      } else {
        ones = 0
      }
      if ones == 5 {
        bits.push(false)
        ones = 0
      }
    }
  }
  let out : Array[Byte] = []
  let mut cur = 0
  let mut n = 0
  for bit in bits {
    cur = (cur << 1) | (if bit { 1 } else { 0 })
    n = n + 1
    if n == 8 {
      out.push(cur.to_byte())
      cur = 0
      n = 0
    }
  }
  if n > 0 {
    out.push((cur << (8 - n)).to_byte())
  }
  { bytes: out, bit_len: bits.length(), }
}

///|
/// Remove HDLC bit stuffing. `bit_len` is the significant bit count returned by
/// `bit_stuff`; trailing zero padding is ignored. Returns `None` when a stuffed
/// zero is missing (a run of six ones), which indicates a corrupted frame.
pub fn bit_unstuff(packed : Array[Byte], bit_len : Int32) -> Array[Byte]? {
  let bits : Array[Bool] = []
  let mut ones = 0
  for b in packed {
    let value = b.to_int()
    for k in 0..<8 {
      if bits.length() >= bit_len {
        break
      }
      let bit = ((value >> (7 - k)) & 1) != 0
      if ones == 5 {
        if bit {
          return None
        }
        ones = 0
      } else {
        bits.push(bit)
        if bit {
          ones = ones + 1
        } else {
          ones = 0
        }
      }
    }
  }
  if bits.length() % 8 != 0 {
    return None
  }
  let out : Array[Byte] = []
  let mut cur = 0
  let mut n = 0
  for bit in bits {
    cur = (cur << 1) | (if bit { 1 } else { 0 })
    n = n + 1
    if n == 8 {
      out.push(cur.to_byte())
      cur = 0
      n = 0
    }
  }
  Some(out)
}
