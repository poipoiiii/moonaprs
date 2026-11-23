///|
/// Wasm / JavaScript have no raw TCP sockets, so `is-live` is native-only.
fn is_live_usage() -> Unit {
  println("usage: moonaprs is-live [host] [port] <callsign> [filter]")
}

///|
fn is_live_command(_args : Array[String]) -> Unit {
  is_live_usage()
  println(
    "error: is-live requires raw TCP sockets and is only available on the native target",
  )
}
