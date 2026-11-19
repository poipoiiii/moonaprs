///|
test "car symbol renders a triangle marker" {
  let track = @track.Track::new("N0CALL")
  ignore(track.add(@track.TrackPoint::with_symbol(49.0, -72.0, None, "", '>')))
  let svg = render_tracks([track], 600, 400, "m")
  assert_true(svg.contains("<polygon"))
}

///|
test "weather symbol renders a square marker" {
  let track = @track.Track::new("WX1")
  ignore(track.add(@track.TrackPoint::with_symbol(49.0, -72.0, None, "", '_')))
  let svg = render_tracks([track], 600, 400, "m")
  assert_true(svg.contains("<rect x="))
}

///|
test "digipeater symbol renders a diamond marker" {
  let track = @track.Track::new("DIGI")
  ignore(track.add(@track.TrackPoint::with_symbol(49.0, -72.0, None, "", '#')))
  let svg = render_tracks([track], 600, 400, "m")
  assert_true(svg.contains("<polygon"))
}

///|
test "map includes a kilometre scale bar" {
  let track = @track.Track::new("N0CALL")
  ignore(track.add(@track.TrackPoint::new(49.0, -72.0, None, "")))
  let svg = render_tracks([track], 600, 400, "m")
  assert_true(svg.contains(" km</text>"))
}
