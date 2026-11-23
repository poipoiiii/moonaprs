///|
/// Non-JS stubs so `moon check` and `moon test` succeed on native and Wasm.
pub fn js_bind(
  run_parse : (String) -> Unit,
  run_gpx : (String) -> Unit,
  run_geojson : (String) -> Unit,
) -> Unit {
  ignore(run_parse)
  ignore(run_gpx)
  ignore(run_geojson)
}

///|
pub fn js_render(report : String, svg : String) -> Unit {
  ignore(report)
  ignore(svg)
}

///|
pub fn js_download(name : String, content : String) -> Unit {
  ignore(name)
  ignore(content)
}

///|
pub fn js_now_ms() -> Double {
  0.0
}
