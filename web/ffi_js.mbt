///|
/// JS FFI: the DOM lives in `index.html`; MoonBit owns parsing and rendering.
pub extern "js" fn js_bind(
  run_parse : (String) -> Unit,
  run_gpx : (String) -> Unit,
  run_geojson : (String) -> Unit,
) -> Unit =
  #| function(parse, gpx, geojson) {
  #|   const input = document.getElementById('input');
  #|   const run = () => parse(input.value);
  #|   document.getElementById('parse').addEventListener('click', run);
  #|   document.getElementById('gpx').addEventListener('click', () => gpx(input.value));
  #|   document.getElementById('geojson').addEventListener('click', () => geojson(input.value));
  #|   input.addEventListener('keydown', (e) => {
  #|     if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') run();
  #|   });
  #|   run();
  #| }

///|
/// Write the decoded report and the SVG map into the page.
pub extern "js" fn js_render(report : String, svg : String) -> Unit =
  #| function(report, svg) {
  #|   document.getElementById('report').textContent = report;
  #|   document.getElementById('map').innerHTML = svg;
  #| }

///|
/// Trigger a browser download for exported GPX / GeoJSON text.
pub extern "js" fn js_download(name : String, content : String) -> Unit =
  #| function(name, content) {
  #|   const blob = new Blob([content], { type: 'application/octet-stream' });
  #|   const url = URL.createObjectURL(blob);
  #|   const a = document.createElement('a');
  #|   a.href = url;
  #|   a.download = name;
  #|   a.click();
  #|   URL.revokeObjectURL(url);
  #| }

///|
/// Current time as milliseconds since the Unix epoch (browser wall clock).
pub extern "js" fn js_now_ms() -> Double =
  #| function() {
  #|   return Date.now();
  #| }
