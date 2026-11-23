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

///|
test "ship symbol renders an inverted triangle" {
  assert_eq(
    marker_svg(0.0, 0.0, "red", Some('s')),
    "<polygon points=\"-5.5,-4.0 5.5,-4.0 0.0,6.0\" fill=\"red\"/>\n",
  )
}

///|
test "large aircraft symbol renders a triangle" {
  assert_eq(
    marker_svg(0.0, 0.0, "red", Some('^')),
    "<polygon points=\"0.0,-6.0 -5.5,4.0 5.5,4.0\" fill=\"red\"/>\n",
  )
}

///|
test "hospital symbol renders a cross" {
  assert_eq(
    marker_svg(0.0, 0.0, "red", Some('h')),
    "<path d=\"M -1.5,-6.0 h3 v4.5 h4.5 v3 h-4.5 v4.5 h-3 v-4.5 h-4.5 v-3 h4.5 z\" fill=\"red\"/>\n",
  )
}

///|
test "house symbol renders a diamond" {
  assert_eq(
    marker_svg(0.0, 0.0, "red", Some('-')),
    "<polygon points=\"0.0,-6.0 6.0,0.0 0.0,6.0 -6.0,0.0\" fill=\"red\"/>\n",
  )
}

///|
test "unmapped symbol falls back to a circle" {
  assert_eq(
    marker_svg(0.0, 0.0, "red", Some('\"')),
    "<circle cx=\"0.0\" cy=\"0.0\" r=\"5\" fill=\"red\"/>\n",
  )
}
