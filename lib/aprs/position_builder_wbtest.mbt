///|
test "position builder encodes an APRS information field" {
  let p = Position::new(49.058333, -72.029167, '/', '-', "Test")
  assert_eq(p.to_aprs(), "=4903.50N/07201.75W-Test")
}

///|
test "position builder round-trips through the parser" {
  let original = Position::new(49.058333, -72.029167, '/', '>', "Moving")
  let parsed = parse_info(original.to_aprs()).unwrap()
  match parsed {
    Position(p) => {
      assert_true((p.latitude() - 49.058333).abs() < 0.001)
      assert_true((p.longitude() + 72.029167).abs() < 0.001)
      assert_eq(p.table(), '/')
      assert_eq(p.symbol(), '>')
      assert_eq(p.comment_text(), "Moving")
    }
    _ => abort("expected a position")
  }
}

///|
test "timestamped position builder uses the @ identifier" {
  let p = Position::new(48.8566, 2.3522, '/', '-', "Paris").with_timestamp(
    "092345z",
  )
  let encoded = p.to_aprs()
  assert_eq(chars_slice(encoded, 0, 8), "@092345z")
  match parse_info(encoded).unwrap() {
    Position(back) => assert_eq(back.timestamp_text().unwrap(), "092345z")
    _ => abort("expected a timestamped position")
  }
}
