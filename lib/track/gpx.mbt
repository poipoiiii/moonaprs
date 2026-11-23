///|
fn escape_xml(text : String) -> String {
  let sb = StringBuilder()
  for c in text.to_array() {
    if c == '&' {
      sb.write_string("&amp;")
    } else if c == '<' {
      sb.write_string("&lt;")
    } else if c == '>' {
      sb.write_string("&gt;")
    } else if c == '"' {
      sb.write_string("&quot;")
    } else if c == '\'' {
      sb.write_string("&apos;")
    } else {
      sb.write_char(c)
    }
  }
  sb.to_string()
}

///|
fn append_track_gpx(sb : StringBuilder, track : Track) -> Unit {
  sb.write_string("  <trk>\n    <name>")
  sb.write_string(escape_xml(track.callsign()))
  sb.write_string("</name>\n    <trkseg>\n")
  for point in track.points() {
    sb.write_string("      <trkpt lat=\"")
    sb.write_string(@aprs.format_fixed(point.latitude(), 6))
    sb.write_string("\" lon=\"")
    sb.write_string(@aprs.format_fixed(point.longitude(), 6))
    sb.write_string("\">\n")
    match point.instant_iso() {
      Some(iso) => sb.write_string("        <time>" + iso + "</time>\n")
      None => ()
    }
    let comment = point.comment_text()
    if comment.length() > 0 {
      sb.write_string("        <desc>")
      sb.write_string(escape_xml(comment))
      sb.write_string("</desc>\n")
    }
    match point.timestamp_text() {
      Some(ts) =>
        sb.write_string("        <cmt>APRS time " + escape_xml(ts) + "</cmt>\n")
      None => ()
    }
    sb.write_string("      </trkpt>\n")
  }
  sb.write_string("    </trkseg>\n  </trk>\n")
}

///|
/// Export one track as GPX 1.1.
pub fn to_gpx(track : Track) -> String {
  let sb = StringBuilder()
  sb.write_string("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
  sb.write_string(
    "<gpx version=\"1.1\" creator=\"MoonAPRS\" xmlns=\"http://www.topografix.com/GPX/1/1\">\n",
  )
  append_track_gpx(sb, track)
  sb.write_string("</gpx>\n")
  sb.to_string()
}

///|
/// Export every track in a store as a single GPX document.
pub fn store_to_gpx(store : TrackStore) -> String {
  let sb = StringBuilder()
  sb.write_string("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
  sb.write_string(
    "<gpx version=\"1.1\" creator=\"MoonAPRS\" xmlns=\"http://www.topografix.com/GPX/1/1\">\n",
  )
  for track in store.all() {
    append_track_gpx(sb, track)
  }
  sb.write_string("</gpx>\n")
  sb.to_string()
}
