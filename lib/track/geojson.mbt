///|
fn escape_json(text : String) -> String {
  let sb = StringBuilder()
  for c in text.to_array() {
    if c == '"' {
      sb.write_string("\\\"")
    } else if c == '\\' {
      sb.write_string("\\\\")
    } else if c == '\n' {
      sb.write_string("\\n")
    } else if c == '\r' {
      sb.write_string("\\r")
    } else if c == '\t' {
      sb.write_string("\\t")
    } else {
      sb.write_char(c)
    }
  }
  sb.to_string()
}

///|
fn append_track_feature(sb : StringBuilder, track : Track) -> Unit {
  sb.write_string("{\"type\":\"Feature\",\"properties\":{\"callsign\":\"")
  sb.write_string(escape_json(track.callsign()))
  sb.write_string("\",\"points\":")
  sb.write_string(track.points().length().to_string())
  sb.write_string(",\"length_km\":")
  sb.write_string(@aprs.format_fixed(track.length_km(), 3))
  sb.write_string(",\"average_speed_kmh\":")
  sb.write_string(@aprs.format_fixed(track.average_speed_kmh(), 2))
  sb.write_string("},\"geometry\":{\"type\":\"LineString\",\"coordinates\":[")
  let points = track.points()
  for i in 0..<points.length() {
    if i > 0 {
      sb.write_string(",")
    }
    sb.write_string("[")
    sb.write_string(@aprs.format_fixed(points[i].longitude(), 6))
    sb.write_string(",")
    sb.write_string(@aprs.format_fixed(points[i].latitude(), 6))
    sb.write_string("]")
  }
  sb.write_string("]}}")
}

///|
/// Export one track as a GeoJSON Feature (LineString).
pub fn to_geojson(track : Track) -> String {
  let sb = StringBuilder()
  append_track_feature(sb, track)
  sb.to_string()
}

///|
/// Export every track in a store as a GeoJSON FeatureCollection.
pub fn store_to_geojson(store : TrackStore) -> String {
  let sb = StringBuilder()
  sb.write_string("{\"type\":\"FeatureCollection\",\"features\":[")
  let tracks = store.all()
  for i in 0..<tracks.length() {
    if i > 0 {
      sb.write_string(",")
    }
    append_track_feature(sb, tracks[i])
  }
  sb.write_string("]}")
  sb.to_string()
}
