///|
test "speed and course from consecutive timestamps" {
  let track = Track::new("N0CALL")
  ignore(track.add(TrackPoint::new(49.0, -72.0, Some("092300z"), "")))
  ignore(track.add(TrackPoint::new(49.01, -72.0, Some("092310z"), "")))
  let samples = track.speeds()
  assert_eq(samples.length(), 1)
  let expected_km = distance_km(49.0, -72.0, 49.01, -72.0)
  let expected_speed = expected_km * 6.0
  assert_true((samples[0].speed_kmh() - expected_speed).abs() < 0.01)
  assert_true((samples[0].course() - 0.0).abs() < 0.5)
}

///|
test "untimed segments are skipped" {
  let track = Track::new("N0CALL")
  ignore(track.add(TrackPoint::new(49.0, -72.0, None, "")))
  ignore(track.add(TrackPoint::new(49.01, -72.0, Some("092310z"), "")))
  assert_eq(track.speeds().length(), 0)
  assert_eq(track.average_speed_kmh(), 0.0)
}

///|
test "average speed averages segments" {
  let track = Track::new("N0CALL")
  ignore(track.add(TrackPoint::new(49.0, -72.0, Some("092300z"), "")))
  ignore(track.add(TrackPoint::new(49.01, -72.0, Some("092310z"), "")))
  ignore(track.add(TrackPoint::new(49.02, -72.0, Some("092320z"), "")))
  assert_eq(track.speeds().length(), 2)
  assert_true(track.average_speed_kmh() > 0.0)
}
