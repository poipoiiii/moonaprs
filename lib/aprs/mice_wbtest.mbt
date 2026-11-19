///|
fn mice_near(a : Double, b : Double) -> Bool {
  (a - b).abs() < 1.0e-9
}

///|
/// Known Mic-E example from the APRS 1.2 specification: 36°00.22′N 86°43.29′W,
/// stopped, no course, symbol code `-`, symbol table `/`, message bits 110.
test "mice decodes the specification example" {
  let info = "`rG9l \u{1C}-/442.475+ 88.5_5"
  let mice = parse_mice("DG0P2R", info).unwrap()
  assert_true(mice_near(mice.latitude(), 36.0036666666667))
  assert_true(mice_near(mice.longitude(), -86.7215))
  assert_eq(mice.speed_knots(), 0)
  assert_eq(mice.course(), 0)
  assert_eq(mice.symbol(), '-')
  assert_eq(mice.table(), '/')
  assert_eq(mice.message_code(), 6)
  assert_true(mice.has_current_fix())
  assert_eq(mice.status_text(), "442.475+ 88.5_5")
}

///|
/// Full packet path: the destination address supplies the latitude.
test "aprs packet decodes mic-e body" {
  let packet = AprsPacket::parse(
    "KG4ZIE>DG0P2R,WIDE2-1:`rG9l \u{1C}-/442.475+ 88.5_5",
  ).unwrap()
  match packet.body() {
    MicE(m) => {
      assert_eq(m.symbol(), '-')
      assert_eq(m.table(), '/')
      assert_eq(m.message_code(), 6)
    }
    _ => abort("expected a Mic-E body")
  }
}

///|
/// South latitude, east longitude, old fix and the 800-knot speed offset.
test "mice south and east with speed offset" {
  // Destination "3D2567": digits 3,3,2,5,6,7 with message bits 010.
  // Latitude 33°25.67′S, longitude 111°07.49′E, speed 812 -> 12 knots,
  // course 123.
  let info = "'\u{8B}#Mm13-/old fix"
  let mice = parse_mice("3D2567", info).unwrap()
  assert_true(mice_near(mice.latitude(), -(33.0 + 25.0 / 60.0 + 67.0 / 6000.0)))
  assert_true(mice_near(mice.longitude(), 111.0 + 7.0 / 60.0 + 49.0 / 6000.0))
  assert_eq(mice.speed_knots(), 12)
  assert_eq(mice.course(), 123)
  assert_eq(mice.message_code(), 2)
  assert_true(!mice.has_current_fix())
  assert_eq(mice.status_text(), "old fix")
}

///|
/// A truncated information field must be rejected.
test "mice rejects truncated input" {
  assert_true(parse_mice("DG0P2R", "`rG") is Err(_))
}

///|
/// Mic-E parsing needs the AX.25 destination address.
test "parse_info rejects mic-e without a destination" {
  assert_true(parse_info("`rG9l \u{1C}-/442.475+ 88.5_5") is Err(_))
}
