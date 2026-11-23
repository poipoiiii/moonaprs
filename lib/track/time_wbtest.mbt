///|
fn ref_store() -> TrackStore {
  TrackStore::with_reference(
    @aprs.DateTime::from_ymd_hms(2026, 11, 23, 12, 0, 0),
    0,
  )
}

///|
test "store anchors day-zulu timestamps to the reference date" {
  let store = ref_store()
  ignore(
    store.ingest(
      @aprs.AprsPacket::parse("N0CALL>APRS:@231150z4903.50N/07201.75W-a").unwrap(),
    ),
  )
  ignore(
    store.ingest(
      @aprs.AprsPacket::parse("N0CALL>APRS:@231200z4904.50N/07202.75W-b").unwrap(),
    ),
  )
  let points = store.track("N0CALL").unwrap().points()
  assert_eq(points[0].instant_iso(), Some("2026-11-23T11:50:00Z"))
  assert_eq(points[1].instant_iso(), Some("2026-11-23T12:00:00Z"))
}

///|
test "gpx and geojson carry resolved instants" {
  let store = ref_store()
  ignore(
    store.ingest(
      @aprs.AprsPacket::parse("N0CALL>APRS:@231150z4903.50N/07201.75W-a").unwrap(),
    ),
  )
  ignore(
    store.ingest(
      @aprs.AprsPacket::parse("N0CALL>APRS:@231200z4904.50N/07202.75W-b").unwrap(),
    ),
  )
  let gpx = store_to_gpx(store)
  assert_true(gpx.contains("<time>2026-11-23T11:50:00Z</time>"))
  let json = store_to_geojson(store)
  assert_true(
    json.contains(
      "\"times\":[\"2026-11-23T11:50:00Z\",\"2026-11-23T12:00:00Z\"]",
    ),
  )
}

///|
test "epoch-based speed spans a month boundary" {
  // Reference 2026-11-01 00:05 UTC.  The 31st is invalid in November, so it
  // resolves to 2026-10-31 23:50; the 1st resolves to 2026-11-01 00:00.  The
  // delta is exactly 10 minutes and straddles midnight and the month rollover.
  let store = TrackStore::with_reference(
    @aprs.DateTime::from_ymd_hms(2026, 11, 1, 0, 5, 0),
    0,
  )
  ignore(
    store.ingest(
      @aprs.AprsPacket::parse("N0CALL>APRS:@312350z4900.00N/07200.00W-a").unwrap(),
    ),
  )
  ignore(
    store.ingest(
      @aprs.AprsPacket::parse("N0CALL>APRS:@010000z4900.10N/07200.00W-b").unwrap(),
    ),
  )
  let track = store.track("N0CALL").unwrap()
  let points = track.points()
  assert_eq(points[0].instant_iso(), Some("2026-10-31T23:50:00Z"))
  assert_eq(points[1].instant_iso(), Some("2026-11-01T00:00:00Z"))
  let samples = track.speeds()
  assert_eq(samples.length(), 1)
  // 10 minutes = 600 s.
  let expected = distance_km(
      points[0].latitude(),
      points[0].longitude(),
      points[1].latitude(),
      points[1].longitude(),
    ) *
    6.0
  assert_true((samples[0].speed_kmh() - expected).abs() < 0.01)
}
