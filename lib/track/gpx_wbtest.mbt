///|
fn gpx_sample_track() -> Track {
  let track = Track::new("N0CALL-9")
  ignore(
    track.add(TrackPoint::new(49.058333, -72.029167, Some("092300z"), "a<b&c")),
  )
  ignore(track.add(TrackPoint::new(49.06, -72.03, Some("092310z"), "")))
  track
}

///|
test "gpx contains one trkpt per point" {
  let gpx = to_gpx(gpx_sample_track())
  assert_true(gpx.contains("<gpx"))
  assert_true(gpx.contains("N0CALL-9"))
  assert_eq(gpx.contains("<trkpt"), true)
  let mut count = 0
  for line in gpx.split("\n") {
    if line.contains("<trkpt") {
      count = count + 1
    }
  }
  assert_eq(count, 2)
}

///|
test "gpx escapes comments and records APRS time" {
  let gpx = to_gpx(gpx_sample_track())
  assert_true(gpx.contains("a&lt;b&amp;c"))
  assert_true(gpx.contains("APRS time 092300z"))
}

///|
test "gpx exports an empty track" {
  let gpx = to_gpx(Track::new("EMPTY"))
  assert_true(gpx.contains("<trk>"))
  assert_true(gpx.contains("</gpx>"))
}
