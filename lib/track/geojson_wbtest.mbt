///|
test "geojson feature contains coordinates in lon-lat order" {
  let track = Track::new("N0CALL-9")
  ignore(track.add(TrackPoint::new(49.058333, -72.029167, Some("092300z"), "")))
  ignore(track.add(TrackPoint::new(49.06, -72.03, Some("092310z"), "")))
  let json = to_geojson(track)
  assert_true(json.contains("\"type\":\"Feature\""))
  assert_true(json.contains("\"LineString\""))
  assert_true(json.contains("[-72.029167,49.058333]"))
  assert_true(json.contains("\"callsign\":\"N0CALL-9\""))
}

///|
test "geojson store wraps features in a collection" {
  let store = TrackStore::new()
  ignore(
    store.ingest(
      @aprs.AprsPacket::parse("A1AAA>APRS:!4903.50N/07201.75W-A").unwrap(),
    ),
  )
  ignore(
    store.ingest(
      @aprs.AprsPacket::parse("B2BBB>APRS:!4904.50N/07202.75W-B").unwrap(),
    ),
  )
  let json = store_to_geojson(store)
  assert_true(json.contains("FeatureCollection"))
  assert_true(json.contains("A1AAA"))
  assert_true(json.contains("B2BBB"))
}

///|
test "geojson escapes callsigns" {
  let track = Track::new("A\"B")
  ignore(track.add(TrackPoint::new(49.0, -72.0, None, "")))
  assert_true(to_geojson(track).contains("A\\\"B"))
}

///|
test "geojson exports an empty track" {
  let json = to_geojson(Track::new("EMPTY"))
  assert_true(json.contains("\"coordinates\":[]"))
}
