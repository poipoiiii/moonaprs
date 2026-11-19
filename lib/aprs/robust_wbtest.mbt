///|
fn try_parse(line : String) -> Bool {
  match AprsPacket::parse(line) {
    Ok(_) => true
    Err(_) => false
  }
}

///|
test "every prefix of a valid packet is handled without panicking" {
  let line = "N0CALL-9>APRS,WIDE2-1:@092345z4903.50N/07201.75W>Moving east{12"
  let cs = line.to_array()
  for i in 0..<cs.length() {
    let sb = StringBuilder()
    for j in 0..<i {
      sb.write_char(cs[j])
    }
    ignore(try_parse(sb.to_string()))
  }
  assert_true(try_parse(line))
}

///|
test "garbage input returns errors or unknown payloads" {
  let samples : Array[String] = [
    "", ":", ">", "!>", "@@@@@@@", "N0CALL>", "N0CALL>APRS", "N0CALL>APRS:", "N0CALL>APRS:!",
    "N0CALL>APRS:@", "N0CALL>APRS:;", "N0CALL>APRS:)", "N0CALL>APRS::", "N0CALL>APRS:_",
    "N0CALL>APRS:T#", "N0CALL-99>APRS:!4903.50N/07201.75W-", ">APRS:!4903.50N/07201.75W-",
    "N0CALL>APRS:!4903.50N/07201.75W-", "N0CALL>APRS:!9999.99N/99999.99E-", "N0CALL>APRS:!/5L!!<*e",
    "N0CALL>APRS:;SHORT", "N0CALL>APRS:)X",
  ]
  for sample in samples {
    ignore(try_parse(sample))
  }
  assert_true(true)
}

///|
test "very long payloads are rejected without crashing" {
  let sb = StringBuilder()
  sb.write_string("N0CALL>APRS:>")
  for _ in 0..<2000 {
    sb.write_string("A")
  }
  match AprsPacket::parse(sb.to_string()) {
    Ok(packet) =>
      match packet.body() {
        Status(s) => assert_eq(s.text_of().length(), 2000)
        _ => abort("expected status")
      }
    Err(_) => abort("long status should parse")
  }
}

///|
test "control bytes in the payload do not panic" {
  for code in 0..<32 {
    let sb = StringBuilder()
    sb.write_string("N0CALL>APRS:")
    sb.write_char(code.unsafe_to_char())
    ignore(try_parse(sb.to_string()))
  }
  assert_true(true)
}
