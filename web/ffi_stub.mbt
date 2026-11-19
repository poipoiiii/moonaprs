///|
/// Non-JS stubs so `moon check` and `moon test` succeed on native and Wasm.
pub fn js_bind(run_parse : (String) -> Unit) -> Unit {
  ignore(run_parse)
}

///|
pub fn js_render(report : String, svg : String) -> Unit {
  ignore(report)
  ignore(svg)
}
