///|
test "dedupe window suppresses repeats regardless of path" {
  let window = DedupeWindow::new(8)
  let a = AprsPacket::parse("N0CALL>APRS,WIDE2-1:!4903.50N/07201.75W-Test").unwrap()
  let b = AprsPacket::parse("N0CALL>APRS,WIDE1-1:!4903.50N/07201.75W-Test").unwrap()
  assert_eq(window.is_new(a), true)
  assert_eq(window.is_new(b), false)
  assert_eq(window.size(), 1)
}

///|
test "dedupe window distinguishes payloads" {
  let window = DedupeWindow::new(8)
  assert_eq(
    window.is_new(
      AprsPacket::parse("N0CALL>APRS:!4903.50N/07201.75W-A").unwrap(),
    ),
    true,
  )
  assert_eq(
    window.is_new(
      AprsPacket::parse("N0CALL>APRS:!4903.50N/07201.75W-B").unwrap(),
    ),
    true,
  )
  assert_eq(window.size(), 2)
}

///|
test "dedupe window evicts old signatures" {
  let window = DedupeWindow::new(2)
  ignore(window.is_new(AprsPacket::parse("A1AAA>APRS:!4903.50N/07201.75W-1").unwrap()))
  ignore(window.is_new(AprsPacket::parse("A1AAA>APRS:!4903.50N/07201.75W-2").unwrap()))
  ignore(window.is_new(AprsPacket::parse("A1AAA>APRS:!4903.50N/07201.75W-3").unwrap()))
  assert_eq(
    window.is_new(AprsPacket::parse("A1AAA>APRS:!4903.50N/07201.75W-1").unwrap()),
    true,
  )
  assert_eq(window.size(), 2)
}

///|
test "dedupe line reports parse errors" {
  let window = DedupeWindow::new(2)
  assert_true(window.is_new_line("not a packet") is Err(_))
}
