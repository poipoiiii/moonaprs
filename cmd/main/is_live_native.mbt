///|
fn is_live_usage() -> Unit {
  println(
    "usage: moonaprs is-live [host] [port] <callsign> [filter] [--out base] [--count n]",
  )
  println("  connects to a live APRS-IS server and prints decoded packets")
  println("  defaults: host=rotate.aprs2.net  port=14580  filter=(none)")
  println("  pass -1 (receive-only) if callsign has no passcode")
  println(
    "  --out base   collect position reports into base.gpx + base.geojson",
  )
  println(
    "  --count n    stop after n position reports; with --out, exports are",
  )
  println("               also rewritten every 25 points so Ctrl-C keeps data")
}

///|
fn export_tracks(base : String, store : @track.TrackStore) -> Unit {
  write_text(base + ".gpx", @track.store_to_gpx(store))
  write_text(base + ".geojson", @track.store_to_geojson(store))
}

///|
fn is_live_command(args : Array[String]) -> Unit {
  // Split flags from positionals so the positional grammar stays unchanged.
  let positional : Array[String] = []
  let mut out_base = ""
  let mut count_limit = 0
  let mut i = 2
  while i < args.length() {
    let a = args[i]
    if a == "--out" && i + 1 < args.length() {
      out_base = args[i + 1]
      i = i + 2
    } else if a == "--count" && i + 1 < args.length() {
      count_limit = @aprs.parse_digits(args[i + 1]).unwrap_or(0)
      i = i + 2
    } else {
      positional.push(a)
      i = i + 1
    }
  }
  let mut host = "rotate.aprs2.net"
  let mut port = 14580
  let mut pos = 0
  // Leading "host port" is detected by a numeric second argument.
  if positional.length() >= 2 {
    match @aprs.parse_digits(positional[1]) {
      Some(p) => {
        host = positional[0]
        port = p
        pos = 2
      }
      None => ()
    }
  }
  if pos >= positional.length() {
    is_live_usage()
    return
  }
  let callsign = positional[pos]
  let filter = if pos + 1 < positional.length() {
    positional[pos + 1]
  } else {
    ""
  }
  let passcode = match @aprs.passcode(callsign) {
    Ok(c) => c
    Err(_) => -1
  }
  let tracking = out_base.length() > 0
  let collect = tracking || count_limit > 0
  let store = @track.TrackStore::with_reference(now_reference(), 0)
  let mut points = 0
  let mut pending = 0
  let client = @aprs.IsClient::new(callsign, passcode, filter)
  println(
    "connecting to " +
    host +
    ":" +
    port.to_string() +
    " as " +
    callsign +
    " ...",
  )
  if tracking {
    println("saving tracks to " + out_base + ".gpx / " + out_base + ".geojson")
  }
  client.run(
    fn() { tcp_connect(host, port) },
    fn(event) {
      let mut stop = false
      match event {
        @aprs.LoggedIn(_) => println("[logged in]")
        @aprs.Comment(text) => println("# " + text)
        @aprs.Packet(packet) => {
          let header = packet.header()
          println(header.source().to_string() + "  " + header.info_field())
          if collect && store.ingest(packet) {
            points = points + 1
            pending = pending + 1
            if count_limit > 0 && points >= count_limit {
              stop = true
            } else if tracking && pending >= 25 {
              export_tracks(out_base, store)
              pending = 0
            }
          }
        }
        @aprs.Malformed(err) => println("[malformed] " + err)
        @aprs.Ignored => ()
        @aprs.Eof => println("[connection lost, reconnecting]")
      }
      !stop
    },
    sleep_ms,
  )
  if tracking && pending > 0 {
    export_tracks(out_base, store)
  }
  if collect {
    println("collected " + points.to_string() + " position points")
  }
}
