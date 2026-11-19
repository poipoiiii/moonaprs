///|
/// Command-line front end for MoonAPRS.

///|
fn usage() -> Unit {
  println("moonaprs 0.2.0 — APRS / AX.25 toolkit")
  println("usage:")
  println(
    "  moonaprs decode <tnc2>            decode one packet to JSON-ish text",
  )
  println(
    "  moonaprs decode-file <file>       decode every line of a packet file",
  )
  println("  moonaprs encode <src> <dest> <path> <info>")
  println(
    "                                    build an AX.25 UI frame + KISS bytes",
  )
  println("  moonaprs passcode <callsign>      APRS-IS passcode")
  println("  moonaprs login <callsign> [rx]    print an APRS-IS login line")
  println("  moonaprs kiss <hex>               decode a KISS stream from hex")
  println("  moonaprs track <packet-file>      summarise tracks per station")
  println("  moonaprs svg <packet-file> [out.svg] [width] [height]")
  println(
    "                                    render station tracks as an SVG map",
  )
  println("  moonaprs gpx <packet-file> [out.gpx]")
  println("  moonaprs geojson <packet-file> [out.json]")
  println(
    "  moonaprs is-feed <file> [callsign] feed a file through APRS-IS session logic",
  )
  println("  moonaprs symbols <code>           look up an APRS symbol")
  println("  moonaprs help")
  println("")
  println(
    "Packet files contain one TNC2 line per packet; blank lines and lines",
  )
  println("starting with '#' are ignored.")
}

///|
fn hex_encode(bytes : Array[Byte]) -> String {
  let digits = "0123456789ABCDEF"
  let sb = StringBuilder()
  for b in bytes {
    let v = b.to_int()
    sb.write_char(digits.to_array()[v >> 4])
    sb.write_char(digits.to_array()[v & 0x0F])
  }
  sb.to_string()
}

///|
fn hex_value(c : Char) -> Int32? {
  if c >= '0' && c <= '9' {
    Some(c.to_int() - '0'.to_int())
  } else if c >= 'a' && c <= 'f' {
    Some(c.to_int() - 'a'.to_int() + 10)
  } else if c >= 'A' && c <= 'F' {
    Some(c.to_int() - 'A'.to_int() + 10)
  } else {
    None
  }
}

///|
fn hex_decode(text : String) -> Array[Byte]? {
  let cs = text.to_array()
  if cs.length() % 2 != 0 {
    return None
  }
  let out : Array[Byte] = []
  let mut i = 0
  while i < cs.length() {
    let hi = match hex_value(cs[i]) {
      Some(v) => v
      None => return None
    }
    let lo = match hex_value(cs[i + 1]) {
      Some(v) => v
      None => return None
    }
    out.push(((hi << 4) | lo).to_byte())
    i = i + 2
  }
  Some(out)
}

///|
fn read_lines(path : String) -> Array[String] {
  let text = @fs.read_file_to_string(path) catch {
    _ => {
      println("error: cannot read " + path)
      return []
    }
  }
  let out : Array[String] = []
  for line in text.split("\n") {
    let trimmed = line.trim().to_owned()
    if trimmed.length() > 0 && !trimmed.has_prefix("#") {
      out.push(trimmed)
    }
  }
  out
}

///|
fn describe_position(tag : String, p : @aprs.Position) -> Unit {
  println(
    tag +
    ": lat=" +
    @aprs.format_fixed(p.latitude(), 5) +
    " lon=" +
    @aprs.format_fixed(p.longitude(), 5) +
    " symbol=" +
    p.table().to_string() +
    p.symbol().to_string() +
    " (" +
    @svg.symbol_name(p.symbol()) +
    ")",
  )
  let ts = p.timestamp_text()
  match ts {
    Some(t) => println("  time: " + t)
    None => ()
  }
  if p.comment_text().length() > 0 {
    println("  comment: " + p.comment_text())
  }
}

///|
fn describe(packet : @aprs.AprsPacket) -> Unit {
  let header = packet.header()
  println(header.source().to_string() + ">" + header.destination().to_string())
  let path = header.path()
  if path.length() > 0 {
    let sb = StringBuilder()
    for i in 0..<path.length() {
      if i > 0 {
        sb.write_string(",")
      }
      sb.write_string(path[i].callsign_of().to_string())
      if path[i].is_repeated() {
        sb.write_string("*")
      }
    }
    println("  path: " + sb.to_string())
  }
  match packet.body() {
    @aprs.Position(p) => describe_position("position", p)
    @aprs.PositionWithWeather(p, w) => {
      describe_position("position", p)
      println("  weather: " + w.summary())
    }
    @aprs.Weather(w) => println("weather: " + w.summary())
    @aprs.Telemetry(t) =>
      println(
        "telemetry " +
        t.channel() +
        " #" +
        t.sequence().to_string() +
        ": " +
        t.analog_values().length().to_string() +
        " analog channels, bits " +
        t.digital_bits(),
      )
    @aprs.Status(s) => println("status: " + s.text_of())
    @aprs.Message(m) =>
      if m.is_ack() {
        println("ack for message " + m.acked_id().unwrap())
      } else {
        println("message to " + m.to_call() + ": " + m.body())
      }
    @aprs.Object(o) => {
      println(
        "object " +
        o.object_name() +
        (if o.is_alive() { " (alive)" } else { " (killed)" }),
      )
      describe_position("  position", o.position())
    }
    @aprs.Item(i) => {
      println("item " + i.item_name())
      describe_position("  position", i.position())
    }
    @aprs.Query(q) => println("query: " + q)
    @aprs.ThirdParty(inner) => println("third-party payload: " + inner)
    @aprs.Unknown(text) => println("unhandled payload: " + text)
  }
}

///|
fn decode_command(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println("usage: moonaprs decode <tnc2>")
    return
  }
  match @aprs.AprsPacket::parse(args[2]) {
    Ok(packet) => describe(packet)
    Err(e) => println("error: " + e)
  }
}

///|
fn decode_file_command(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println("usage: moonaprs decode-file <file>")
    return
  }
  let lines = read_lines(args[2])
  let mut ok = 0
  let mut bad = 0
  for line in lines {
    match @aprs.AprsPacket::parse(line) {
      Ok(packet) => {
        ok = ok + 1
        describe(packet)
      }
      Err(e) => {
        bad = bad + 1
        println("error: " + e + " in: " + line)
      }
    }
    println("")
  }
  println(
    "decoded " + ok.to_string() + " packets, " + bad.to_string() + " errors",
  )
}

///|
fn parse_path(text : String) -> Result[Array[@ax25.Callsign], String] {
  let parts = @aprs.split_char(text, ',')
  let out : Array[@ax25.Callsign] = []
  for part in parts {
    let trimmed = part.trim().to_owned()
    if trimmed.length() == 0 {
      continue
    }
    match @ax25.Callsign::parse(trimmed) {
      Some(c) => out.push(c)
      None => return Err("invalid path callsign: " + trimmed)
    }
  }
  Ok(out)
}

///|
fn encode_command(args : Array[String]) -> Unit {
  if args.length() < 6 {
    println("usage: moonaprs encode <src> <dest> <path|-> <info>")
    return
  }
  let src = match @ax25.Callsign::parse(args[2]) {
    Some(c) => c
    None => {
      println("error: invalid source callsign")
      return
    }
  }
  let dest = match @ax25.Callsign::parse(args[3]) {
    Some(c) => c
    None => {
      println("error: invalid destination callsign")
      return
    }
  }
  let path = if args[4] == "-" { Ok([]) } else { parse_path(args[4]) }
  match path {
    Err(e) => println("error: " + e)
    Ok(path) => {
      let info : Array[Byte] = []
      for c in args[5].to_array() {
        info.push(c.to_int().to_byte())
      }
      let frame = @ax25.Ax25Frame::ui(src, dest, path, info)
      let wire = frame.encode()
      println("ax25: " + hex_encode(wire))
      println("kiss: " + hex_encode(@ax25.kiss_encode(0, 0, wire)))
      println("tnc2: " + frame.to_tnc2())
    }
  }
}

///|
fn passcode_command(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println("usage: moonaprs passcode <callsign>")
    return
  }
  match @aprs.passcode(args[2]) {
    Ok(code) => println(code.to_string())
    Err(e) => println("error: " + e)
  }
}

///|
fn login_command(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println("usage: moonaprs login <callsign> [rx] [filter]")
    return
  }
  let receive_only = args.length() >= 4 && args[3] == "rx"
  let code = if receive_only {
    -1
  } else {
    match @aprs.passcode(args[2]) {
      Ok(c) => c
      Err(_) => -1
    }
  }
  let filter = if args.length() >= 5 { args[4] } else { "" }
  println(@aprs.login_line(args[2], code, filter))
}

///|
fn kiss_command(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println("usage: moonaprs kiss <hex>")
    return
  }
  let bytes = match hex_decode(args[2]) {
    Some(b) => b
    None => {
      println("error: invalid hex input")
      return
    }
  }
  match @ax25.kiss_decode(bytes) {
    Err(e) => println("error: " + e)
    Ok(frames) =>
      for frame in frames {
        println(
          "port " +
          frame.port_number().to_string() +
          " command " +
          frame.command_code().to_string() +
          ": " +
          hex_encode(frame.payload_bytes()),
        )
        match @ax25.decode(frame.payload_bytes()) {
          Ok(ax25) => println("  " + ax25.to_tnc2())
          Err(e) => println("  not a valid AX.25 frame: " + e)
        }
      }
  }
}

///|
fn build_store(path : String) -> @track.TrackStore {
  let store = @track.TrackStore::new()
  let mut bad = 0
  for line in read_lines(path) {
    match @aprs.AprsPacket::parse(line) {
      Ok(packet) => ignore(store.ingest(packet))
      Err(_) => bad = bad + 1
    }
  }
  if bad > 0 {
    println("skipped " + bad.to_string() + " malformed packets")
  }
  store
}

///|
fn track_command(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println("usage: moonaprs track <packet-file>")
    return
  }
  let store = build_store(args[2])
  if store.size() == 0 {
    println("no position reports found")
    return
  }
  for station in store.all() {
    let sb = StringBuilder()
    sb.write_string(station.callsign())
    sb.write_string(": ")
    sb.write_string(station.points().length().to_string())
    sb.write_string(" points, ")
    sb.write_string(@aprs.format_fixed(station.length_km(), 2))
    sb.write_string(" km")
    let points = station.points()
    if points.length() > 0 {
      let last = points[points.length() - 1]
      sb.write_string(", last ")
      sb.write_string(@aprs.format_fixed(last.latitude(), 4))
      sb.write_string(",")
      sb.write_string(@aprs.format_fixed(last.longitude(), 4))
    }
    let speed = station.average_speed_kmh()
    if speed > 0.0 {
      sb.write_string(", avg ")
      sb.write_string(@aprs.format_fixed(speed, 1))
      sb.write_string(" km/h")
    }
    println(sb.to_string())
  }
}

///|
fn svg_command(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println("usage: moonaprs svg <packet-file> [out.svg] [width] [height]")
    return
  }
  let store = build_store(args[2])
  let width = if args.length() >= 5 {
    @aprs.parse_digits(args[4]).unwrap_or(960)
  } else {
    960
  }
  let height = if args.length() >= 6 {
    @aprs.parse_digits(args[5]).unwrap_or(600)
  } else {
    600
  }
  let svg = @svg.render_tracks(store.all(), width, height, "MoonAPRS track map")
  if args.length() >= 4 {
    @fs.write_string_to_file(args[3], svg) catch {
      _ => {
        println("error: cannot write " + args[3])
        return
      }
    }
    println("wrote " + args[3])
  } else {
    println(svg)
  }
}

///|
fn write_text(path : String, content : String) -> Unit {
  @fs.write_string_to_file(path, content) catch {
    _ => {
      println("error: cannot write " + path)
      return
    }
  }
  println("wrote " + path)
}

///|
fn gpx_command(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println("usage: moonaprs gpx <packet-file> [out.gpx]")
    return
  }
  let store = build_store(args[2])
  let gpx = @track.store_to_gpx(store)
  if args.length() >= 4 {
    write_text(args[3], gpx)
  } else {
    println(gpx)
  }
}

///|
fn geojson_command(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println("usage: moonaprs geojson <packet-file> [out.json]")
    return
  }
  let store = build_store(args[2])
  let json = @track.store_to_geojson(store)
  if args.length() >= 4 {
    write_text(args[3], json)
  } else {
    println(json)
  }
}

///|
fn is_feed_command(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println("usage: moonaprs is-feed <file> [callsign]")
    return
  }
  let call = if args.length() >= 4 { args[3] } else { "N0CALL" }
  let code = match @aprs.passcode(call) {
    Ok(c) => c
    Err(_) => -1
  }
  let session = @aprs.IsSession::new(call, code, "")
  let dedupe = @aprs.DedupeWindow::new(256)
  let mut duplicates = 0
  let mut malformed = 0
  for line in read_lines(args[2]) {
    match session.handle_line(line) {
      @aprs.Packet(packet) =>
        if !dedupe.is_new(packet) {
          duplicates = duplicates + 1
        }
      @aprs.Malformed(_) => malformed = malformed + 1
      _ => ()
    }
  }
  println("login: " + session.login_line())
  println("packets: " + session.packet_count().to_string())
  println("duplicates: " + duplicates.to_string())
  println("malformed: " + malformed.to_string())
}

///|
fn symbols_command(args : Array[String]) -> Unit {
  if args.length() < 3 {
    println("usage: moonaprs symbols <code>  (optionally <table> <code>)")
    return
  }
  let table = if args.length() >= 4 { args[2].to_array()[0] } else { '/' }
  let code_text = if args.length() >= 4 { args[3] } else { args[2] }
  if code_text.length() == 0 {
    println("error: empty symbol code")
    return
  }
  let code = code_text.to_array()[0]
  let info = @aprs.symbol_info(table, code)
  println(
    info.table_char().to_string() +
    info.code_char().to_string() +
    "  " +
    info.name_of() +
    " (" +
    info.category_of() +
    ")",
  )
}

///|
fn main {
  let args = @env.args()
  if args.length() < 2 {
    usage()
    return
  }
  match args[1] {
    "decode" => decode_command(args)
    "decode-file" => decode_file_command(args)
    "encode" => encode_command(args)
    "passcode" => passcode_command(args)
    "login" => login_command(args)
    "kiss" => kiss_command(args)
    "track" => track_command(args)
    "svg" => svg_command(args)
    "gpx" => gpx_command(args)
    "geojson" => geojson_command(args)
    "is-feed" => is_feed_command(args)
    "symbols" => symbols_command(args)
    "help" => usage()
    _ => {
      println("unknown command: " + args[1])
      usage()
    }
  }
}
