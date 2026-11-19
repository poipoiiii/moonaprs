///|
test "store keeps the APRS symbol code" {
  let store = TrackStore::new()
  ignore(
    store.ingest(
      @aprs.AprsPacket::parse("N0CALL>APRS:!4903.50N/07201.75W>Moving").unwrap(),
    ),
  )
  let track = store.track("N0CALL").unwrap()
  assert_eq(track.points()[0].symbol_code().unwrap(), '>')
}

///|
test "manually built points have no symbol" {
  let point = TrackPoint::new(49.0, -72.0, None, "")
  assert_eq(point.symbol_code() is None, true)
  let tagged = TrackPoint::with_symbol(49.0, -72.0, None, "", '_')
  assert_eq(tagged.symbol_code().unwrap(), '_')
}
