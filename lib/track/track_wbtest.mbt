///|
fn close(a : Double, b : Double, tolerance : Double) -> Bool {
  (a - b).abs() < tolerance
}

///|
test "distance and bearing between London and Paris" {
  let d = distance_km(51.5074, -0.1278, 48.8566, 2.3522)
  assert_true(close(d, 343.5, 3.0))
  let b = bearing_deg(51.5074, -0.1278, 48.8566, 2.3522)
  assert_true(close(b, 148.0, 3.0))
  assert_eq(compass_point(b), "SE")
}

///|
test "maidenhead locator" {
  assert_eq(maidenhead(51.5074, -0.1278), "IO91")
  assert_eq(maidenhead(49.0583, -72.0292), "FN39")
}

///|
test "track deduplicates stationary beacons" {
  let track = Track::new("N0CALL")
  assert_eq(track.add(TrackPoint::new(49.0583, -72.0292, None, "")), true)
  assert_eq(track.add(TrackPoint::new(49.0583, -72.0292, None, "")), false)
  assert_eq(track.points().length(), 1)
}

///|
test "track length accumulates" {
  let track = Track::new("N0CALL")
  ignore(track.add(TrackPoint::new(51.5074, -0.1278, None, "")))
  ignore(track.add(TrackPoint::new(48.8566, 2.3522, None, "")))
  assert_true(close(track.length_km(), 343.5, 3.0))
  let bounds = track.bounds().unwrap()
  assert_eq(bounds.min_latitude(), 48.8566)
  assert_eq(bounds.max_longitude(), 2.3522)
}

///|
test "douglas-peucker removes collinear points" {
  let points = [
    TrackPoint::new(0.0, 0.0, None, ""),
    TrackPoint::new(0.0, 0.001, None, ""),
    TrackPoint::new(0.0, 0.002, None, ""),
    TrackPoint::new(0.0, 0.003, None, ""),
  ]
  let simplified = simplify(points, 0.1)
  assert_eq(simplified.length(), 2)
  assert_eq(simplified[0].longitude(), 0.0)
  assert_eq(simplified[1].longitude(), 0.003)
}

///|
test "douglas-peucker keeps a detour" {
  let points = [
    TrackPoint::new(0.0, 0.0, None, ""),
    TrackPoint::new(0.01, 0.001, None, ""),
    TrackPoint::new(0.0, 0.002, None, ""),
  ]
  let simplified = simplify(points, 0.1)
  assert_eq(simplified.length(), 3)
}

///|
test "store ingests position packets" {
  let store = TrackStore::new()
  let a = @aprs.AprsPacket::parse("N0CALL>APRS:!4903.50N/07201.75W-Test").unwrap()
  let b = @aprs.AprsPacket::parse("N0CALL>APRS:!4904.00N/07202.00W-Test").unwrap()
  assert_eq(store.ingest(a), true)
  assert_eq(store.ingest(b), true)
  assert_eq(store.size(), 1)
  let track = store.track("N0CALL").unwrap()
  assert_eq(track.points().length(), 2)
  assert_true(track.length_km() > 0.0)
}

///|
test "store ignores non-position packets" {
  let store = TrackStore::new()
  let status = @aprs.AprsPacket::parse("N0CALL>APRS:>hello").unwrap()
  assert_eq(store.ingest(status), false)
  assert_eq(store.size(), 0)
}
