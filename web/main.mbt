///|
/// Browser demo for MoonAPRS: paste TNC2 packet lines, see the decoded report
/// and a rendered track map.

///|
fn summarize(packet : @aprs.AprsPacket) -> String {
  let header = packet.header()
  let sb = StringBuilder()
  sb.write_string(header.source().to_string())
  sb.write_string("  ")
  match packet.body() {
    @aprs.Position(p) =>
      sb.write_string("position " + latlon(p) + "  " + p.comment_text())
    @aprs.PositionWithWeather(p, w) =>
      sb.write_string("position " + latlon(p) + "  weather: " + w.summary())
    @aprs.Weather(w) => sb.write_string("weather: " + w.summary())
    @aprs.Telemetry(t) =>
      sb.write_string(
        "telemetry " + t.channel() + " #" + t.sequence().to_string(),
      )
    @aprs.Status(s) => sb.write_string("status: " + s.text_of())
    @aprs.Message(m) =>
      if m.is_ack() {
        sb.write_string("ack " + m.acked_id().unwrap())
      } else {
        sb.write_string("message to " + m.to_call() + ": " + m.body())
      }
    @aprs.Object(o) =>
      sb.write_string("object " + o.object_name() + "  " + latlon(o.position()))
    @aprs.Item(i) =>
      sb.write_string("item " + i.item_name() + "  " + latlon(i.position()))
    @aprs.MicE(m) =>
      sb.write_string(
        "mic-e position " +
        @aprs.format_fixed(m.latitude(), 4) +
        "," +
        @aprs.format_fixed(m.longitude(), 4) +
        "  " +
        m.speed_knots().to_string() +
        "kn " +
        m.course().to_string() +
        "°  " +
        m.status_text(),
      )
    @aprs.Query(q) => sb.write_string("query: " + q)
    @aprs.ThirdParty(inner) => sb.write_string("third-party: " + inner)
    @aprs.Unknown(text) => sb.write_string("unhandled: " + text)
  }
  sb.to_string()
}

///|
fn latlon(p : @aprs.Position) -> String {
  @aprs.format_fixed(p.latitude(), 4) +
  "," +
  @aprs.format_fixed(p.longitude(), 4)
}

///|
fn parse_all(text : String) -> Unit {
  let store = make_store()
  let report = StringBuilder()
  let mut total = 0
  let mut ok = 0
  for line in text.split("\n") {
    let trimmed = line.trim().to_owned()
    if trimmed.length() == 0 || trimmed.has_prefix("#") {
      continue
    }
    total = total + 1
    match @aprs.AprsPacket::parse(trimmed) {
      Ok(packet) => {
        ok = ok + 1
        ignore(store.ingest(packet))
        report.write_string(summarize(packet) + "\n")
      }
      Err(e) => report.write_string("error: " + e + "\n")
    }
  }
  let mut total_km = 0.0
  for station in store.all() {
    total_km = total_km + station.length_km()
  }
  report.write_string("\n")
  report.write_string(
    "decoded " +
    ok.to_string() +
    "/" +
    total.to_string() +
    " packets, " +
    store.size().to_string() +
    " stations, " +
    @aprs.format_fixed(total_km, 2) +
    " km",
  )
  let svg = @svg.render_tracks(store.all(), 900, 540, "MoonAPRS track map")
  js_render(report.to_string(), svg)
}

///|
fn make_store() -> @track.TrackStore {
  @track.TrackStore::with_reference(
    @aprs.DateTime::from_unix_ms(js_now_ms().to_int64()),
    0,
  )
}

///|
fn build_store(text : String) -> @track.TrackStore {
  let store = make_store()
  for line in text.split("\n") {
    let trimmed = line.trim().to_owned()
    if trimmed.length() == 0 || trimmed.has_prefix("#") {
      continue
    }
    match @aprs.AprsPacket::parse(trimmed) {
      Ok(packet) => ignore(store.ingest(packet))
      Err(_) => ()
    }
  }
  store
}

///|
fn export_gpx(text : String) -> Unit {
  js_download("moonaprs.gpx", @track.store_to_gpx(build_store(text)))
}

///|
fn export_geojson(text : String) -> Unit {
  js_download("moonaprs.geojson", @track.store_to_geojson(build_store(text)))
}

///|
fn main {
  js_bind(parse_all, export_gpx, export_geojson)
}
