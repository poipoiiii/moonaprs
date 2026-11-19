///|
test "web mercator reference points" {
  assert_true((lon_to_mercator_x(0.0) - 0.5).abs() < 1.0e-9)
  assert_true((lat_to_mercator_y(0.0) - 0.5).abs() < 1.0e-9)
  assert_true(lat_to_mercator_y(60.0) < 0.5)
  assert_true(lat_to_mercator_y(-60.0) > 0.5)
}

///|
test "projector keeps points inside the canvas" {
  let projector = Projector::new(48.0, 50.0, -73.0, -71.0, 800, 400, 36.0)
  let (x, y) = projector.project(49.0, -72.0)
  assert_true(x > 0.0 && x < 800.0)
  assert_true(y > 0.0 && y < 400.0)
}

///|
test "render emits a polyline per track" {
  let track = @track.Track::new("N0CALL-9")
  ignore(track.add(@track.TrackPoint::new(49.0, -72.0, None, "")))
  ignore(track.add(@track.TrackPoint::new(49.2, -72.2, None, "")))
  let svg = render_tracks([track], 600, 400, "MoonAPRS")
  assert_true(svg.contains("<svg"))
  assert_true(svg.contains("N0CALL-9"))
  assert_true(svg.contains("<path"))
  assert_true(svg.contains("</svg>"))
}

///|
test "render handles an empty track list" {
  let svg = render_tracks([], 600, 400, "Empty")
  assert_true(svg.contains("<svg"))
  assert_true(svg.contains("Empty"))
}

///|
test "symbol names" {
  assert_eq(symbol_name('-'), "house")
  assert_eq(symbol_name('_'), "weather station")
}
