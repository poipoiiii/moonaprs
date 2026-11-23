///|
fn is_live_usage() -> Unit {
  println("usage: moonaprs is-live [host] [port] <callsign> [filter]")
  println("  connects to a live APRS-IS server and prints decoded packets")
  println("  defaults: host=rotate.aprs2.net  port=14580  filter=(none)")
  println("  pass -1 (receive-only) if callsign has no passcode")
}

///|
fn is_live_command(args : Array[String]) -> Unit {
  let mut host = "rotate.aprs2.net"
  let mut port = 14580
  let mut pos = 2
  // Leading "host port" is detected by a numeric second argument.
  if args.length() >= 4 {
    match @aprs.parse_digits(args[3]) {
      Some(p) => {
        host = args[2]
        port = p
        pos = 4
      }
      None => ()
    }
  }
  if pos >= args.length() {
    is_live_usage()
    return
  }
  let callsign = args[pos]
  let filter = if pos + 1 < args.length() { args[pos + 1] } else { "" }
  let passcode = match @aprs.passcode(callsign) {
    Ok(c) => c
    Err(_) => -1
  }
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
  client.run(
    fn() { tcp_connect(host, port) },
    fn(event) {
      match event {
        @aprs.LoggedIn(_) => println("[logged in]")
        @aprs.Comment(text) => println("# " + text)
        @aprs.Packet(packet) => {
          let header = packet.header()
          println(header.source().to_string() + "  " + header.info_field())
        }
        @aprs.Malformed(err) => println("[malformed] " + err)
        @aprs.Ignored => ()
        @aprs.Eof => println("[connection lost, reconnecting]")
      }
      true
    },
    sleep_ms,
  )
}
