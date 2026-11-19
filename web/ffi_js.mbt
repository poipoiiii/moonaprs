///|
/// JS FFI: the DOM lives in `index.html`; MoonBit owns parsing and rendering.
pub extern "js" fn js_bind(run_parse : (String) -> Unit) -> Unit =
  #| function(cb) {
  #|   const input = document.getElementById('input');
  #|   const button = document.getElementById('parse');
  #|   const run = () => cb(input.value);
  #|   button.addEventListener('click', run);
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
