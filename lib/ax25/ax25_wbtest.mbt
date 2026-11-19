///|
fn ascii(s : String) -> Array[Byte] {
  s.to_array().map(fn(c) { c.to_int().to_byte() })
}

///|
fn ok_frame(r : Result[Ax25Frame, String]) -> Ax25Frame {
  match r {
    Ok(f) => f
    Err(e) => abort("decode failed: " + e)
  }
}

///|
test "crc16 x25 check value" {
  assert_eq(crc16_x25(ascii("123456789")), 0x906E)
}

///|
test "callsign parsing normalises case and ssid" {
  let cs = Callsign::parse("n0call-09").unwrap()
  assert_eq(cs.to_string(), "N0CALL-9")
  assert_eq(cs.ssid, 9)
}

///|
test "callsign parsing rejects bad input" {
  assert_true(Callsign::parse("") is None)
  assert_true(Callsign::parse("TOOLONGCALL") is None)
  assert_true(Callsign::parse("N0CALL-16") is None)
}

///|
test "address field encoding matches the AX.25 shift rule" {
  let frame = Ax25Frame::ui(
    Callsign::new("N0CALL", 0),
    Callsign::new("APRS", 0),
    [],
    ascii("hi"),
  )
  let bytes = frame.encode()
  let expected = [
    0x82, 0xA0, 0xA4, 0xA6, 0x40, 0x40, 0xE0, 0x9C, 0x60, 0x86, 0x82, 0x98, 0x98,
    0x61,
  ]
  for i in 0..<expected.length() {
    assert_eq(bytes[i].to_int(), expected[i])
  }
  // control, pid, info
  assert_eq(bytes[14].to_int(), 0x03)
  assert_eq(bytes[15].to_int(), 0xF0)
  assert_eq(bytes[16].to_int(), 0x68)
  assert_eq(bytes[17].to_int(), 0x69)
}

///|
test "frame round-trips through wire encoding" {
  let path = [Callsign::new("WIDE2", 2), Callsign::new("WIDE1", 1)]
  let frame = Ax25Frame::ui(
    Callsign::new("N0CALL", 9),
    Callsign::new("APRS", 0),
    path,
    ascii("!4903.50N/07201.75W-Test"),
  )
  let decoded = ok_frame(decode(frame.encode()))
  assert_eq(decoded.src_callsign().to_string(), "N0CALL-9")
  assert_eq(decoded.dest_callsign().to_string(), "APRS")
  assert_eq(decoded.path().length(), 2)
  assert_eq(decoded.path()[0].callsign.to_string(), "WIDE2-2")
  assert_eq(decoded.is_ui(), true)
  assert_eq(decoded.info_bytes(), ascii("!4903.50N/07201.75W-Test"))
}

///|
test "tnc2 rendering" {
  let frame = Ax25Frame::ui(
    Callsign::new("N0CALL", 9),
    Callsign::new("APRS", 0),
    [Callsign::new("WIDE2", 1)],
    ascii(">hello"),
  )
  assert_eq(frame.to_tnc2(), "N0CALL-9>APRS,WIDE2-1:>hello")
}

///|
test "corrupted fcs is rejected" {
  let frame = Ax25Frame::ui(
    Callsign::new("N0CALL", 0),
    Callsign::new("APRS", 0),
    [],
    ascii("test"),
  )
  let bytes = frame.encode()
  bytes[bytes.length() - 1] = (bytes[bytes.length() - 1].to_int() ^ 0xFF).to_byte()
  assert_true(decode(bytes) is Err(_))
}

///|
test "hdlc bit stuffing round-trips" {
  let payload = ascii("APRS!!")
  let stuffed = bit_stuff(payload)
  let back = bit_unstuff(stuffed.bytes, stuffed.bit_len).unwrap()
  assert_eq(back, payload)
}

///|
test "hdlc inserts a zero after five ones" {
  let stuffed = bit_stuff([b'\xF8'])
  // 11111000 -> 11111 0 000 (plus padding)
  assert_eq(stuffed.bit_len, 9)
}

///|
test "kiss escapes reserved bytes" {
  let payload = [kiss_fend, b'A', kiss_fesc]
  let encoded = kiss_encode(0, 0, payload)
  let frames = kiss_decode(encoded).unwrap()
  assert_eq(frames.length(), 1)
  assert_eq(frames[0].payload, payload)
  assert_eq(frames[0].port, 0)
}

///|
test "kiss decoder handles a split stream" {
  let payload = ascii("hello")
  let encoded = kiss_encode(3, 0, payload)
  let decoder = KissDecoder::new()
  let a = decoder.feed(encoded[0:4].to_owned())
  assert_eq(a.length(), 0)
  let b = decoder.feed(encoded[4:].to_owned())
  assert_eq(b.length(), 1)
  assert_eq(b[0].port, 3)
  assert_eq(b[0].payload, payload)
}
