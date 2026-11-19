const $reinterpret_view = new DataView(new ArrayBuffer(8));
function $i64_reinterpret_f64(a) {
  $reinterpret_view.setBigUint64(0, BigInt.asUintN(64, a), false);
  return $reinterpret_view.getFloat64(0, false);
}
function _M0TPC16string10StringView(param0, param1, param2) {
  this.str = param0;
  this.start = param1;
  this.end = param2;
}
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10Tnc2PacketsE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10Tnc2PacketsE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10Tnc2PacketsE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10Tnc2PacketsE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs9TelemetrysE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs9TelemetrysE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs9TelemetrysE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs9TelemetrysE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGUdiEsE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGUdiEsE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGUdiEsE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGUdiEsE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs7MessagesE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs7MessagesE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs7MessagesE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs7MessagesE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs12ObjectReportsE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs12ObjectReportsE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs12ObjectReportsE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs12ObjectReportsE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10ItemReportsE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10ItemReportsE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10ItemReportsE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10ItemReportsE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok.prototype.$tag = 1;
function _M0TPB13StringBuilder(param0) {
  this.val = param0;
}
class $PanicError extends Error {}
function $panic() {
  throw new $PanicError();
}
const _M0FPB19int__to__string__js = (x, radix) => {
  return x.toString(radix);
};
function _M0TPB4IterGRPC16string10StringViewE(param0, param1) {
  this.f = param0;
  this.size_hint = param1;
}
function _M0TPB4IterGcE(param0, param1) {
  this.f = param0;
  this.size_hint = param1;
}
function $oob() {
  throw new Error("Index out of bounds");
}
function _M0TPB8MutLocalGiE(param0) {
  this.val = param0;
}
function $make_array_len_and_init(a, b) {
  const arr = new Array(a);
  arr.fill(b);
  return arr;
}
const _M0MPB7JSArray4push = (arr, val) => { arr.push(val); };
function _M0TPB8MutLocalGORPC16string10StringViewE(param0) {
  this.val = param0;
}
function _M0DTPC16result6ResultGUiRPC16string10StringViewbERPB7FailureE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGUiRPC16string10StringViewbERPB7FailureE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGUiRPC16string10StringViewbERPB7FailureE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGUiRPC16string10StringViewbERPB7FailureE2Ok.prototype.$tag = 1;
function _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(param0) {
  this._0 = param0;
}
_M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure.prototype.$tag = 0;
function _M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGuRPB7FailureE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGuRPB7FailureE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGuRPB7FailureE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGuRPB7FailureE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGiRPB7FailureE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGiRPB7FailureE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGiRPB7FailureE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGiRPB7FailureE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGlRPB7FailureE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGlRPB7FailureE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGlRPB7FailureE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGlRPB7FailureE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGlRPC15error5ErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGlRPC15error5ErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGlRPC15error5ErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGlRPC15error5ErrorE2Ok.prototype.$tag = 1;
function _M0DTPC16result6ResultGiRPC15error5ErrorE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGiRPC15error5ErrorE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGiRPC15error5ErrorE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGiRPC15error5ErrorE2Ok.prototype.$tag = 1;
function _M0TP49poipoiiii8moonaprs3lib4ax2511Ax25Address(param0, param1) {
  this.callsign = param0;
  this.repeated = param1;
}
function _M0TP49poipoiiii8moonaprs3lib4ax258Callsign(param0, param1) {
  this.call = param0;
  this.ssid = param1;
}
function _M0TP49poipoiiii8moonaprs3lib4aprs7Weather(param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10) {
  this.timestamp = param0;
  this.wind_dir = param1;
  this.wind_speed = param2;
  this.gust = param3;
  this.temperature_f = param4;
  this.rain_last_hour = param5;
  this.rain_last_24h = param6;
  this.rain_since_midnight = param7;
  this.humidity = param8;
  this.pressure_tenths_hpa = param9;
  this.luminosity = param10;
}
function _M0TP49poipoiiii8moonaprs3lib4aprs10Tnc2Packet(param0, param1, param2, param3) {
  this.src = param0;
  this.dest = param1;
  this.path = param2;
  this.info = param3;
}
function _M0TP49poipoiiii8moonaprs3lib4aprs9Telemetry(param0, param1, param2, param3) {
  this.name = param0;
  this.seq = param1;
  this.analog = param2;
  this.digital = param3;
}
function _M0TP49poipoiiii8moonaprs3lib4aprs8Position(param0, param1, param2, param3, param4, param5, param6, param7) {
  this.lat = param0;
  this.lon = param1;
  this.symbol_table = param2;
  this.symbol_code = param3;
  this.comment = param4;
  this.ambiguity = param5;
  this.timestamp = param6;
  this.compressed = param7;
}
function _M0TP49poipoiiii8moonaprs3lib4aprs10ItemReport(param0, param1, param2) {
  this.name = param0;
  this.alive = param1;
  this.position = param2;
}
function _M0TP49poipoiiii8moonaprs3lib4aprs7Message(param0, param1, param2, param3) {
  this.addressee = param0;
  this.text = param1;
  this.msg_id = param2;
  this.ack_id = param3;
}
function _M0TP49poipoiiii8moonaprs3lib4aprs12ObjectReport(param0, param1, param2, param3) {
  this.name = param0;
  this.alive = param1;
  this.timestamp = param2;
  this.position = param3;
}
function _M0TP49poipoiiii8moonaprs3lib4aprs6Status(param0, param1) {
  this.text = param0;
  this.timestamp = param1;
}
function _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody8Position(param0) {
  this._0 = param0;
}
_M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody8Position.prototype.$tag = 0;
function _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody19PositionWithWeather(param0, param1) {
  this._0 = param0;
  this._1 = param1;
}
_M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody19PositionWithWeather.prototype.$tag = 1;
function _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody7Weather(param0) {
  this._0 = param0;
}
_M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody7Weather.prototype.$tag = 2;
function _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody9Telemetry(param0) {
  this._0 = param0;
}
_M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody9Telemetry.prototype.$tag = 3;
function _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody6Status(param0) {
  this._0 = param0;
}
_M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody6Status.prototype.$tag = 4;
function _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody7Message(param0) {
  this._0 = param0;
}
_M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody7Message.prototype.$tag = 5;
function _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody6Object(param0) {
  this._0 = param0;
}
_M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody6Object.prototype.$tag = 6;
function _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody4Item(param0) {
  this._0 = param0;
}
_M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody4Item.prototype.$tag = 7;
function _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody5Query(param0) {
  this._0 = param0;
}
_M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody5Query.prototype.$tag = 8;
function _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody10ThirdParty(param0) {
  this._0 = param0;
}
_M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody10ThirdParty.prototype.$tag = 9;
function _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody7Unknown(param0) {
  this._0 = param0;
}
_M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody7Unknown.prototype.$tag = 10;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10AprsPacketsE3Err(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10AprsPacketsE3Err.prototype.$tag = 0;
function _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10AprsPacketsE2Ok(param0) {
  this._0 = param0;
}
_M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10AprsPacketsE2Ok.prototype.$tag = 1;
function _M0TP49poipoiiii8moonaprs3lib4aprs10AprsPacket(param0, param1) {
  this.header = param0;
  this.body = param1;
}
function _M0TP49poipoiiii8moonaprs3lib5track10TrackPoint(param0, param1, param2, param3) {
  this.lat = param0;
  this.lon = param1;
  this.time = param2;
  this.comment = param3;
}
function _M0TP49poipoiiii8moonaprs3lib5track5Track(param0, param1) {
  this.callsign = param0;
  this.points = param1;
}
function _M0TP49poipoiiii8moonaprs3lib5track10TrackStore(param0) {
  this.tracks = param0;
}
function _M0TP49poipoiiii8moonaprs3lib3svg9Projector(param0, param1, param2) {
  this.scale = param0;
  this.offset_x = param1;
  this.offset_y = param2;
}
const _M0FP39poipoiiii8moonaprs3web10js__render = function(report, svg) {
   document.getElementById('report').textContent = report;
   document.getElementById('map').innerHTML = svg;
 };
const _M0FP39poipoiiii8moonaprs3web8js__bind = function(cb) {
   const input = document.getElementById('input');
   const button = document.getElementById('parse');
   const run = () => cb(input.value);
   button.addEventListener('click', run);
   input.addEventListener('keydown', (e) => {
     if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') run();
   });
   run();
 };
const _M0MPB4Iter4nextN6constrS35GRPC16string10StringViewE = 0;
const _M0MPB4Iter4nextN6constrS36GRPC16string10StringViewE = 0;
const _M0MPB4Iter4nextN6constrS43GcE = 0;
const _M0MPB4Iter4nextN6constrS44GcE = 0;
const _M0MPB4Iter3newN6constrS53GRPC16string10StringViewE = 0;
const _M0MPB4Iter3newN6constrS59GcE = 0;
const _M0FPC16double8infinity = $i64_reinterpret_f64(9218868437227405312n);
const _M0FPC16double13neg__infinity = $i64_reinterpret_f64(18442240474082181120n);
const _M0FPC28internal7strconv14base__err__str = "invalid base";
const _M0FPC28internal7strconv15range__err__str = "value out of range";
const _M0FPC28internal7strconv16syntax__err__str = "invalid syntax";
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS514 = 3;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS515 = 3;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS516 = 3;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS517 = 3;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS518 = 3;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS519 = 3;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS520 = 3;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS521 = 2;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS522 = 5;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS523 = 3;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS524 = 3;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS525 = 3;
const _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS526 = 3;
const _M0FP49poipoiiii8moonaprs3lib3svg7palette = ["#2563eb", "#dc2626", "#059669", "#d97706", "#7c3aed", "#0891b2", "#db2777", "#65a30d"];
const _M0MPC16string6String4trimN6recordS348 = new _M0TPC16string10StringView("\t\n\r ", 0, 4);
const _M0MPC16string10StringView4findN6constrS209 = 0;
const _M0FPC28internal7strconv20parse__int64_2einnerN6recordS443 = new _M0TPC16string10StringView("", 0, 0);
const _M0MP49poipoiiii8moonaprs3lib4ax258Callsign5parseN6recordS506 = new _M0TPC16string10StringView("-", 0, 1);
const _M0MP49poipoiiii8moonaprs3lib4aprs10Tnc2Packet5parseN6constrS688 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10Tnc2PacketsE3Err("missing ':' between header and information field");
const _M0MP49poipoiiii8moonaprs3lib4aprs10Tnc2Packet5parseN6constrS689 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10Tnc2PacketsE3Err("missing '>' between source and destination");
const _M0MP49poipoiiii8moonaprs3lib4aprs10Tnc2Packet5parseN6constrS690 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10Tnc2PacketsE3Err("missing destination callsign");
const _M0FP49poipoiiii8moonaprs3lib4aprs16parse__telemetryN6constrS723 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs9TelemetrysE3Err("telemetry needs a name and a sequence number");
const _M0FP49poipoiiii8moonaprs3lib4aprs16parse__telemetryN6constrS724 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs9TelemetrysE3Err("telemetry channel name is empty");
const _M0FP49poipoiiii8moonaprs3lib4aprs16parse__telemetryN6constrS725 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs9TelemetrysE3Err("telemetry sequence is not a number");
const _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lonN6constrS772 = new _M0DTPC16result6ResultGUdiEsE3Err("longitude is truncated");
const _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lonN6constrS773 = new _M0DTPC16result6ResultGUdiEsE3Err("longitude is missing the decimal point");
const _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lonN6constrS774 = new _M0DTPC16result6ResultGUdiEsE3Err("longitude contains a non-digit");
const _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lonN6constrS775 = new _M0DTPC16result6ResultGUdiEsE3Err("longitude hemisphere must be E or W");
const _M0FP49poipoiiii8moonaprs3lib4aprs10parse__latN6constrS754 = new _M0DTPC16result6ResultGUdiEsE3Err("latitude is truncated");
const _M0FP49poipoiiii8moonaprs3lib4aprs10parse__latN6constrS755 = new _M0DTPC16result6ResultGUdiEsE3Err("latitude is missing the decimal point");
const _M0FP49poipoiiii8moonaprs3lib4aprs10parse__latN6constrS756 = new _M0DTPC16result6ResultGUdiEsE3Err("latitude contains a non-digit");
const _M0FP49poipoiiii8moonaprs3lib4aprs10parse__latN6constrS757 = new _M0DTPC16result6ResultGUdiEsE3Err("latitude hemisphere must be N or S");
const _M0FP49poipoiiii8moonaprs3lib4aprs19parse__uncompressedN6constrS800 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE3Err("symbol is missing");
const _M0FP49poipoiiii8moonaprs3lib4aprs17parse__compressedN6constrS820 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE3Err("compressed position is truncated");
const _M0FP49poipoiiii8moonaprs3lib4aprs17parse__compressedN6constrS821 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE3Err("invalid base-91 latitude");
const _M0FP49poipoiiii8moonaprs3lib4aprs17parse__compressedN6constrS822 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE3Err("invalid base-91 longitude");
const _M0FP49poipoiiii8moonaprs3lib4aprs15parse__positionN6constrS834 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE3Err("empty position report");
const _M0FP49poipoiiii8moonaprs3lib4aprs15parse__positionN6constrS835 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE3Err("position is missing after the timestamp");
const _M0FP49poipoiiii8moonaprs3lib4aprs15parse__positionN6constrS836 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE3Err("unsupported position encoding");
const _M0FP49poipoiiii8moonaprs3lib4aprs14parse__messageN6constrS870 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs7MessagesE3Err("message must start with a nine character addressee");
const _M0FP49poipoiiii8moonaprs3lib4aprs14parse__messageN6constrS871 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs7MessagesE3Err("message addressee is empty");
const _M0FP49poipoiiii8moonaprs3lib4aprs14parse__messageN6constrS872 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs7MessagesE3Err("message text is missing");
const _M0FP49poipoiiii8moonaprs3lib4aprs13parse__objectN6constrS905 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs12ObjectReportsE3Err("object report is truncated");
const _M0FP49poipoiiii8moonaprs3lib4aprs13parse__objectN6constrS906 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs12ObjectReportsE3Err("object name is empty");
const _M0FP49poipoiiii8moonaprs3lib4aprs13parse__objectN6constrS907 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs12ObjectReportsE3Err("object alive flag must be '*' or '_'");
const _M0FP49poipoiiii8moonaprs3lib4aprs11parse__itemN6constrS849 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10ItemReportsE3Err("item name is not terminated by '!' or '_'");
const _M0FP49poipoiiii8moonaprs3lib4aprs11parse__itemN6constrS850 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10ItemReportsE3Err("item name is empty");
const _M0FP49poipoiiii8moonaprs3lib4aprs11parse__infoN6constrS949 = new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE3Err("empty information field");
const _M0MPC16string10StringView4trimN6recordS341 = new _M0TPC16string10StringView("\t\n\r ", 0, 4);
const _M0FP39poipoiiii8moonaprs3web10parse__allN6recordS1159 = new _M0TPC16string10StringView("\n", 0, 1);
const _M0FP39poipoiiii8moonaprs3web10parse__allN6recordS1160 = new _M0TPC16string10StringView("#", 0, 1);
function _M0MPB13StringBuilder21StringBuilder_2einner(size_hint) {
  return new _M0TPB13StringBuilder("");
}
function _M0IPB13StringBuilderPB6Logger11write__char(self, ch) {
  self.val = `${self.val}${String.fromCodePoint(ch)}`;
}
function _M0IPB13StringBuilderPB6Logger13write__string(self, str) {
  self.val = `${self.val}${str}`;
}
function _M0FPB32code__point__of__surrogate__pair(leading, trailing) {
  return (((Math.imul(leading - 55296 | 0, 1024) | 0) + trailing | 0) - 56320 | 0) + 65536 | 0;
}
function _M0MPC16string6String16unsafe__char__at(self, index) {
  const c1 = self.charCodeAt(index);
  if (c1 >= 55296 && c1 <= 56319) {
    const c2 = self.charCodeAt(index + 1 | 0);
    return _M0FPB32code__point__of__surrogate__pair(c1, c2);
  } else {
    return c1;
  }
}
function _M0MPC16string10StringView12view_2einner(self, start_offset, end_offset) {
  let end_offset$2;
  if (end_offset === undefined) {
    end_offset$2 = self.end - self.start | 0;
  } else {
    const _Some = end_offset;
    end_offset$2 = _Some;
  }
  if (start_offset >= 0 && (start_offset <= end_offset$2 && end_offset$2 <= (self.end - self.start | 0))) {
    return new _M0TPC16string10StringView(self.str, self.start + start_offset | 0, self.start + end_offset$2 | 0);
  } else {
    return $panic();
  }
}
function _M0IP016_24default__implPB2Eq10not__equalGRPC16string10StringViewE(x, y) {
  return !_M0IPC16string10StringViewPB2Eq5equal(x, y);
}
function _M0MPB4Iter4nextGRPC16string10StringViewE(self) {
  const _func = self.f;
  const result = _func();
  const _bind = self.size_hint;
  if (result === undefined) {
    self.size_hint = _M0MPB4Iter4nextN6constrS36GRPC16string10StringViewE;
  } else {
    if (_bind === undefined) {
    } else {
      const _Some = _bind;
      const _n = _Some;
      self.size_hint = _n > 0 ? _n - 1 | 0 : _M0MPB4Iter4nextN6constrS35GRPC16string10StringViewE;
    }
  }
  return result;
}
function _M0MPB4Iter4nextGcE(self) {
  const _func = self.f;
  const result = _func();
  const _bind = self.size_hint;
  if (result === -1) {
    self.size_hint = _M0MPB4Iter4nextN6constrS44GcE;
  } else {
    if (_bind === undefined) {
    } else {
      const _Some = _bind;
      const _n = _Some;
      self.size_hint = _n > 0 ? _n - 1 | 0 : _M0MPB4Iter4nextN6constrS43GcE;
    }
  }
  return result;
}
function _M0MPC13int3Int18to__string_2einner(self, radix) {
  return _M0FPB19int__to__string__js(self, radix);
}
function _M0MPB4Iter3newGRPC16string10StringViewE(f, size_hint) {
  let size_hint$2;
  if (size_hint === undefined) {
    size_hint$2 = undefined;
  } else {
    const _Some = size_hint;
    const _n = _Some;
    size_hint$2 = _n > 0 ? _n : _M0MPB4Iter3newN6constrS53GRPC16string10StringViewE;
  }
  return new _M0TPB4IterGRPC16string10StringViewE(f, size_hint$2);
}
function _M0MPB4Iter3newGcE(f, size_hint) {
  let size_hint$2;
  if (size_hint === undefined) {
    size_hint$2 = undefined;
  } else {
    const _Some = size_hint;
    const _n = _Some;
    size_hint$2 = _n > 0 ? _n : _M0MPB4Iter3newN6constrS59GcE;
  }
  return new _M0TPB4IterGcE(f, size_hint$2);
}
function _M0MPC16string10StringView9to__owned(self) {
  return self.str.substring(self.start, self.end);
}
function _M0MPC16string10StringView4iter(self) {
  const start = self.start;
  const end = self.end;
  const index = new _M0TPB8MutLocalGiE(start);
  return _M0MPB4Iter3newGcE(() => {
    if (index.val < end) {
      const c1 = self.str.charCodeAt(index.val);
      if (c1 >= 55296 && c1 <= 56319 && (index.val + 1 | 0) < self.end) {
        const c2 = self.str.charCodeAt(index.val + 1 | 0);
        if (c2 >= 56320 && c2 <= 57343) {
          index.val = index.val + 2 | 0;
          return _M0FPB32code__point__of__surrogate__pair(c1, c2);
        }
      }
      index.val = index.val + 1 | 0;
      return c1;
    } else {
      return -1;
    }
  }, undefined);
}
function _M0MPC16string6String20unsafe__range__equal(self, self_off, other, other_off, len) {
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < len) {
      const _p = self.charCodeAt(self_off + i | 0);
      const _p$2 = other.charCodeAt(other_off + i | 0);
      if (_p === _p$2) {
      } else {
        return false;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return true;
}
function _M0IPC16string10StringViewPB2Eq5equal(self, other) {
  const len = self.end - self.start | 0;
  if (len === (other.end - other.start | 0)) {
    if (self.str === other.str && self.start === other.start) {
      return true;
    }
    return _M0MPC16string6String20unsafe__range__equal(self.str, self.start, other.str, other.start, len);
  } else {
    return false;
  }
}
function _M0MPC16string6String31offset__of__nth__char__backward(self, n, start_offset, end_offset) {
  let _tmp = end_offset;
  let _tmp$2 = 0;
  while (true) {
    const utf16_offset = _tmp;
    const char_count = _tmp$2;
    if ((utf16_offset - 1 | 0) >= start_offset && char_count < n) {
      const c = self.charCodeAt(utf16_offset - 1 | 0);
      if (c >= 56320 && c <= 57343) {
        _tmp = utf16_offset - 2 | 0;
        _tmp$2 = char_count + 1 | 0;
        continue;
      } else {
        _tmp = utf16_offset - 1 | 0;
        _tmp$2 = char_count + 1 | 0;
        continue;
      }
    } else {
      return char_count < n || utf16_offset < start_offset ? undefined : utf16_offset;
    }
  }
}
function _M0MPC16string6String30offset__of__nth__char__forward(self, n, start_offset, end_offset) {
  if (start_offset >= 0 && start_offset <= end_offset) {
    let _tmp = start_offset;
    let _tmp$2 = 0;
    while (true) {
      const utf16_offset = _tmp;
      const char_count = _tmp$2;
      if (utf16_offset < end_offset && char_count < n) {
        const c = self.charCodeAt(utf16_offset);
        if (c >= 55296 && c <= 56319) {
          _tmp = utf16_offset + 2 | 0;
          _tmp$2 = char_count + 1 | 0;
          continue;
        } else {
          _tmp = utf16_offset + 1 | 0;
          _tmp$2 = char_count + 1 | 0;
          continue;
        }
      } else {
        return char_count < n || utf16_offset >= end_offset ? undefined : utf16_offset;
      }
    }
  } else {
    return $panic();
  }
}
function _M0MPC16string6String29offset__of__nth__char_2einner(self, i, start_offset, end_offset) {
  let end_offset$2;
  if (end_offset === undefined) {
    end_offset$2 = self.length;
  } else {
    const _Some = end_offset;
    end_offset$2 = _Some;
  }
  return i >= 0 ? _M0MPC16string6String30offset__of__nth__char__forward(self, i, start_offset, end_offset$2) : _M0MPC16string6String31offset__of__nth__char__backward(self, -i | 0, start_offset, end_offset$2);
}
function _M0MPC16string6String12view_2einner(self, start_offset, end_offset) {
  let end_offset$2;
  if (end_offset === undefined) {
    end_offset$2 = self.length;
  } else {
    const _Some = end_offset;
    end_offset$2 = _Some;
  }
  if (start_offset >= 0 && (start_offset <= end_offset$2 && end_offset$2 <= self.length)) {
    return new _M0TPC16string10StringView(self, start_offset, end_offset$2);
  } else {
    return $panic();
  }
}
function _M0MPB13StringBuilder5reset(self) {
  self.val = "";
}
function _M0FPB19kmp__failure__table(pattern) {
  const m = pattern.end - pattern.start | 0;
  const table = $make_array_len_and_init(m, 0);
  let k = 0;
  let _tmp = 1;
  while (true) {
    const i = _tmp;
    if (i < m) {
      const c = pattern.str.charCodeAt(pattern.start + i | 0);
      while (true) {
        let _tmp$2;
        if (k > 0) {
          const _p = pattern.str.charCodeAt(pattern.start + k | 0);
          _tmp$2 = c !== _p;
        } else {
          _tmp$2 = false;
        }
        if (_tmp$2) {
          const _tmp$3 = k - 1 | 0;
          k = _tmp$3 >>> 0 < table.length ? table[_tmp$3] : $oob();
          continue;
        } else {
          break;
        }
      }
      const _p = pattern.str.charCodeAt(pattern.start + k | 0);
      if (c === _p) {
        k = k + 1 | 0;
      }
      if (i >>> 0 < table.length) {
        table[i] = k;
      } else {
        $oob();
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return table;
}
function _M0FPB24find__pattern__kmp__from(target, pattern, start) {
  const n = target.end - target.start | 0;
  const m = pattern.end - pattern.start | 0;
  const table = _M0FPB19kmp__failure__table(pattern);
  let k = 0;
  let _tmp = start;
  while (true) {
    const i = _tmp;
    if (i < n) {
      const c = target.str.charCodeAt(target.start + i | 0);
      while (true) {
        let _tmp$2;
        if (k > 0) {
          const _p = pattern.str.charCodeAt(pattern.start + k | 0);
          _tmp$2 = c !== _p;
        } else {
          _tmp$2 = false;
        }
        if (_tmp$2) {
          const _tmp$3 = k - 1 | 0;
          k = _tmp$3 >>> 0 < table.length ? table[_tmp$3] : $oob();
          continue;
        } else {
          break;
        }
      }
      const _p = pattern.str.charCodeAt(pattern.start + k | 0);
      if (c === _p) {
        k = k + 1 | 0;
      }
      if (k === m) {
        return (i - m | 0) + 1 | 0;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return undefined;
}
function _M0FPB36find__two__anchor__candidate__scalar(data, start, candidate_end, first, last_offset, last) {
  let _tmp = start;
  while (true) {
    const pos = _tmp;
    if (pos < candidate_end) {
      let _tmp$2;
      const _p = data.charCodeAt(pos);
      if (_p === first) {
        const _p$2 = data.charCodeAt(pos + last_offset | 0);
        _tmp$2 = _p$2 === last;
      } else {
        _tmp$2 = false;
      }
      if (_tmp$2) {
        return pos;
      }
      _tmp = pos + 1 | 0;
      continue;
    } else {
      return -1;
    }
  }
}
function _M0FPB42find__two__anchor__candidate__from__string(data, start, candidate_end, first, last_offset, last) {
  return _M0FPB36find__two__anchor__candidate__scalar(data, start, candidate_end, first, last_offset, last);
}
function _M0FPB21string__ranges__equal(left, left_start, right, right_start, length) {
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < length) {
      const _p = left.charCodeAt(left_start + i | 0);
      const _p$2 = right.charCodeAt(right_start + i | 0);
      if (_p !== _p$2) {
        return false;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return true;
}
function _M0FPB22find__by__two__anchors(target, pattern) {
  const target_len = target.end - target.start | 0;
  const pattern_len = pattern.end - pattern.start | 0;
  const target_start = target.start;
  const pattern_start = pattern.start;
  const last_offset = pattern_len - 1 | 0;
  const candidate_end = ((target_start + target_len | 0) - pattern_len | 0) + 1 | 0;
  const first = pattern.str.charCodeAt(pattern.start);
  const last = pattern.str.charCodeAt(pattern.start + last_offset | 0);
  const middle_len = last_offset - 1 | 0;
  let _tmp = target_start;
  let _tmp$2 = 0;
  while (true) {
    const pos = _tmp;
    const failures = _tmp$2;
    if (pos < candidate_end) {
      const found = _M0FPB42find__two__anchor__candidate__from__string(target.str, pos, candidate_end, first, last_offset, last);
      if (found < 0) {
        return undefined;
      }
      if (_M0FPB21string__ranges__equal(target.str, found + 1 | 0, pattern.str, pattern_start + 1 | 0, middle_len)) {
        return found - target_start | 0;
      }
      const failures$2 = failures + 1 | 0;
      const scanned = found - target_start | 0;
      if (failures$2 > 64 || failures$2 > (4 + (scanned / 8 | 0) | 0)) {
        return _M0FPB24find__pattern__kmp__from(target, pattern, scanned + 1 | 0);
      }
      _tmp = found + 1 | 0;
      _tmp$2 = failures$2;
      continue;
    } else {
      return undefined;
    }
  }
}
function _M0FPB24find__code__unit__scalar(data, start, end, code) {
  let _tmp = start;
  while (true) {
    const pos = _tmp;
    if (pos < end) {
      const _p = data.charCodeAt(pos);
      if (_p === code) {
        return pos;
      }
      _tmp = pos + 1 | 0;
      continue;
    } else {
      return -1;
    }
  }
}
function _M0FPB30find__code__unit__from__string(data, start, end, code) {
  return _M0FPB24find__code__unit__scalar(data, start, end, code);
}
function _M0FPB28find__code__unit__from__view(target, start, end, code) {
  const target_start = target.start;
  const found = _M0FPB30find__code__unit__from__string(target.str, target_start + start | 0, target_start + end | 0, code);
  return found < 0 ? -1 : found - target_start | 0;
}
function _M0MPC16string10StringView4find(self, str) {
  const pattern_len = str.end - str.start | 0;
  switch (pattern_len) {
    case 0: {
      return _M0MPC16string10StringView4findN6constrS209;
    }
    case 1: {
      const found = _M0FPB28find__code__unit__from__view(self, 0, self.end - self.start | 0, str.str.charCodeAt(str.start));
      return found < 0 ? undefined : found;
    }
    default: {
      return pattern_len > (self.end - self.start | 0) ? undefined : _M0FPB22find__by__two__anchors(self, str);
    }
  }
}
function _M0MPC16string10StringView11has__prefix(self, str) {
  const str_len = str.end - str.start | 0;
  if (str_len <= (self.end - self.start | 0)) {
    let _tmp;
    if (str_len === 0) {
      _tmp = true;
    } else {
      const _p = self.str.charCodeAt(self.start);
      const _p$2 = str.str.charCodeAt(str.start);
      _tmp = _p === _p$2;
    }
    if (_tmp) {
      return _M0MPC16string6String20unsafe__range__equal(self.str, self.start, str.str, str.start, str_len);
    } else {
      return false;
    }
  } else {
    return false;
  }
}
function _M0MPC16string6String11has__prefix(self, str) {
  return _M0MPC16string10StringView11has__prefix(new _M0TPC16string10StringView(self, 0, self.length), str);
}
function _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(self, value) {
  _M0MPB7JSArray4push(self, value);
}
function _M0MPC15array5Array4pushGcE(self, value) {
  _M0MPB7JSArray4push(self, value);
}
function _M0MPC15array5Array4pushGiE(self, value) {
  _M0MPB7JSArray4push(self, value);
}
function _M0FPB36string__contains__code__unit__scalar(str, start, end, code) {
  let _tmp = start;
  while (true) {
    const i = _tmp;
    if (i < end) {
      const _p = str.charCodeAt(i);
      if (_p === code) {
        return true;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return false;
}
function _M0FPB28string__contains__code__unit(str, start, end, code) {
  return _M0FPB36string__contains__code__unit__scalar(str, start, end, code);
}
function _M0MPC16string10StringView20contains__code__unit(self, code) {
  return _M0FPB28string__contains__code__unit(self.str, self.start, self.end, code);
}
function _M0FPB23build__ascii__char__set(chars) {
  let bits0 = 0;
  let bits1 = 0;
  let bits2 = 0;
  let bits3 = 0;
  const _bind = chars.str;
  const _bind$2 = chars.start;
  const _bind$3 = chars.end;
  let _tmp = _bind$2;
  while (true) {
    const _string_index = _tmp;
    if (_string_index < _bind$3) {
      let _decoded_next_string_index;
      let _decoded_char;
      _L: {
        const _bind$4 = _bind.charCodeAt(_string_index);
        if (_bind$4 >= 55296 && _bind$4 <= 56319 && (_string_index + 1 | 0) < _bind$3) {
          const _bind$5 = _bind.charCodeAt(_string_index + 1 | 0);
          if (_bind$5 >= 56320 && _bind$5 <= 57343) {
            const _tmp$2 = _string_index + 2 | 0;
            const _p = (((Math.imul(_bind$4 - 55296 | 0, 1024) | 0) + _bind$5 | 0) - 56320 | 0) + 65536 | 0;
            _decoded_next_string_index = _tmp$2;
            _decoded_char = _p;
            break _L;
          } else {
            const _tmp$2 = _string_index + 1 | 0;
            const _p = _bind$4;
            _decoded_next_string_index = _tmp$2;
            _decoded_char = _p;
            break _L;
          }
        } else {
          const _tmp$2 = _string_index + 1 | 0;
          const _p = _bind$4;
          _decoded_next_string_index = _tmp$2;
          _decoded_char = _p;
          break _L;
        }
      }
      const code = _decoded_char;
      if (code >>> 0 < 128 >>> 0) {
        const bit = 1 << (code & 31);
        const _bind$4 = code >>> 5 | 0;
        switch (_bind$4) {
          case 0: {
            bits0 = bits0 | bit;
            break;
          }
          case 1: {
            bits1 = bits1 | bit;
            break;
          }
          case 2: {
            bits2 = bits2 | bit;
            break;
          }
          default: {
            bits3 = bits3 | bit;
          }
        }
      } else {
        return undefined;
      }
      _tmp = _decoded_next_string_index;
      continue;
    } else {
      break;
    }
  }
  return { _0: bits0, _1: bits1, _2: bits2, _3: bits3 };
}
function _M0FPB26ascii__char__set__contains(bits0, bits1, bits2, bits3, code) {
  if (code >>> 0 < 128 >>> 0) {
    const bit = 1 << (code & 31);
    const _bind = code >>> 5 | 0;
    switch (_bind) {
      case 0: {
        return (bits0 & bit) !== 0;
      }
      case 1: {
        return (bits1 & bit) !== 0;
      }
      case 2: {
        return (bits2 & bit) !== 0;
      }
      default: {
        return (bits3 & bit) !== 0;
      }
    }
  } else {
    return false;
  }
}
function _M0FPB34string__trim__start__ascii__scalar(str, start, end, bits0, bits1, bits2, bits3) {
  let _tmp = start;
  while (true) {
    const pos = _tmp;
    let _tmp$2;
    if (pos < end) {
      const _p = str.charCodeAt(pos);
      _tmp$2 = _M0FPB26ascii__char__set__contains(bits0, bits1, bits2, bits3, _p);
    } else {
      _tmp$2 = false;
    }
    if (_tmp$2) {
      _tmp = pos + 1 | 0;
      continue;
    } else {
      return pos;
    }
  }
}
function _M0FPB32string__trim__end__ascii__scalar(str, start, end, bits0, bits1, bits2, bits3) {
  let _tmp = end;
  while (true) {
    const pos = _tmp;
    let _tmp$2;
    if (pos > start) {
      const _p = str.charCodeAt(pos - 1 | 0);
      _tmp$2 = _M0FPB26ascii__char__set__contains(bits0, bits1, bits2, bits3, _p);
    } else {
      _tmp$2 = false;
    }
    if (_tmp$2) {
      _tmp = pos - 1 | 0;
      continue;
    } else {
      return pos;
    }
  }
}
function _M0FPB26string__trim__start__ascii(str, start, end, _chars, bits0, bits1, bits2, bits3) {
  return _M0FPB34string__trim__start__ascii__scalar(str, start, end, bits0, bits1, bits2, bits3);
}
function _M0FPB24string__trim__end__ascii(str, start, end, _chars, bits0, bits1, bits2, bits3) {
  return _M0FPB32string__trim__end__ascii__scalar(str, start, end, bits0, bits1, bits2, bits3);
}
function _M0MPC16string10StringView14contains__char(self, c) {
  const len = self.end - self.start | 0;
  if (len > 0) {
    const c$2 = c;
    if (c$2 >= 0 && c$2 <= 65535) {
      return _M0MPC16string10StringView20contains__code__unit(self, c$2 & 65535);
    } else {
      if (c$2 < 0) {
        return false;
      } else {
        if (len >= 2) {
          const adj = c$2 - 65536 | 0;
          const high = 55296 + (adj >> 10) | 0;
          if (high <= 65535) {
            const high$2 = high & 65535;
            const low = (56320 + (adj & 1023) | 0) & 65535;
            let _tmp = 0;
            while (true) {
              const i = _tmp;
              if (i < (len - 1 | 0)) {
                const _p = self.str.charCodeAt(self.start + i | 0);
                if (_p === high$2) {
                  const _p$2 = self.str.charCodeAt(self.start + (i + 1 | 0) | 0);
                  if (_p$2 === low) {
                    return true;
                  }
                  _tmp = i + 2 | 0;
                  continue;
                }
                _tmp = i + 1 | 0;
                continue;
              } else {
                break;
              }
            }
          } else {
            return false;
          }
        } else {
          return false;
        }
      }
    }
    return false;
  } else {
    return false;
  }
}
function _M0MPC16string10StringView24trim__start__with__chars(self, chars) {
  let _tmp = self;
  while (true) {
    const x = _tmp;
    if ((x.end - x.start | 0) === 0) {
      return x;
    } else {
      const _c = _M0MPC16string6String16unsafe__char__at(x.str, _M0MPC16string6String29offset__of__nth__char_2einner(x.str, 0, x.start, x.end));
      const _tmp$2 = x.str;
      const _bind = _M0MPC16string6String29offset__of__nth__char_2einner(x.str, 1, x.start, x.end);
      let _tmp$3;
      if (_bind === undefined) {
        _tmp$3 = x.end;
      } else {
        const _Some = _bind;
        _tmp$3 = _Some;
      }
      const _x = new _M0TPC16string10StringView(_tmp$2, _tmp$3, x.end);
      if (_M0MPC16string10StringView14contains__char(chars, _c)) {
        _tmp = _x;
        continue;
      } else {
        return x;
      }
    }
  }
}
function _M0MPC16string10StringView22trim__end__with__chars(self, chars) {
  let _tmp = self;
  while (true) {
    const x = _tmp;
    if ((x.end - x.start | 0) === 0) {
      return x;
    } else {
      const _c = _M0MPC16string6String16unsafe__char__at(x.str, _M0MPC16string6String29offset__of__nth__char_2einner(x.str, -1, x.start, x.end));
      const _x = new _M0TPC16string10StringView(x.str, x.start, _M0MPC16string6String29offset__of__nth__char_2einner(x.str, -1, x.start, x.end));
      if (_M0MPC16string10StringView14contains__char(chars, _c)) {
        _tmp = _x;
        continue;
      } else {
        return x;
      }
    }
  }
}
function _M0MPC16string10StringView12trim_2einner(self, chars) {
  const _bind = _M0FPB23build__ascii__char__set(chars);
  if (_bind === undefined) {
    return _M0MPC16string10StringView22trim__end__with__chars(_M0MPC16string10StringView24trim__start__with__chars(self, chars), chars);
  } else {
    const _Some = _bind;
    const _x = _Some;
    const _bits0 = _x._0;
    const _bits1 = _x._1;
    const _bits2 = _x._2;
    const _bits3 = _x._3;
    const start = _M0FPB26string__trim__start__ascii(self.str, self.start, self.end, chars, _bits0, _bits1, _bits2, _bits3);
    const end = _M0FPB24string__trim__end__ascii(self.str, start, self.end, chars, _bits0, _bits1, _bits2, _bits3);
    return new _M0TPC16string10StringView(self.str, start, end);
  }
}
function _M0MPC16string10StringView4trim(self, chars$46$opt) {
  let chars;
  if (chars$46$opt === undefined) {
    chars = _M0MPC16string10StringView4trimN6recordS341;
  } else {
    const _Some = chars$46$opt;
    chars = _Some;
  }
  return _M0MPC16string10StringView12trim_2einner(self, chars);
}
function _M0MPC16string6String12trim_2einner(self, chars) {
  return _M0MPC16string10StringView12trim_2einner(new _M0TPC16string10StringView(self, 0, self.length), chars);
}
function _M0MPC16string6String4trim(self, chars$46$opt) {
  let chars;
  if (chars$46$opt === undefined) {
    chars = _M0MPC16string6String4trimN6recordS348;
  } else {
    const _Some = chars$46$opt;
    chars = _Some;
  }
  return _M0MPC16string6String12trim_2einner(self, chars);
}
function _M0MPB4Iter3mapGcRPC16string10StringViewE(self, f) {
  return new _M0TPB4IterGRPC16string10StringViewE(() => {
    const _bind = _M0MPB4Iter4nextGcE(self);
    if (_bind === -1) {
      return undefined;
    } else {
      const _Some = _bind;
      const _x = _Some;
      return f(_x);
    }
  }, self.size_hint);
}
function _M0IPC14char4CharPB4Show10to__string(self) {
  return String.fromCodePoint(self);
}
function _M0MPC16string10StringView5split(self, sep) {
  const sep_len = sep.end - sep.start | 0;
  if (sep_len === 0) {
    return _M0MPB4Iter3mapGcRPC16string10StringViewE(_M0MPC16string10StringView4iter(self), (c) => _M0MPC16string6String12view_2einner(_M0IPC14char4CharPB4Show10to__string(c), 0, undefined));
  }
  const remaining = new _M0TPB8MutLocalGORPC16string10StringViewE(self);
  return _M0MPB4Iter3newGRPC16string10StringViewE(() => {
    const _bind = remaining.val;
    if (_bind === undefined) {
      return undefined;
    } else {
      const _Some = _bind;
      const _view = _Some;
      const _bind$2 = _M0MPC16string10StringView4find(_view, sep);
      if (_bind$2 === undefined) {
        remaining.val = undefined;
        return _view;
      } else {
        const _Some$2 = _bind$2;
        const _end = _Some$2;
        remaining.val = _M0MPC16string10StringView12view_2einner(_view, _end + sep_len | 0, undefined);
        return _M0MPC16string10StringView12view_2einner(_view, 0, _end);
      }
    }
  }, undefined);
}
function _M0MPC16string6String5split(self, sep) {
  return _M0MPC16string10StringView5split(new _M0TPC16string10StringView(self, 0, self.length), sep);
}
function _M0MPB4Iter9to__arrayGRPC16string10StringViewE(self) {
  const _bind = self.size_hint;
  let result;
  if (_bind === undefined) {
    result = [];
  } else {
    result = [];
  }
  while (true) {
    const _bind$2 = _M0MPB4Iter4nextGRPC16string10StringViewE(self);
    if (_bind$2 === undefined) {
      break;
    } else {
      const _Some = _bind$2;
      const _x = _Some;
      _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(result, _x);
      continue;
    }
  }
  return result;
}
function _M0MPC14char4Char20is__ascii__lowercase(self) {
  return self >= 97 && self <= 122;
}
function _M0MPC16string6String9to__array(self) {
  const chars = [];
  const _bind = self.length;
  let _tmp = 0;
  while (true) {
    const _string_index = _tmp;
    if (_string_index < _bind) {
      let _decoded_next_string_index;
      let _decoded_char;
      _L: {
        const _bind$2 = self.charCodeAt(_string_index);
        if (_bind$2 >= 55296 && _bind$2 <= 56319 && (_string_index + 1 | 0) < _bind) {
          const _bind$3 = self.charCodeAt(_string_index + 1 | 0);
          if (_bind$3 >= 56320 && _bind$3 <= 57343) {
            const _tmp$2 = _string_index + 2 | 0;
            const _p = (((Math.imul(_bind$2 - 55296 | 0, 1024) | 0) + _bind$3 | 0) - 56320 | 0) + 65536 | 0;
            _decoded_next_string_index = _tmp$2;
            _decoded_char = _p;
            break _L;
          } else {
            const _tmp$2 = _string_index + 1 | 0;
            const _p = _bind$2;
            _decoded_next_string_index = _tmp$2;
            _decoded_char = _p;
            break _L;
          }
        } else {
          const _tmp$2 = _string_index + 1 | 0;
          const _p = _bind$2;
          _decoded_next_string_index = _tmp$2;
          _decoded_char = _p;
          break _L;
        }
      }
      _M0MPC15array5Array4pushGcE(chars, _decoded_char);
      _tmp = _decoded_next_string_index;
      continue;
    } else {
      break;
    }
  }
  return chars;
}
function _M0MPC16double6Double7to__int(self) {
  return self !== self ? 0 : self >= 2147483647 ? 2147483647 : self <= -2147483648 ? -2147483648 : self | 0;
}
function _M0MPC14char4Char20to__ascii__uppercase(self) {
  if (_M0MPC14char4Char20is__ascii__lowercase(self)) {
    return self - 32 | 0;
  }
  return self;
}
function _M0MPC15array5Array2atGsE(self, index) {
  const len = self.length;
  return index >= 0 && index < len ? self[index] : $panic();
}
function _M0MPC15array5Array2atGcE(self, index) {
  const len = self.length;
  return index >= 0 && index < len ? self[index] : $panic();
}
function _M0FPC28internal7strconv9base__errGUiRPC16string10StringViewbEE() {
  return new _M0DTPC16result6ResultGUiRPC16string10StringViewbERPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC28internal7strconv14base__err__str));
}
function _M0FPC28internal7strconv25check__and__consume__base(view, base) {
  if (base === 0) {
    _L: {
      let rest;
      _L$2: {
        let rest$2;
        _L$3: {
          let rest$3;
          _L$4: {
            if ((view.end - view.start | 0) >= 2) {
              const _x = view.str.charCodeAt(view.start);
              if (_x === 48) {
                const _x$2 = view.str.charCodeAt(view.start + 1 | 0);
                switch (_x$2) {
                  case 120: {
                    const _x$3 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    rest$3 = _x$3;
                    break _L$4;
                  }
                  case 88: {
                    const _x$4 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    rest$3 = _x$4;
                    break _L$4;
                  }
                  case 111: {
                    const _x$5 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    rest$2 = _x$5;
                    break _L$3;
                  }
                  case 79: {
                    const _x$6 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    rest$2 = _x$6;
                    break _L$3;
                  }
                  case 98: {
                    const _x$7 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    rest = _x$7;
                    break _L$2;
                  }
                  case 66: {
                    const _x$8 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    rest = _x$8;
                    break _L$2;
                  }
                  default: {
                    break _L;
                  }
                }
              } else {
                break _L;
              }
            } else {
              break _L;
            }
          }
          return new _M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE2Ok({ _0: 16, _1: rest$3, _2: true });
        }
        return new _M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE2Ok({ _0: 8, _1: rest$2, _2: true });
      }
      return new _M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE2Ok({ _0: 2, _1: rest, _2: true });
    }
    return new _M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE2Ok({ _0: 10, _1: view, _2: false });
  } else {
    _L: {
      let rest;
      _L$2: {
        let rest$2;
        _L$3: {
          let rest$3;
          _L$4: {
            if ((view.end - view.start | 0) >= 2) {
              const _x = view.str.charCodeAt(view.start);
              if (_x === 48) {
                const _x$2 = view.str.charCodeAt(view.start + 1 | 0);
                switch (_x$2) {
                  case 120: {
                    const _x$3 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    if (base === 16) {
                      rest$3 = _x$3;
                      break _L$4;
                    } else {
                      break _L;
                    }
                  }
                  case 88: {
                    const _x$4 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    if (base === 16) {
                      rest$3 = _x$4;
                      break _L$4;
                    } else {
                      break _L;
                    }
                  }
                  case 111: {
                    const _x$5 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    if (base === 8) {
                      rest$2 = _x$5;
                      break _L$3;
                    } else {
                      break _L;
                    }
                  }
                  case 79: {
                    const _x$6 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    if (base === 8) {
                      rest$2 = _x$6;
                      break _L$3;
                    } else {
                      break _L;
                    }
                  }
                  case 98: {
                    const _x$7 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    if (base === 2) {
                      rest = _x$7;
                      break _L$2;
                    } else {
                      break _L;
                    }
                  }
                  case 66: {
                    const _x$8 = new _M0TPC16string10StringView(view.str, view.start + 2 | 0, view.end);
                    if (base === 2) {
                      rest = _x$8;
                      break _L$2;
                    } else {
                      break _L;
                    }
                  }
                  default: {
                    break _L;
                  }
                }
              } else {
                break _L;
              }
            } else {
              break _L;
            }
          }
          return new _M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE2Ok({ _0: 16, _1: rest$3, _2: true });
        }
        return new _M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE2Ok({ _0: 8, _1: rest$2, _2: true });
      }
      return new _M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE2Ok({ _0: 2, _1: rest, _2: true });
    }
    return base >= 2 && base <= 36 ? new _M0DTPC16result6ResultGUiRPC16string10StringViewbERPC15error5ErrorE2Ok({ _0: base, _1: view, _2: false }) : _M0FPC28internal7strconv9base__errGUiRPC16string10StringViewbEE();
  }
}
function _M0FPC28internal7strconv10range__errGuE() {
  return new _M0DTPC16result6ResultGuRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC28internal7strconv15range__err__str));
}
function _M0FPC28internal7strconv11syntax__errGiE() {
  return new _M0DTPC16result6ResultGiRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC28internal7strconv16syntax__err__str));
}
function _M0FPC28internal7strconv11syntax__errGuE() {
  return new _M0DTPC16result6ResultGuRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC28internal7strconv16syntax__err__str));
}
function _M0FPC28internal7strconv11syntax__errGlE() {
  return new _M0DTPC16result6ResultGlRPB7FailureE3Err(new _M0DTPC15error5Error48moonbitlang_2fcore_2fbuiltin_2eFailure_2eFailure(_M0FPC28internal7strconv16syntax__err__str));
}
function _M0FPC28internal7strconv19overflow__threshold(base, neg) {
  if (!neg) {
    if (base === 10) {
      return 922337203685477581n;
    } else {
      if (base === 16) {
        return 576460752303423488n;
      } else {
        const _tmp = BigInt.asUintN(64, BigInt(base));
        if (_tmp === 0n) {
          $panic();
        }
        return BigInt.asUintN(64, BigInt.asUintN(64, BigInt.asIntN(64, 9223372036854775807n) / BigInt.asIntN(64, _tmp)) + 1n);
      }
    }
  } else {
    if (base === 10) {
      return 17524406870024074036n;
    } else {
      if (base === 16) {
        return 17870283321406128128n;
      } else {
        const _tmp = BigInt.asUintN(64, BigInt(base));
        if (_tmp === 0n) {
          $panic();
        }
        return BigInt.asUintN(64, BigInt.asIntN(64, 9223372036854775808n) / BigInt.asIntN(64, _tmp));
      }
    }
  }
}
function _M0FPC28internal7strconv20parse__int64_2einner(str, base) {
  if (_M0IP016_24default__implPB2Eq10not__equalGRPC16string10StringViewE(str, _M0FPC28internal7strconv20parse__int64_2einnerN6recordS443)) {
    let neg;
    let rest;
    _L: {
      let rest$2;
      _L$2: {
        if ((str.end - str.start | 0) >= 1) {
          const _x = str.str.charCodeAt(str.start);
          switch (_x) {
            case 43: {
              const _x$2 = new _M0TPC16string10StringView(str.str, str.start + 1 | 0, str.end);
              neg = false;
              rest = _x$2;
              break _L;
            }
            case 45: {
              const _x$3 = new _M0TPC16string10StringView(str.str, str.start + 1 | 0, str.end);
              neg = true;
              rest = _x$3;
              break _L;
            }
            default: {
              rest$2 = str;
              break _L$2;
            }
          }
        } else {
          rest$2 = str;
          break _L$2;
        }
      }
      neg = false;
      rest = rest$2;
      break _L;
    }
    const _bind = _M0FPC28internal7strconv25check__and__consume__base(rest, base);
    let _bind$2;
    if (_bind.$tag === 1) {
      const _ok = _bind;
      _bind$2 = _ok._0;
    } else {
      return _bind;
    }
    const _num_base = _bind$2._0;
    const _rest = _bind$2._1;
    const _allow_underscore = _bind$2._2;
    const overflow_threshold = _M0FPC28internal7strconv19overflow__threshold(_num_base, neg);
    let has_digit;
    if ((_rest.end - _rest.start | 0) >= 1) {
      const _x = _rest.str.charCodeAt(_rest.start);
      if (_x >= 48 && _x <= 57) {
        has_digit = true;
      } else {
        if (_x >= 97 && _x <= 122) {
          has_digit = true;
        } else {
          if (_x >= 65 && _x <= 90) {
            has_digit = true;
          } else {
            if ((_rest.end - _rest.start | 0) >= 2) {
              if (_x === 95) {
                const _x$2 = _rest.str.charCodeAt(_rest.start + 1 | 0);
                has_digit = _x$2 >= 48 && _x$2 <= 57 ? true : _x$2 >= 97 && _x$2 <= 122 ? true : _x$2 >= 65 && _x$2 <= 90;
              } else {
                has_digit = false;
              }
            } else {
              has_digit = false;
            }
          }
        }
      }
    } else {
      has_digit = false;
    }
    if (has_digit) {
      let _break_value;
      _L$2: {
        let _tmp = _rest;
        let _tmp$2 = 0n;
        let _tmp$3 = _allow_underscore;
        while (true) {
          const rest$2 = _tmp;
          const acc = _tmp$2;
          const allow_underscore = _tmp$3;
          let acc$2;
          let rest$3;
          let c;
          _L$3: {
            _L$4: {
              if ((rest$2.end - rest$2.start | 0) === 1) {
                const _x = rest$2.str.charCodeAt(rest$2.start);
                if (_x === 95) {
                  const _bind$3 = _M0FPC28internal7strconv11syntax__errGuE();
                  if (_bind$3.$tag === 1) {
                    const _ok = _bind$3;
                    _ok._0;
                  } else {
                    return _bind$3;
                  }
                } else {
                  const _c = _M0MPC16string6String16unsafe__char__at(rest$2.str, _M0MPC16string6String29offset__of__nth__char_2einner(rest$2.str, 0, rest$2.start, rest$2.end));
                  const _tmp$4 = rest$2.str;
                  const _bind$3 = _M0MPC16string6String29offset__of__nth__char_2einner(rest$2.str, 1, rest$2.start, rest$2.end);
                  let _tmp$5;
                  if (_bind$3 === undefined) {
                    _tmp$5 = rest$2.end;
                  } else {
                    const _Some = _bind$3;
                    _tmp$5 = _Some;
                  }
                  const _x$2 = new _M0TPC16string10StringView(_tmp$4, _tmp$5, rest$2.end);
                  acc$2 = acc;
                  rest$3 = _x$2;
                  c = _c;
                  break _L$4;
                }
              } else {
                if ((rest$2.end - rest$2.start | 0) >= 1) {
                  const _x = rest$2.str.charCodeAt(rest$2.start);
                  if (_x === 95) {
                    if (allow_underscore === false) {
                      const _bind$3 = _M0FPC28internal7strconv11syntax__errGuE();
                      if (_bind$3.$tag === 1) {
                        const _ok = _bind$3;
                        _ok._0;
                      } else {
                        return _bind$3;
                      }
                    } else {
                      const _x$2 = new _M0TPC16string10StringView(rest$2.str, rest$2.start + 1 | 0, rest$2.end);
                      _tmp = _x$2;
                      _tmp$3 = false;
                      continue;
                    }
                  } else {
                    const _c = _M0MPC16string6String16unsafe__char__at(rest$2.str, _M0MPC16string6String29offset__of__nth__char_2einner(rest$2.str, 0, rest$2.start, rest$2.end));
                    const _tmp$4 = rest$2.str;
                    const _bind$3 = _M0MPC16string6String29offset__of__nth__char_2einner(rest$2.str, 1, rest$2.start, rest$2.end);
                    let _tmp$5;
                    if (_bind$3 === undefined) {
                      _tmp$5 = rest$2.end;
                    } else {
                      const _Some = _bind$3;
                      _tmp$5 = _Some;
                    }
                    const _x$2 = new _M0TPC16string10StringView(_tmp$4, _tmp$5, rest$2.end);
                    acc$2 = acc;
                    rest$3 = _x$2;
                    c = _c;
                    break _L$4;
                  }
                } else {
                  _break_value = acc;
                  break _L$2;
                }
              }
              break _L$3;
            }
            const c$2 = c;
            let d;
            if (c$2 >= 48 && c$2 <= 57) {
              d = c$2 - 48 | 0;
            } else {
              if (c$2 >= 97 && c$2 <= 122) {
                d = c$2 + -87 | 0;
              } else {
                if (c$2 >= 65 && c$2 <= 90) {
                  d = c$2 + -55 | 0;
                } else {
                  const _bind$3 = _M0FPC28internal7strconv11syntax__errGiE();
                  if (_bind$3.$tag === 1) {
                    const _ok = _bind$3;
                    d = _ok._0;
                  } else {
                    return _bind$3;
                  }
                }
              }
            }
            if (d < _num_base) {
              if (neg) {
                if (BigInt.asIntN(64, acc$2) >= BigInt.asIntN(64, overflow_threshold)) {
                  const next_acc = BigInt.asUintN(64, BigInt.asUintN(64, acc$2 * BigInt.asUintN(64, BigInt(_num_base))) - BigInt.asUintN(64, BigInt(d)));
                  if (BigInt.asIntN(64, next_acc) <= BigInt.asIntN(64, acc$2)) {
                    _tmp = rest$3;
                    _tmp$2 = next_acc;
                    _tmp$3 = true;
                    continue;
                  } else {
                    const _bind$3 = _M0FPC28internal7strconv10range__errGuE();
                    if (_bind$3.$tag === 1) {
                      const _ok = _bind$3;
                      _ok._0;
                    } else {
                      return _bind$3;
                    }
                  }
                } else {
                  const _bind$3 = _M0FPC28internal7strconv10range__errGuE();
                  if (_bind$3.$tag === 1) {
                    const _ok = _bind$3;
                    _ok._0;
                  } else {
                    return _bind$3;
                  }
                }
              } else {
                if (BigInt.asIntN(64, acc$2) < BigInt.asIntN(64, overflow_threshold)) {
                  const next_acc = BigInt.asUintN(64, BigInt.asUintN(64, acc$2 * BigInt.asUintN(64, BigInt(_num_base))) + BigInt.asUintN(64, BigInt(d)));
                  if (BigInt.asIntN(64, next_acc) >= BigInt.asIntN(64, acc$2)) {
                    _tmp = rest$3;
                    _tmp$2 = next_acc;
                    _tmp$3 = true;
                    continue;
                  } else {
                    const _bind$3 = _M0FPC28internal7strconv10range__errGuE();
                    if (_bind$3.$tag === 1) {
                      const _ok = _bind$3;
                      _ok._0;
                    } else {
                      return _bind$3;
                    }
                  }
                } else {
                  const _bind$3 = _M0FPC28internal7strconv10range__errGuE();
                  if (_bind$3.$tag === 1) {
                    const _ok = _bind$3;
                    _ok._0;
                  } else {
                    return _bind$3;
                  }
                }
              }
            } else {
              const _bind$3 = _M0FPC28internal7strconv11syntax__errGuE();
              if (_bind$3.$tag === 1) {
                const _ok = _bind$3;
                _ok._0;
              } else {
                return _bind$3;
              }
            }
          }
          continue;
        }
      }
      return new _M0DTPC16result6ResultGlRPC15error5ErrorE2Ok(_break_value);
    } else {
      return _M0FPC28internal7strconv11syntax__errGlE();
    }
  } else {
    return _M0FPC28internal7strconv11syntax__errGlE();
  }
}
function _M0FPC28internal7strconv18parse__int_2einner(str, base) {
  const _bind = _M0FPC28internal7strconv20parse__int64_2einner(str, base);
  let n;
  if (_bind.$tag === 1) {
    const _ok = _bind;
    n = _ok._0;
  } else {
    return _bind;
  }
  if (BigInt.asIntN(64, n) < BigInt.asIntN(64, 18446744071562067968n) || BigInt.asIntN(64, n) > BigInt.asIntN(64, 2147483647n)) {
    const _bind$2 = _M0FPC28internal7strconv10range__errGuE();
    if (_bind$2.$tag === 1) {
      const _ok = _bind$2;
      _ok._0;
    } else {
      return _bind$2;
    }
  }
  return new _M0DTPC16result6ResultGiRPC15error5ErrorE2Ok(Number(BigInt.asIntN(32, n)) | 0);
}
function _M0FPC14math3sin(_tmp) {
  return Math.sin(_tmp);
}
function _M0FPC14math3cos(_tmp) {
  return Math.cos(_tmp);
}
function _M0FPC14math3tan(_tmp) {
  return Math.tan(_tmp);
}
function _M0FPC14math5atan2(_tmp, _tmp$2) {
  return Math.atan2(_tmp, _tmp$2);
}
function _M0FPC14math13math__pow__js(_tmp, _tmp$2) {
  return Math.pow(_tmp, _tmp$2);
}
function _M0FPC14math3pow(base, exponent) {
  if (base === 1) {
    return 1;
  }
  if (base === -1 && (exponent === _M0FPC16double8infinity || exponent === _M0FPC16double13neg__infinity)) {
    return 1;
  }
  return _M0FPC14math13math__pow__js(base, exponent);
}
function _M0FPC14math2ln(_tmp) {
  return Math.log(_tmp);
}
function _M0MP49poipoiiii8moonaprs3lib4ax2511Ax25Address3new(callsign, repeated) {
  return new _M0TP49poipoiiii8moonaprs3lib4ax2511Ax25Address(callsign, repeated);
}
function _M0MP49poipoiiii8moonaprs3lib4ax258Callsign10to__string(self) {
  return self.ssid === 0 ? self.call : `${self.call}-${_M0MPC13int3Int18to__string_2einner(self.ssid, 10)}`;
}
function _M0FP49poipoiiii8moonaprs3lib4ax2515normalize__call(raw) {
  const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  const _bind = _M0MPC16string6String4trim(raw, undefined);
  const _bind$2 = _bind.str;
  const _bind$3 = _bind.start;
  const _bind$4 = _bind.end;
  let _tmp = _bind$3;
  while (true) {
    const _string_index = _tmp;
    if (_string_index < _bind$4) {
      let _decoded_next_string_index;
      let _decoded_char;
      _L: {
        const _bind$5 = _bind$2.charCodeAt(_string_index);
        if (_bind$5 >= 55296 && _bind$5 <= 56319 && (_string_index + 1 | 0) < _bind$4) {
          const _bind$6 = _bind$2.charCodeAt(_string_index + 1 | 0);
          if (_bind$6 >= 56320 && _bind$6 <= 57343) {
            const _tmp$2 = _string_index + 2 | 0;
            const _p = (((Math.imul(_bind$5 - 55296 | 0, 1024) | 0) + _bind$6 | 0) - 56320 | 0) + 65536 | 0;
            _decoded_next_string_index = _tmp$2;
            _decoded_char = _p;
            break _L;
          } else {
            const _tmp$2 = _string_index + 1 | 0;
            const _p = _bind$5;
            _decoded_next_string_index = _tmp$2;
            _decoded_char = _p;
            break _L;
          }
        } else {
          const _tmp$2 = _string_index + 1 | 0;
          const _p = _bind$5;
          _decoded_next_string_index = _tmp$2;
          _decoded_char = _p;
          break _L;
        }
      }
      if (_decoded_char >= 97 && _decoded_char <= 122) {
        _M0IPB13StringBuilderPB6Logger11write__char(sb, _M0MPC14char4Char20to__ascii__uppercase(_decoded_char));
      } else {
        if (_decoded_char >= 65 && _decoded_char <= 90 || _decoded_char >= 48 && _decoded_char <= 57) {
          _M0IPB13StringBuilderPB6Logger11write__char(sb, _decoded_char);
        }
      }
      _tmp = _decoded_next_string_index;
      continue;
    } else {
      break;
    }
  }
  return sb.val;
}
function _M0MP49poipoiiii8moonaprs3lib4ax258Callsign5parse(raw) {
  const parts = _M0MPB4Iter9to__arrayGRPC16string10StringViewE(_M0MPC16string10StringView5split(_M0MPC16string6String4trim(raw, undefined), _M0MP49poipoiiii8moonaprs3lib4ax258Callsign5parseN6recordS506));
  const call = _M0FP49poipoiiii8moonaprs3lib4ax2515normalize__call(_M0MPC16string10StringView9to__owned(_M0MPC15array5Array2atGsE(parts, 0)));
  if (call.length === 0 || call.length > 6) {
    return undefined;
  }
  let ssid = 0;
  if (parts.length >= 2) {
    const digits = _M0MPC16string10StringView9to__owned(_M0MPC15array5Array2atGsE(parts, 1));
    if (digits.length === 0 || digits.length > 2) {
      return undefined;
    }
    let _tmp;
    let _try_err;
    _L: {
      _L$2: {
        const _bind = _M0FPC28internal7strconv18parse__int_2einner(new _M0TPC16string10StringView(digits, 0, digits.length), 0);
        if (_bind.$tag === 1) {
          const _ok = _bind;
          _tmp = _ok._0;
        } else {
          const _err = _bind;
          _try_err = _err._0;
          break _L$2;
        }
        break _L;
      }
      return undefined;
    }
    ssid = _tmp;
    if (ssid < 0 || ssid > 15) {
      return undefined;
    }
  }
  return new _M0TP49poipoiiii8moonaprs3lib4ax258Callsign(call, ssid);
}
function _M0FP49poipoiiii8moonaprs3lib4aprs12field__width(c) {
  switch (c) {
    case 99: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS514;
    }
    case 115: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS515;
    }
    case 103: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS516;
    }
    case 116: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS517;
    }
    case 114: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS518;
    }
    case 112: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS519;
    }
    case 80: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS520;
    }
    case 104: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS521;
    }
    case 98: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS522;
    }
    case 76: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS523;
    }
    case 108: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS524;
    }
    case 35: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS525;
    }
    case 86: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs12field__widthN6constrS526;
    }
    default: {
      return undefined;
    }
  }
}
function _M0FP49poipoiiii8moonaprs3lib4aprs13parse__digits(s) {
  if (s.length === 0) {
    return undefined;
  }
  let value = 0;
  const _bind = _M0MPC16string6String9to__array(s);
  const _bind$2 = _bind.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const c = _bind[_];
      if (!(c >= 48 && c <= 57)) {
        return undefined;
      }
      value = (Math.imul(value, 10) | 0) + (c - 48 | 0) | 0;
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return value;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs17parse__int__field(s) {
  if (s.length === 0) {
    return undefined;
  }
  const cs = _M0MPC16string6String9to__array(s);
  if (_M0MPC15array5Array2atGcE(cs, 0) === 45 || _M0MPC15array5Array2atGcE(cs, 0) === 43) {
    const rest = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    const _bind = cs.length;
    let _tmp = 1;
    while (true) {
      const i = _tmp;
      if (i < _bind) {
        _M0IPB13StringBuilderPB6Logger11write__char(rest, _M0MPC15array5Array2atGcE(cs, i));
        _tmp = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const _bind$2 = _M0FP49poipoiiii8moonaprs3lib4aprs13parse__digits(rest.val);
    if (_bind$2 === undefined) {
      return undefined;
    } else {
      const _Some = _bind$2;
      const _v = _Some;
      return _M0MPC15array5Array2atGcE(cs, 0) === 45 ? -_v | 0 : _v;
    }
  } else {
    return _M0FP49poipoiiii8moonaprs3lib4aprs13parse__digits(s);
  }
}
function _M0FP49poipoiiii8moonaprs3lib4aprs14parse__weather(body) {
  const text = _M0MPC16string10StringView9to__owned(_M0MPC16string6String4trim(body, undefined));
  const cs0 = _M0MPC16string6String9to__array(text);
  let start = 0;
  if (cs0.length > 0 && _M0MPC15array5Array2atGcE(cs0, 0) === 95) {
    start = 1;
  }
  const cs = _M0MPC16string6String9to__array(text);
  let pos = start;
  let timestamp = undefined;
  if ((pos + 8 | 0) <= cs.length) {
    const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    let all_digits = true;
    let _tmp = 0;
    while (true) {
      const i = _tmp;
      if (i < 8) {
        const c = _M0MPC15array5Array2atGcE(cs, pos + i | 0);
        if (c >= 48 && c <= 57) {
          _M0IPB13StringBuilderPB6Logger11write__char(sb, c);
        } else {
          all_digits = false;
        }
        _tmp = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    if (all_digits) {
      timestamp = sb.val;
      pos = pos + 8 | 0;
    }
  }
  let wind_dir = undefined;
  let wind_speed = undefined;
  let gust = undefined;
  let temperature = undefined;
  let rain_1h = undefined;
  let rain_24h = undefined;
  let rain_mid = undefined;
  let humidity = undefined;
  let pressure = undefined;
  let luminosity = undefined;
  while (true) {
    if (pos < cs.length) {
      const key = _M0MPC15array5Array2atGcE(cs, pos);
      const _bind = _M0FP49poipoiiii8moonaprs3lib4aprs12field__width(key);
      let width;
      if (_bind === undefined) {
        break;
      } else {
        const _Some = _bind;
        width = _Some;
      }
      if (((pos + 1 | 0) + width | 0) > cs.length) {
        break;
      }
      const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
      let _tmp = 0;
      while (true) {
        const i = _tmp;
        if (i < width) {
          _M0IPB13StringBuilderPB6Logger11write__char(sb, _M0MPC15array5Array2atGcE(cs, (pos + 1 | 0) + i | 0));
          _tmp = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      const raw = sb.val;
      const value = _M0FP49poipoiiii8moonaprs3lib4aprs17parse__int__field(raw);
      pos = (pos + 1 | 0) + width | 0;
      if (value === undefined) {
        break;
      } else {
        const _Some = value;
        const _v = _Some;
        switch (key) {
          case 99: {
            wind_dir = _v;
            break;
          }
          case 115: {
            wind_speed = _v;
            break;
          }
          case 103: {
            gust = _v;
            break;
          }
          case 116: {
            temperature = _v;
            break;
          }
          case 114: {
            rain_1h = _v;
            break;
          }
          case 112: {
            rain_24h = _v;
            break;
          }
          case 80: {
            rain_mid = _v;
            break;
          }
          case 104: {
            humidity = _v;
            break;
          }
          case 98: {
            pressure = _v;
            break;
          }
          case 76: {
            luminosity = _v;
            break;
          }
          case 108: {
            const _bind$2 = luminosity;
            if (_bind$2 === undefined) {
              luminosity = _v;
            }
            break;
          }
        }
      }
      continue;
    } else {
      break;
    }
  }
  return new _M0TP49poipoiiii8moonaprs3lib4aprs7Weather(timestamp, wind_dir, wind_speed, gust, temperature, rain_1h, rain_24h, rain_mid, humidity, pressure, luminosity);
}
function _M0FP49poipoiiii8moonaprs3lib4aprs22weather__from__comment(comment) {
  const cs = _M0MPC16string6String9to__array(comment);
  const _bind = cs.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind) {
      if (_M0MPC15array5Array2atGcE(cs, i) === 95) {
        const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
        const _bind$2 = cs.length;
        let _tmp$2 = i;
        while (true) {
          const j = _tmp$2;
          if (j < _bind$2) {
            _M0IPB13StringBuilderPB6Logger11write__char(sb, _M0MPC15array5Array2atGcE(cs, j));
            _tmp$2 = j + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        return _M0FP49poipoiiii8moonaprs3lib4aprs14parse__weather(sb.val);
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return undefined;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs10digits__at(cs, start, count) {
  if ((start + count | 0) > cs.length) {
    return false;
  }
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < count) {
      const c = _M0MPC15array5Array2atGcE(cs, start + i | 0);
      if (c < 48 || c > 57) {
        return false;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return true;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs12chars__slice(s, start, end) {
  const cs = _M0MPC16string6String9to__array(s);
  const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  let i = start;
  while (true) {
    if (i < end && i < cs.length) {
      _M0IPB13StringBuilderPB6Logger11write__char(sb, _M0MPC15array5Array2atGcE(cs, i));
      i = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return sb.val;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(s, start) {
  return _M0FP49poipoiiii8moonaprs3lib4aprs12chars__slice(s, start, _M0MPC16string6String9to__array(s).length);
}
function _M0FP49poipoiiii8moonaprs3lib4aprs28parse__weather__with__prefix(text) {
  const cs = _M0MPC16string6String9to__array(text);
  let start = 0;
  if (_M0FP49poipoiiii8moonaprs3lib4aprs10digits__at(cs, 0, 8)) {
    start = 8;
  }
  if (_M0FP49poipoiiii8moonaprs3lib4aprs10digits__at(cs, start, 3) && ((start + 6 | 0) < cs.length && (_M0MPC15array5Array2atGcE(cs, start + 3 | 0) === 47 && _M0FP49poipoiiii8moonaprs3lib4aprs10digits__at(cs, start + 4 | 0, 3)))) {
    const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    _M0IPB13StringBuilderPB6Logger13write__string(sb, "c");
    _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs12chars__slice(text, start, start + 3 | 0));
    _M0IPB13StringBuilderPB6Logger13write__string(sb, "s");
    _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs12chars__slice(text, start + 4 | 0, start + 7 | 0));
    _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(text, start + 7 | 0));
    return _M0FP49poipoiiii8moonaprs3lib4aprs14parse__weather(sb.val);
  } else {
    return _M0FP49poipoiiii8moonaprs3lib4aprs14parse__weather(text);
  }
}
function _M0FP49poipoiiii8moonaprs3lib4aprs23weather__from__position(position) {
  return position.symbol_code === 95 ? (position.comment.length === 0 ? undefined : _M0FP49poipoiiii8moonaprs3lib4aprs28parse__weather__with__prefix(position.comment)) : _M0FP49poipoiiii8moonaprs3lib4aprs22weather__from__comment(position.comment);
}
function _M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(value, decimals) {
  const negative = value < 0;
  let scaled = value;
  if (negative) {
    scaled = -scaled;
  }
  const factor = _M0FPC14math3pow(10, decimals + 0);
  const rounded = _M0MPC16double6Double7to__int(scaled * factor + 0.5);
  const whole = rounded / _M0MPC16double6Double7to__int(factor) | 0;
  const frac = rounded % _M0MPC16double6Double7to__int(factor) | 0;
  const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  if (negative) {
    _M0IPB13StringBuilderPB6Logger13write__string(sb, "-");
  }
  _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0MPC13int3Int18to__string_2einner(whole, 10));
  if (decimals > 0) {
    _M0IPB13StringBuilderPB6Logger13write__string(sb, ".");
    const digits = _M0MPC13int3Int18to__string_2einner(frac, 10);
    const _bind = decimals - digits.length | 0;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "0");
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    _M0IPB13StringBuilderPB6Logger13write__string(sb, digits);
  }
  return sb.val;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs13join__strings(parts, sep) {
  const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  const _bind = parts.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind) {
      if (i > 0) {
        _M0IPB13StringBuilderPB6Logger13write__string(sb, sep);
      }
      _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0MPC15array5Array2atGsE(parts, i));
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return sb.val;
}
function _M0MP49poipoiiii8moonaprs3lib4aprs7Weather7summary(self) {
  const parts = [];
  const _bind = self.wind_dir;
  if (_bind === undefined) {
  } else {
    const _Some = _bind;
    const _v = _Some;
    _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(parts, `wind ${_M0MPC13int3Int18to__string_2einner(_v, 10)}°`);
  }
  const _bind$2 = self.wind_speed;
  if (_bind$2 === undefined) {
  } else {
    const _Some = _bind$2;
    const _v = _Some;
    _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(parts, `speed ${_M0MPC13int3Int18to__string_2einner(_v, 10)} mph`);
  }
  const _bind$3 = self.gust;
  if (_bind$3 === undefined) {
  } else {
    const _Some = _bind$3;
    const _v = _Some;
    _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(parts, `gust ${_M0MPC13int3Int18to__string_2einner(_v, 10)} mph`);
  }
  const _bind$4 = self.temperature_f;
  if (_bind$4 === undefined) {
  } else {
    const _Some = _bind$4;
    const _v = _Some;
    _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(parts, `temp ${_M0MPC13int3Int18to__string_2einner(_v, 10)}F`);
  }
  const _bind$5 = self.humidity;
  if (_bind$5 === undefined) {
  } else {
    const _Some = _bind$5;
    const _v = _Some;
    _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(parts, `humidity ${_M0MPC13int3Int18to__string_2einner(_v, 10)}%`);
  }
  const _bind$6 = self.pressure_tenths_hpa;
  if (_bind$6 === undefined) {
  } else {
    const _Some = _bind$6;
    const _v = _Some;
    _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(parts, `pressure ${_M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed((_v + 0) / 10, 1)} hPa`);
  }
  const _bind$7 = self.rain_last_hour;
  if (_bind$7 === undefined) {
  } else {
    const _Some = _bind$7;
    const _v = _Some;
    _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(parts, `rain 1h ${_M0MPC13int3Int18to__string_2einner(_v, 10)}`);
  }
  return _M0FP49poipoiiii8moonaprs3lib4aprs13join__strings(parts, ", ");
}
function _M0FP49poipoiiii8moonaprs3lib4aprs11split__once(s, sep) {
  const cs = _M0MPC16string6String9to__array(s);
  const _bind = cs.length;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < _bind) {
      if (_M0MPC15array5Array2atGcE(cs, i) === sep) {
        const left = _M0MPB13StringBuilder21StringBuilder_2einner(0);
        const right = _M0MPB13StringBuilder21StringBuilder_2einner(0);
        let _tmp$2 = 0;
        while (true) {
          const j = _tmp$2;
          if (j < i) {
            _M0IPB13StringBuilderPB6Logger11write__char(left, _M0MPC15array5Array2atGcE(cs, j));
            _tmp$2 = j + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        const _bind$2 = i + 1 | 0;
        const _bind$3 = cs.length;
        let _tmp$3 = _bind$2;
        while (true) {
          const j = _tmp$3;
          if (j < _bind$3) {
            _M0IPB13StringBuilderPB6Logger11write__char(right, _M0MPC15array5Array2atGcE(cs, j));
            _tmp$3 = j + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        return { _0: left.val, _1: right.val };
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return undefined;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs11split__char(s, sep) {
  const out = [];
  const cs = _M0MPC16string6String9to__array(s);
  const cur = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  const _bind = cs.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const c = cs[_];
      if (c === sep) {
        _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(out, cur.val);
        _M0MPB13StringBuilder5reset(cur);
      } else {
        _M0IPB13StringBuilderPB6Logger11write__char(cur, c);
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(out, cur.val);
  return out;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs10drop__last(s) {
  const cs = _M0MPC16string6String9to__array(s);
  const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  if (cs.length > 0) {
    const _bind = cs.length - 1 | 0;
    let _tmp = 0;
    while (true) {
      const i = _tmp;
      if (i < _bind) {
        _M0IPB13StringBuilderPB6Logger11write__char(sb, _M0MPC15array5Array2atGcE(cs, i));
        _tmp = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
  }
  return sb.val;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs11all__digits(s) {
  if (s.length === 0) {
    return false;
  }
  const _bind = _M0MPC16string6String9to__array(s);
  const _bind$2 = _bind.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const c = _bind[_];
      if (!(c >= 48 && c <= 57)) {
        return false;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return true;
}
function _M0MP49poipoiiii8moonaprs3lib4aprs10Tnc2Packet5parse(line) {
  const trimmed = _M0MPC16string10StringView9to__owned(_M0MPC16string6String4trim(line, undefined));
  const _bind = _M0FP49poipoiiii8moonaprs3lib4aprs11split__once(trimmed, 58);
  if (_bind === undefined) {
    return _M0MP49poipoiiii8moonaprs3lib4aprs10Tnc2Packet5parseN6constrS688;
  } else {
    const _Some = _bind;
    const _x = _Some;
    const _header = _x._0;
    const _info = _x._1;
    const _bind$2 = _M0FP49poipoiiii8moonaprs3lib4aprs11split__once(_header, 62);
    if (_bind$2 === undefined) {
      return _M0MP49poipoiiii8moonaprs3lib4aprs10Tnc2Packet5parseN6constrS689;
    } else {
      const _Some$2 = _bind$2;
      const _x$2 = _Some$2;
      const _src_text = _x$2._0;
      const _rest = _x$2._1;
      const _bind$3 = _M0MP49poipoiiii8moonaprs3lib4ax258Callsign5parse(_src_text);
      let src;
      if (_bind$3 === undefined) {
        return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10Tnc2PacketsE3Err(`invalid source callsign: ${_src_text}`);
      } else {
        const _Some$3 = _bind$3;
        src = _Some$3;
      }
      const fields = _M0FP49poipoiiii8moonaprs3lib4aprs11split__char(_rest, 44);
      if (fields.length === 0) {
        return _M0MP49poipoiiii8moonaprs3lib4aprs10Tnc2Packet5parseN6constrS690;
      }
      const _bind$4 = _M0MP49poipoiiii8moonaprs3lib4ax258Callsign5parse(_M0MPC15array5Array2atGsE(fields, 0));
      let dest;
      if (_bind$4 === undefined) {
        return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10Tnc2PacketsE3Err(`invalid destination callsign: ${_M0MPC15array5Array2atGsE(fields, 0)}`);
      } else {
        const _Some$3 = _bind$4;
        dest = _Some$3;
      }
      const path = [];
      const _bind$5 = fields.length;
      let _tmp = 1;
      while (true) {
        const i = _tmp;
        if (i < _bind$5) {
          _L: {
            if (_M0MPC15array5Array2atGsE(fields, i).length === 0) {
              break _L;
            }
            const entry = _M0MPC15array5Array2atGsE(fields, i);
            const repeated = entry.length > 0 && _M0MPC15array5Array2atGcE(_M0MPC16string6String9to__array(entry), entry.length - 1 | 0) === 42;
            const call_text = repeated ? _M0FP49poipoiiii8moonaprs3lib4aprs10drop__last(entry) : entry;
            const _bind$6 = _M0MP49poipoiiii8moonaprs3lib4ax258Callsign5parse(call_text);
            if (_bind$6 === undefined) {
              return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10Tnc2PacketsE3Err(`invalid path element: ${entry}`);
            } else {
              const _Some$3 = _bind$6;
              const _c = _Some$3;
              _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(path, _M0MP49poipoiiii8moonaprs3lib4ax2511Ax25Address3new(_c, repeated));
            }
            break _L;
          }
          _tmp = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10Tnc2PacketsE2Ok(new _M0TP49poipoiiii8moonaprs3lib4aprs10Tnc2Packet(src, dest, path, _info));
    }
  }
}
function _M0FP49poipoiiii8moonaprs3lib4aprs16parse__telemetry(body) {
  const fields = _M0FP49poipoiiii8moonaprs3lib4aprs11split__char(body, 44);
  if (fields.length < 2) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs16parse__telemetryN6constrS723;
  }
  const name = _M0MPC15array5Array2atGsE(fields, 0);
  if (name.length === 0) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs16parse__telemetryN6constrS724;
  }
  const _bind = _M0FP49poipoiiii8moonaprs3lib4aprs13parse__digits(_M0MPC15array5Array2atGsE(fields, 1));
  let seq;
  if (_bind === undefined) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs16parse__telemetryN6constrS725;
  } else {
    const _Some = _bind;
    seq = _Some;
  }
  const analog = [];
  let digital = "";
  const _bind$2 = fields.length;
  let _tmp = 2;
  while (true) {
    const i = _tmp;
    if (i < _bind$2) {
      const field = _M0MPC15array5Array2atGsE(fields, i);
      if (field.length === 8 && (_M0FP49poipoiiii8moonaprs3lib4aprs11all__digits(field) && i === (fields.length - 1 | 0))) {
        digital = field;
      } else {
        const _bind$3 = _M0FP49poipoiiii8moonaprs3lib4aprs17parse__int__field(field);
        if (_bind$3 === undefined) {
          return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs9TelemetrysE3Err(`telemetry value is not a number: ${field}`);
        } else {
          const _Some = _bind$3;
          const _v = _Some;
          _M0MPC15array5Array4pushGiE(analog, _v);
        }
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs9TelemetrysE2Ok(new _M0TP49poipoiiii8moonaprs3lib4aprs9Telemetry(name, seq, analog, digital));
}
function _M0FP49poipoiiii8moonaprs3lib4aprs12digit__value(c) {
  return c >= 48 && c <= 57 ? c - 48 | 0 : undefined;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs13base91__value(cs, start, count) {
  let value = 0;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < count) {
      const c = _M0MPC15array5Array2atGcE(cs, start + i | 0);
      const v = c - 33 | 0;
      if (v < 0 || v > 90) {
        return undefined;
      }
      value = (Math.imul(value, 91) | 0) + v | 0;
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return value;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lat(cs, start) {
  if ((start + 8 | 0) > cs.length) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs10parse__latN6constrS754;
  }
  let value = 0;
  let ambiguity = 0;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < 7) {
      _L: {
        if (i === 4) {
          if (_M0MPC15array5Array2atGcE(cs, start + i | 0) !== 46) {
            return _M0FP49poipoiiii8moonaprs3lib4aprs10parse__latN6constrS755;
          }
          break _L;
        }
        const c = _M0MPC15array5Array2atGcE(cs, start + i | 0);
        if (c === 32) {
          ambiguity = ambiguity + 1 | 0;
        } else {
          const _bind = _M0FP49poipoiiii8moonaprs3lib4aprs12digit__value(c);
          if (_bind === undefined) {
            return _M0FP49poipoiiii8moonaprs3lib4aprs10parse__latN6constrS756;
          } else {
            const _Some = _bind;
            const _d = _Some;
            let weight;
            switch (i) {
              case 0: {
                weight = 10;
                break;
              }
              case 1: {
                weight = 1;
                break;
              }
              case 2: {
                weight = 0.16666666666666666;
                break;
              }
              case 3: {
                weight = 0.016666666666666666;
                break;
              }
              case 5: {
                weight = 0.0016666666666666668;
                break;
              }
              default: {
                weight = 0.00016666666666666666;
              }
            }
            value = value + (_d + 0) * weight;
          }
        }
        break _L;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const hemi = _M0MPC15array5Array2atGcE(cs, start + 7 | 0);
  let signed;
  if (hemi === 78 || hemi === 110) {
    signed = value;
  } else {
    if (hemi === 83 || hemi === 115) {
      signed = -value;
    } else {
      return _M0FP49poipoiiii8moonaprs3lib4aprs10parse__latN6constrS757;
    }
  }
  return new _M0DTPC16result6ResultGUdiEsE2Ok({ _0: signed, _1: ambiguity });
}
function _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lon(cs, start) {
  if ((start + 9 | 0) > cs.length) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lonN6constrS772;
  }
  let value = 0;
  let ambiguity = 0;
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < 8) {
      _L: {
        if (i === 5) {
          if (_M0MPC15array5Array2atGcE(cs, start + i | 0) !== 46) {
            return _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lonN6constrS773;
          }
          break _L;
        }
        const c = _M0MPC15array5Array2atGcE(cs, start + i | 0);
        if (c === 32) {
          ambiguity = ambiguity + 1 | 0;
        } else {
          const _bind = _M0FP49poipoiiii8moonaprs3lib4aprs12digit__value(c);
          if (_bind === undefined) {
            return _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lonN6constrS774;
          } else {
            const _Some = _bind;
            const _d = _Some;
            let weight;
            switch (i) {
              case 0: {
                weight = 100;
                break;
              }
              case 1: {
                weight = 10;
                break;
              }
              case 2: {
                weight = 1;
                break;
              }
              case 3: {
                weight = 0.16666666666666666;
                break;
              }
              case 4: {
                weight = 0.016666666666666666;
                break;
              }
              case 6: {
                weight = 0.0016666666666666668;
                break;
              }
              default: {
                weight = 0.00016666666666666666;
              }
            }
            value = value + (_d + 0) * weight;
          }
        }
        break _L;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const hemi = _M0MPC15array5Array2atGcE(cs, start + 8 | 0);
  let signed;
  if (hemi === 69 || hemi === 101) {
    signed = value;
  } else {
    if (hemi === 87 || hemi === 119) {
      signed = -value;
    } else {
      return _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lonN6constrS775;
    }
  }
  return new _M0DTPC16result6ResultGUdiEsE2Ok({ _0: signed, _1: ambiguity });
}
function _M0FP49poipoiiii8moonaprs3lib4aprs11chars__from(cs, start) {
  const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  const _bind = cs.length;
  let _tmp = start;
  while (true) {
    const i = _tmp;
    if (i < _bind) {
      _M0IPB13StringBuilderPB6Logger11write__char(sb, _M0MPC15array5Array2atGcE(cs, i));
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return sb.val;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs22looks__like__timestamp(cs) {
  if (cs.length < 8) {
    return false;
  }
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < 6) {
      const _bind = _M0FP49poipoiiii8moonaprs3lib4aprs12digit__value(_M0MPC15array5Array2atGcE(cs, i));
      if (_bind === undefined) {
        return false;
      }
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return _M0MPC15array5Array2atGcE(cs, 6) === 122 || _M0MPC15array5Array2atGcE(cs, 6) === 47;
}
function _M0FP49poipoiiii8moonaprs3lib4aprs19parse__uncompressed(cs, start, timestamp) {
  const _bind = _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lat(cs, start);
  if (_bind.$tag === 0) {
    const _Err = _bind;
    const _e = _Err._0;
    return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE3Err(_e);
  } else {
    const _Ok = _bind;
    const _x = _Ok._0;
    const _lat = _x._0;
    const _lat_amb = _x._1;
    const table_pos = start + 8 | 0;
    const _bind$2 = _M0FP49poipoiiii8moonaprs3lib4aprs10parse__lon(cs, table_pos + 1 | 0);
    if (_bind$2.$tag === 0) {
      const _Err = _bind$2;
      const _e = _Err._0;
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE3Err(_e);
    } else {
      const _Ok$2 = _bind$2;
      const _x$2 = _Ok$2._0;
      const _lon = _x$2._0;
      const _lon_amb = _x$2._1;
      const symbol_pos = table_pos + 10 | 0;
      if (symbol_pos >= cs.length) {
        return _M0FP49poipoiiii8moonaprs3lib4aprs19parse__uncompressedN6constrS800;
      }
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE2Ok(new _M0TP49poipoiiii8moonaprs3lib4aprs8Position(_lat, _lon, _M0MPC15array5Array2atGcE(cs, table_pos), _M0MPC15array5Array2atGcE(cs, symbol_pos), _M0FP49poipoiiii8moonaprs3lib4aprs11chars__from(cs, symbol_pos + 1 | 0), _lat_amb > _lon_amb ? _lat_amb : _lon_amb, timestamp, false));
    }
  }
}
function _M0FP49poipoiiii8moonaprs3lib4aprs17parse__compressed(cs, start, timestamp) {
  if ((start + 13 | 0) > cs.length) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs17parse__compressedN6constrS820;
  }
  const _bind = _M0FP49poipoiiii8moonaprs3lib4aprs13base91__value(cs, start + 1 | 0, 4);
  let lat_v;
  if (_bind === undefined) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs17parse__compressedN6constrS821;
  } else {
    const _Some = _bind;
    lat_v = _Some;
  }
  const _bind$2 = _M0FP49poipoiiii8moonaprs3lib4aprs13base91__value(cs, start + 5 | 0, 4);
  let lon_v;
  if (_bind$2 === undefined) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs17parse__compressedN6constrS822;
  } else {
    const _Some = _bind$2;
    lon_v = _Some;
  }
  const lat = 90 - (lat_v + 0) / 380926;
  const lon = -180 + (lon_v + 0) / 190463;
  return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8PositionsE2Ok(new _M0TP49poipoiiii8moonaprs3lib4aprs8Position(lat, lon, _M0MPC15array5Array2atGcE(cs, start), _M0MPC15array5Array2atGcE(cs, start + 9 | 0), _M0FP49poipoiiii8moonaprs3lib4aprs11chars__from(cs, start + 13 | 0), 0, timestamp, true));
}
function _M0FP49poipoiiii8moonaprs3lib4aprs15parse__position(body, allow_timestamp) {
  const cs = _M0MPC16string6String9to__array(body);
  if (cs.length === 0) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs15parse__positionN6constrS834;
  }
  let start = 0;
  let timestamp = undefined;
  if (allow_timestamp && _M0FP49poipoiiii8moonaprs3lib4aprs22looks__like__timestamp(cs)) {
    const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    let _tmp = 0;
    while (true) {
      const i = _tmp;
      if (i < 7) {
        _M0IPB13StringBuilderPB6Logger11write__char(sb, _M0MPC15array5Array2atGcE(cs, i));
        _tmp = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    timestamp = sb.val;
    start = 7;
  }
  if (start >= cs.length) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs15parse__positionN6constrS835;
  }
  const first = _M0MPC15array5Array2atGcE(cs, start);
  if (first === 47 || (first === 92 || (first >= 65 && first <= 90 || first >= 97 && first <= 122))) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs17parse__compressed(cs, start, timestamp);
  } else {
    const _bind = _M0FP49poipoiiii8moonaprs3lib4aprs12digit__value(first);
    return _bind === undefined ? _M0FP49poipoiiii8moonaprs3lib4aprs15parse__positionN6constrS836 : _M0FP49poipoiiii8moonaprs3lib4aprs19parse__uncompressed(cs, start, timestamp);
  }
}
function _M0FP49poipoiiii8moonaprs3lib4aprs11parse__item(body) {
  const cs = _M0MPC16string6String9to__array(body);
  let sep = -1;
  let i = 0;
  while (true) {
    if (i < cs.length && i < 9) {
      if (_M0MPC15array5Array2atGcE(cs, i) === 33 || _M0MPC15array5Array2atGcE(cs, i) === 95) {
        sep = i;
        break;
      }
      i = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  if (sep < 0) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs11parse__itemN6constrS849;
  }
  if (sep === 0) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs11parse__itemN6constrS850;
  }
  const name_sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  const _bind = sep;
  let _tmp = 0;
  while (true) {
    const j = _tmp;
    if (j < _bind) {
      _M0IPB13StringBuilderPB6Logger11write__char(name_sb, _M0MPC15array5Array2atGcE(cs, j));
      _tmp = j + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const rest_sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  const _bind$2 = sep + 1 | 0;
  const _bind$3 = cs.length;
  let _tmp$2 = _bind$2;
  while (true) {
    const j = _tmp$2;
    if (j < _bind$3) {
      _M0IPB13StringBuilderPB6Logger11write__char(rest_sb, _M0MPC15array5Array2atGcE(cs, j));
      _tmp$2 = j + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$4 = _M0FP49poipoiiii8moonaprs3lib4aprs15parse__position(rest_sb.val, false);
  if (_bind$4.$tag === 1) {
    const _Ok = _bind$4;
    const _position = _Ok._0;
    return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10ItemReportsE2Ok(new _M0TP49poipoiiii8moonaprs3lib4aprs10ItemReport(name_sb.val, _M0MPC15array5Array2atGcE(cs, sep) === 33, _position));
  } else {
    const _Err = _bind$4;
    const _e = _Err._0;
    return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10ItemReportsE3Err(_e);
  }
}
function _M0FP49poipoiiii8moonaprs3lib4aprs14parse__message(body) {
  const cs = _M0MPC16string6String9to__array(body);
  if (cs.length < 10) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs14parse__messageN6constrS870;
  }
  const addressee_sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < 9) {
      _M0IPB13StringBuilderPB6Logger11write__char(addressee_sb, _M0MPC15array5Array2atGcE(cs, i));
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const addressee = _M0MPC16string10StringView9to__owned(_M0MPC16string6String4trim(addressee_sb.val, undefined));
  if (addressee.length === 0) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs14parse__messageN6constrS871;
  }
  if (cs.length < 11) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs14parse__messageN6constrS872;
  }
  const text_sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  const _bind = cs.length;
  let _tmp$2 = 10;
  while (true) {
    const i = _tmp$2;
    if (i < _bind) {
      _M0IPB13StringBuilderPB6Logger11write__char(text_sb, _M0MPC15array5Array2atGcE(cs, i));
      _tmp$2 = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const raw_text = text_sb.val;
  let text = raw_text;
  let msg_id = undefined;
  const text_cs = _M0MPC16string6String9to__array(raw_text);
  const _bind$2 = text_cs.length;
  let _tmp$3 = 0;
  while (true) {
    const i = _tmp$3;
    if (i < _bind$2) {
      if (_M0MPC15array5Array2atGcE(text_cs, i) === 123) {
        const id_sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
        const _bind$3 = i + 1 | 0;
        const _bind$4 = text_cs.length;
        let _tmp$4 = _bind$3;
        while (true) {
          const j = _tmp$4;
          if (j < _bind$4) {
            _M0IPB13StringBuilderPB6Logger11write__char(id_sb, _M0MPC15array5Array2atGcE(text_cs, j));
            _tmp$4 = j + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        msg_id = id_sb.val;
        const head = _M0MPB13StringBuilder21StringBuilder_2einner(0);
        let _tmp$5 = 0;
        while (true) {
          const j = _tmp$5;
          if (j < i) {
            _M0IPB13StringBuilderPB6Logger11write__char(head, _M0MPC15array5Array2atGcE(text_cs, j));
            _tmp$5 = j + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        text = head.val;
        break;
      }
      _tmp$3 = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  let ack_id = undefined;
  if (text.length >= 3 && (_M0MPC15array5Array2atGcE(_M0MPC16string6String9to__array(text), 0) === 97 && (_M0MPC15array5Array2atGcE(_M0MPC16string6String9to__array(text), 1) === 99 && _M0MPC15array5Array2atGcE(_M0MPC16string6String9to__array(text), 2) === 107))) {
    const id_sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    const tc = _M0MPC16string6String9to__array(text);
    const _bind$3 = tc.length;
    let _tmp$4 = 3;
    while (true) {
      const i = _tmp$4;
      if (i < _bind$3) {
        _M0IPB13StringBuilderPB6Logger11write__char(id_sb, _M0MPC15array5Array2atGcE(tc, i));
        _tmp$4 = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const id = id_sb.val;
    if (_M0FP49poipoiiii8moonaprs3lib4aprs11all__digits(id)) {
      ack_id = id;
    }
  }
  return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs7MessagesE2Ok(new _M0TP49poipoiiii8moonaprs3lib4aprs7Message(addressee, text, msg_id, ack_id));
}
function _M0FP49poipoiiii8moonaprs3lib4aprs13parse__object(body) {
  const cs = _M0MPC16string6String9to__array(body);
  if (cs.length < 18) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs13parse__objectN6constrS905;
  }
  const name_sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  let _tmp = 0;
  while (true) {
    const i = _tmp;
    if (i < 9) {
      _M0IPB13StringBuilderPB6Logger11write__char(name_sb, _M0MPC15array5Array2atGcE(cs, i));
      _tmp = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const name = _M0MPC16string10StringView9to__owned(_M0MPC16string6String4trim(name_sb.val, undefined));
  if (name.length === 0) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs13parse__objectN6constrS906;
  }
  let alive;
  if (_M0MPC15array5Array2atGcE(cs, 9) === 42) {
    alive = true;
  } else {
    if (_M0MPC15array5Array2atGcE(cs, 9) === 95) {
      alive = false;
    } else {
      return _M0FP49poipoiiii8moonaprs3lib4aprs13parse__objectN6constrS907;
    }
  }
  const ts_sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  let _tmp$2 = 10;
  while (true) {
    const i = _tmp$2;
    if (i < 17) {
      _M0IPB13StringBuilderPB6Logger11write__char(ts_sb, _M0MPC15array5Array2atGcE(cs, i));
      _tmp$2 = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const rest_sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  const _bind = cs.length;
  let _tmp$3 = 17;
  while (true) {
    const i = _tmp$3;
    if (i < _bind) {
      _M0IPB13StringBuilderPB6Logger11write__char(rest_sb, _M0MPC15array5Array2atGcE(cs, i));
      _tmp$3 = i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  const _bind$2 = _M0FP49poipoiiii8moonaprs3lib4aprs15parse__position(rest_sb.val, false);
  if (_bind$2.$tag === 1) {
    const _Ok = _bind$2;
    const _position = _Ok._0;
    return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs12ObjectReportsE2Ok(new _M0TP49poipoiiii8moonaprs3lib4aprs12ObjectReport(name, alive, ts_sb.val, _position));
  } else {
    const _Err = _bind$2;
    const _e = _Err._0;
    return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs12ObjectReportsE3Err(_e);
  }
}
function _M0FP49poipoiiii8moonaprs3lib4aprs13parse__status(body) {
  const cs = _M0MPC16string6String9to__array(body);
  if (cs.length >= 8) {
    let looks_timestamp = true;
    let _tmp = 0;
    while (true) {
      const i = _tmp;
      if (i < 6) {
        if (_M0MPC15array5Array2atGcE(cs, i) < 48 || _M0MPC15array5Array2atGcE(cs, i) > 57) {
          looks_timestamp = false;
        }
        _tmp = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    if (looks_timestamp && (_M0MPC15array5Array2atGcE(cs, 6) === 122 || _M0MPC15array5Array2atGcE(cs, 6) === 47)) {
      const ts = _M0MPB13StringBuilder21StringBuilder_2einner(0);
      let _tmp$2 = 0;
      while (true) {
        const i = _tmp$2;
        if (i < 7) {
          _M0IPB13StringBuilderPB6Logger11write__char(ts, _M0MPC15array5Array2atGcE(cs, i));
          _tmp$2 = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      const text = _M0MPB13StringBuilder21StringBuilder_2einner(0);
      const _bind = cs.length;
      let _tmp$3 = 7;
      while (true) {
        const i = _tmp$3;
        if (i < _bind) {
          _M0IPB13StringBuilderPB6Logger11write__char(text, _M0MPC15array5Array2atGcE(cs, i));
          _tmp$3 = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      return new _M0TP49poipoiiii8moonaprs3lib4aprs6Status(text.val, ts.val);
    }
  }
  return new _M0TP49poipoiiii8moonaprs3lib4aprs6Status(body, undefined);
}
function _M0FP49poipoiiii8moonaprs3lib4aprs14position__body(body, allow_timestamp) {
  const _bind = _M0FP49poipoiiii8moonaprs3lib4aprs15parse__position(body, allow_timestamp);
  if (_bind.$tag === 0) {
    const _Err = _bind;
    const _e = _Err._0;
    return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE3Err(_e);
  } else {
    const _Ok = _bind;
    const _position = _Ok._0;
    const _bind$2 = _M0FP49poipoiiii8moonaprs3lib4aprs23weather__from__position(_position);
    if (_bind$2 === undefined) {
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody8Position(_position));
    } else {
      const _Some = _bind$2;
      const _weather = _Some;
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody19PositionWithWeather(_position, _weather));
    }
  }
}
function _M0FP49poipoiiii8moonaprs3lib4aprs11parse__info(info) {
  const cs = _M0MPC16string6String9to__array(info);
  if (cs.length === 0) {
    return _M0FP49poipoiiii8moonaprs3lib4aprs11parse__infoN6constrS949;
  }
  const kind = _M0MPC15array5Array2atGcE(cs, 0);
  switch (kind) {
    case 33: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs14position__body(_M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(info, 1), false);
    }
    case 61: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs14position__body(_M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(info, 1), false);
    }
    case 47: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs14position__body(_M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(info, 1), true);
    }
    case 64: {
      return _M0FP49poipoiiii8moonaprs3lib4aprs14position__body(_M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(info, 1), true);
    }
    case 59: {
      const _bind = _M0FP49poipoiiii8moonaprs3lib4aprs13parse__object(_M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(info, 1));
      if (_bind.$tag === 1) {
        const _Ok = _bind;
        const _o = _Ok._0;
        return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody6Object(_o));
      } else {
        const _Err = _bind;
        const _e = _Err._0;
        return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE3Err(_e);
      }
    }
    case 41: {
      const _bind$2 = _M0FP49poipoiiii8moonaprs3lib4aprs11parse__item(_M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(info, 1));
      if (_bind$2.$tag === 1) {
        const _Ok = _bind$2;
        const _i = _Ok._0;
        return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody4Item(_i));
      } else {
        const _Err = _bind$2;
        const _e = _Err._0;
        return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE3Err(_e);
      }
    }
    case 62: {
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody6Status(_M0FP49poipoiiii8moonaprs3lib4aprs13parse__status(_M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(info, 1))));
    }
    case 95: {
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody7Weather(_M0FP49poipoiiii8moonaprs3lib4aprs14parse__weather(info)));
    }
    case 84: {
      const rest = _M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(info, 1);
      if (rest.length > 0 && _M0MPC15array5Array2atGcE(_M0MPC16string6String9to__array(rest), 0) === 35) {
        const _bind$3 = _M0FP49poipoiiii8moonaprs3lib4aprs16parse__telemetry(_M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(rest, 1));
        if (_bind$3.$tag === 1) {
          const _Ok = _bind$3;
          const _t = _Ok._0;
          return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody9Telemetry(_t));
        } else {
          const _Err = _bind$3;
          const _e = _Err._0;
          return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE3Err(_e);
        }
      } else {
        return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody7Unknown(info));
      }
    }
    case 58: {
      const _bind$3 = _M0FP49poipoiiii8moonaprs3lib4aprs14parse__message(_M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(info, 1));
      if (_bind$3.$tag === 1) {
        const _Ok = _bind$3;
        const _m = _Ok._0;
        return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody7Message(_m));
      } else {
        const _Err = _bind$3;
        const _e = _Err._0;
        return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE3Err(_e);
      }
    }
    case 63: {
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody5Query(_M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(info, 1)));
    }
    case 125: {
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody10ThirdParty(_M0FP49poipoiiii8moonaprs3lib4aprs11chars__rest(info, 1)));
    }
    default: {
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs8AprsBodysE2Ok(new _M0DTP49poipoiiii8moonaprs3lib4aprs8AprsBody7Unknown(info));
    }
  }
}
function _M0MP49poipoiiii8moonaprs3lib4aprs10AprsPacket5parse(line) {
  const _bind = _M0MP49poipoiiii8moonaprs3lib4aprs10Tnc2Packet5parse(line);
  if (_bind.$tag === 0) {
    const _Err = _bind;
    const _e = _Err._0;
    return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10AprsPacketsE3Err(_e);
  } else {
    const _Ok = _bind;
    const _header = _Ok._0;
    const _bind$2 = _M0FP49poipoiiii8moonaprs3lib4aprs11parse__info(_header.info);
    if (_bind$2.$tag === 1) {
      const _Ok$2 = _bind$2;
      const _body = _Ok$2._0;
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10AprsPacketsE2Ok(new _M0TP49poipoiiii8moonaprs3lib4aprs10AprsPacket(_header, _body));
    } else {
      const _Err = _bind$2;
      const _e = _Err._0;
      return new _M0DTPC16result6ResultGRP49poipoiiii8moonaprs3lib4aprs10AprsPacketsE3Err(_e);
    }
  }
}
function _M0MP49poipoiiii8moonaprs3lib5track10TrackPoint3new(lat, lon, time, comment) {
  return new _M0TP49poipoiiii8moonaprs3lib5track10TrackPoint(lat, lon, time, comment);
}
function _M0MP49poipoiiii8moonaprs3lib5track5Track3new(callsign) {
  return new _M0TP49poipoiiii8moonaprs3lib5track5Track(callsign, []);
}
function _M0FP49poipoiiii8moonaprs3lib5track12distance__km(lat1, lon1, lat2, lon2) {
  const phi1 = lat1 * 3.1415926535897931 / 180;
  const phi2 = lat2 * 3.1415926535897931 / 180;
  const _p = lat2 - lat1;
  const dphi = _p * 3.1415926535897931 / 180;
  const _p$2 = lon2 - lon1;
  const dlambda = _p$2 * 3.1415926535897931 / 180;
  const a = _M0FPC14math3sin(dphi / 2) * _M0FPC14math3sin(dphi / 2) + _M0FPC14math3cos(phi1) * _M0FPC14math3cos(phi2) * _M0FPC14math3sin(dlambda / 2) * _M0FPC14math3sin(dlambda / 2);
  const c = 2 * _M0FPC14math5atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return 6371.0088 * c;
}
function _M0MP49poipoiiii8moonaprs3lib5track5Track3add(self, point) {
  const n = self.points.length;
  if (n > 0 && _M0FP49poipoiiii8moonaprs3lib5track12distance__km(_M0MPC15array5Array2atGsE(self.points, n - 1 | 0).lat, _M0MPC15array5Array2atGsE(self.points, n - 1 | 0).lon, point.lat, point.lon) < 0.02) {
    return false;
  }
  _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(self.points, point);
  return true;
}
function _M0MP49poipoiiii8moonaprs3lib5track10TrackStore3new() {
  return new _M0TP49poipoiiii8moonaprs3lib5track10TrackStore([]);
}
function _M0MP49poipoiiii8moonaprs3lib5track10TrackStore4find(self, callsign) {
  const _bind = self.tracks;
  const _bind$2 = _bind.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const track = _bind[_];
      if (track.callsign === callsign) {
        return track;
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return undefined;
}
function _M0MP49poipoiiii8moonaprs3lib5track10TrackStore6record(self, key, position) {
  const point = _M0MP49poipoiiii8moonaprs3lib5track10TrackPoint3new(position.lat, position.lon, position.timestamp, position.comment);
  const _bind = _M0MP49poipoiiii8moonaprs3lib5track10TrackStore4find(self, key);
  if (_bind === undefined) {
    const track = _M0MP49poipoiiii8moonaprs3lib5track5Track3new(key);
    _M0MP49poipoiiii8moonaprs3lib5track5Track3add(track, point);
    _M0MPC15array5Array4pushGRP49poipoiiii8moonaprs3lib4ax2511Ax25AddressE(self.tracks, track);
    return true;
  } else {
    const _Some = _bind;
    const _track = _Some;
    return _M0MP49poipoiiii8moonaprs3lib5track5Track3add(_track, point);
  }
}
function _M0MP49poipoiiii8moonaprs3lib5track10TrackStore6ingest(self, packet) {
  const header = packet.header;
  const _bind = packet.body;
  switch (_bind.$tag) {
    case 0: {
      const _Position = _bind;
      const _p = _Position._0;
      return _M0MP49poipoiiii8moonaprs3lib5track10TrackStore6record(self, _M0MP49poipoiiii8moonaprs3lib4ax258Callsign10to__string(header.src), _p);
    }
    case 1: {
      const _PositionWithWeather = _bind;
      const _p$2 = _PositionWithWeather._0;
      return _M0MP49poipoiiii8moonaprs3lib5track10TrackStore6record(self, _M0MP49poipoiiii8moonaprs3lib4ax258Callsign10to__string(header.src), _p$2);
    }
    case 6: {
      const _Object = _bind;
      const _o = _Object._0;
      return _M0MP49poipoiiii8moonaprs3lib5track10TrackStore6record(self, _o.name, _o.position);
    }
    case 7: {
      const _Item = _bind;
      const _i = _Item._0;
      return _M0MP49poipoiiii8moonaprs3lib5track10TrackStore6record(self, _i.name, _i.position);
    }
    default: {
      return false;
    }
  }
}
function _M0FP49poipoiiii8moonaprs3lib3svg20lat__to__mercator__y(lat) {
  const phi = (lat > 85.05112878 ? 85.05112878 : lat < -85.05112878 ? -85.05112878 : lat) * 3.1415926535897931 / 180;
  return 0.5 - _M0FPC14math2ln(_M0FPC14math3tan(0.78539816339744828 + phi / 2)) / 6.2831853071795862;
}
function _M0MP49poipoiiii8moonaprs3lib3svg9Projector3new(min_lat, max_lat, min_lon, max_lon, width, height, margin) {
  const x0 = (min_lon + 180) / 360;
  const x1 = (max_lon + 180) / 360;
  const y0 = _M0FP49poipoiiii8moonaprs3lib3svg20lat__to__mercator__y(max_lat);
  const y1 = _M0FP49poipoiiii8moonaprs3lib3svg20lat__to__mercator__y(min_lat);
  const dx = x1 - x0 > 1e-009 ? x1 - x0 : 1e-009;
  const dy = y1 - y0 > 1e-009 ? y1 - y0 : 1e-009;
  const avail_w = width + 0 - 2 * margin;
  const avail_h = height + 0 - 2 * margin;
  const sx = avail_w / dx;
  const sy = avail_h / dy;
  const scale = sx < sy ? sx : sy;
  const used_w = dx * scale;
  const used_h = dy * scale;
  return new _M0TP49poipoiiii8moonaprs3lib3svg9Projector(scale, margin + (avail_w - used_w) / 2 - x0 * scale, margin + (avail_h - used_h) / 2 - y0 * scale);
}
function _M0MP49poipoiiii8moonaprs3lib3svg9Projector7project(self, lat, lon) {
  const x = (lon + 180) / 360 * self.scale + self.offset_x;
  const y = _M0FP49poipoiiii8moonaprs3lib3svg20lat__to__mercator__y(lat) * self.scale + self.offset_y;
  return { _0: x, _1: y };
}
function _M0FP49poipoiiii8moonaprs3lib3svg11escape__xml(s) {
  const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  const _bind = _M0MPC16string6String9to__array(s);
  const _bind$2 = _bind.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind$2) {
      const c = _bind[_];
      if (c === 38) {
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "&amp;");
      } else {
        if (c === 60) {
          _M0IPB13StringBuilderPB6Logger13write__string(sb, "&lt;");
        } else {
          if (c === 62) {
            _M0IPB13StringBuilderPB6Logger13write__string(sb, "&gt;");
          } else {
            if (c === 34) {
              _M0IPB13StringBuilderPB6Logger13write__string(sb, "&quot;");
            } else {
              _M0IPB13StringBuilderPB6Logger11write__char(sb, c);
            }
          }
        }
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  return sb.val;
}
function _M0FP49poipoiiii8moonaprs3lib3svg14render__tracks(tracks, width, height, title) {
  let min_lat = 90;
  let max_lat = -90;
  let min_lon = 180;
  let max_lon = -180;
  let has_points = false;
  const _bind = tracks.length;
  let _tmp = 0;
  while (true) {
    const _ = _tmp;
    if (_ < _bind) {
      const track = tracks[_];
      const _bind$2 = track.points;
      const _bind$3 = _bind$2.length;
      let _tmp$2 = 0;
      while (true) {
        const _$2 = _tmp$2;
        if (_$2 < _bind$3) {
          const point = _bind$2[_$2];
          has_points = true;
          if (point.lat < min_lat) {
            min_lat = point.lat;
          }
          if (point.lat > max_lat) {
            max_lat = point.lat;
          }
          if (point.lon < min_lon) {
            min_lon = point.lon;
          }
          if (point.lon > max_lon) {
            max_lon = point.lon;
          }
          _tmp$2 = _$2 + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      _tmp = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  if (!has_points) {
    min_lat = 48;
    max_lat = 50;
    min_lon = -73;
    max_lon = -71;
  }
  const lat_span = max_lat - min_lat;
  const lon_span = max_lon - min_lon;
  if (lat_span < 0.01) {
    min_lat = min_lat - 0.005;
    max_lat = max_lat + 0.005;
  } else {
    min_lat = min_lat - lat_span * 0.08;
    max_lat = max_lat + lat_span * 0.08;
  }
  if (lon_span < 0.01) {
    min_lon = min_lon - 0.005;
    max_lon = max_lon + 0.005;
  } else {
    min_lon = min_lon - lon_span * 0.08;
    max_lon = max_lon + lon_span * 0.08;
  }
  const projector = _M0MP49poipoiiii8moonaprs3lib3svg9Projector3new(min_lat, max_lat, min_lon, max_lon, width, height, 36);
  const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(sb, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
  _M0IPB13StringBuilderPB6Logger13write__string(sb, "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"");
  _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0MPC13int3Int18to__string_2einner(width, 10));
  _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" height=\"");
  _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0MPC13int3Int18to__string_2einner(height, 10));
  _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" viewBox=\"0 0 ");
  _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0MPC13int3Int18to__string_2einner(width, 10));
  _M0IPB13StringBuilderPB6Logger13write__string(sb, " ");
  _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0MPC13int3Int18to__string_2einner(height, 10));
  _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" role=\"img\" aria-label=\"");
  _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib3svg11escape__xml(title));
  _M0IPB13StringBuilderPB6Logger13write__string(sb, "\">\n");
  _M0IPB13StringBuilderPB6Logger13write__string(sb, "<rect width=\"100%\" height=\"100%\" fill=\"#f8fafc\" stroke=\"#cbd5e1\"/>\n");
  let grid_lat = -80;
  while (true) {
    if (grid_lat <= 80) {
      const _p = grid_lat;
      const _bind$2 = _M0MP49poipoiiii8moonaprs3lib3svg9Projector7project(projector, _p + 0, min_lon);
      const _gy = _bind$2._1;
      if (_gy > 0 && _gy < height + 0) {
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "<line x1=\"0\" y1=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(_gy, 1));
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" x2=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0MPC13int3Int18to__string_2einner(width, 10));
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" y2=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(_gy, 1));
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" stroke=\"#e2e8f0\" stroke-width=\"1\"/>\n");
      }
      grid_lat = grid_lat + 10 | 0;
      continue;
    } else {
      break;
    }
  }
  let color_index = 0;
  const _bind$2 = tracks.length;
  let _tmp$2 = 0;
  while (true) {
    const _ = _tmp$2;
    if (_ < _bind$2) {
      const track = tracks[_];
      _L: {
        const points = track.points;
        if (points.length === 0) {
          break _L;
        }
        const color = _M0MPC15array5Array2atGsE(_M0FP49poipoiiii8moonaprs3lib3svg7palette, color_index % _M0FP49poipoiiii8moonaprs3lib3svg7palette.length | 0);
        color_index = color_index + 1 | 0;
        if (points.length > 1) {
          _M0IPB13StringBuilderPB6Logger13write__string(sb, "<path d=\"");
          const _bind$3 = points.length;
          let _tmp$3 = 0;
          while (true) {
            const i = _tmp$3;
            if (i < _bind$3) {
              const _p = _M0MPC15array5Array2atGsE(points, i);
              const _tmp$4 = _p.lat;
              const _p$2 = _M0MPC15array5Array2atGsE(points, i);
              const _bind$4 = _M0MP49poipoiiii8moonaprs3lib3svg9Projector7project(projector, _tmp$4, _p$2.lon);
              const _x = _bind$4._0;
              const _y = _bind$4._1;
              if (i === 0) {
                _M0IPB13StringBuilderPB6Logger13write__string(sb, "M ");
              } else {
                _M0IPB13StringBuilderPB6Logger13write__string(sb, " L ");
              }
              _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(_x, 1));
              _M0IPB13StringBuilderPB6Logger13write__string(sb, " ");
              _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(_y, 1));
              _tmp$3 = i + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" fill=\"none\" stroke=\"");
          _M0IPB13StringBuilderPB6Logger13write__string(sb, color);
          _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" stroke-width=\"2.5\" stroke-linejoin=\"round\"/>\n");
        }
        const first = _M0MPC15array5Array2atGsE(points, 0);
        const _bind$3 = _M0MP49poipoiiii8moonaprs3lib3svg9Projector7project(projector, first.lat, first.lon);
        const _fx = _bind$3._0;
        const _fy = _bind$3._1;
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "<circle cx=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(_fx, 1));
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" cy=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(_fy, 1));
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" r=\"4\" fill=\"none\" stroke=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, color);
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" stroke-width=\"2\"/>\n");
        const last = _M0MPC15array5Array2atGsE(points, points.length - 1 | 0);
        const _bind$4 = _M0MP49poipoiiii8moonaprs3lib3svg9Projector7project(projector, last.lat, last.lon);
        const _lx = _bind$4._0;
        const _ly = _bind$4._1;
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "<circle cx=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(_lx, 1));
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" cy=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(_ly, 1));
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" r=\"5\" fill=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, color);
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\"/>\n");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "<text x=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(_lx + 9, 1));
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" y=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(_ly + 4, 1));
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\" font-family=\"ui-monospace, Menlo, Consolas, monospace\" font-size=\"12\" fill=\"#0f172a\">");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib3svg11escape__xml(track.callsign));
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "</text>\n");
        break _L;
      }
      _tmp$2 = _ + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  _M0IPB13StringBuilderPB6Logger13write__string(sb, "<text x=\"12\" y=\"22\" font-family=\"ui-sans-serif, system-ui, sans-serif\" font-size=\"14\" font-weight=\"600\" fill=\"#0f172a\">");
  _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP49poipoiiii8moonaprs3lib3svg11escape__xml(title));
  _M0IPB13StringBuilderPB6Logger13write__string(sb, "</text>\n");
  _M0IPB13StringBuilderPB6Logger13write__string(sb, "</svg>\n");
  return sb.val;
}
function _M0FP39poipoiiii8moonaprs3web6latlon(p) {
  return `${_M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(p.lat, 4)},${_M0FP49poipoiiii8moonaprs3lib4aprs13format__fixed(p.lon, 4)}`;
}
function _M0FP39poipoiiii8moonaprs3web9summarize(packet) {
  const header = packet.header;
  const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0MP49poipoiiii8moonaprs3lib4ax258Callsign10to__string(header.src));
  _M0IPB13StringBuilderPB6Logger13write__string(sb, "  ");
  const _bind = packet.body;
  switch (_bind.$tag) {
    case 0: {
      const _Position = _bind;
      const _p = _Position._0;
      _M0IPB13StringBuilderPB6Logger13write__string(sb, `position ${_M0FP39poipoiiii8moonaprs3web6latlon(_p)}  ${_p.comment}`);
      break;
    }
    case 1: {
      const _PositionWithWeather = _bind;
      const _p$2 = _PositionWithWeather._0;
      const _w = _PositionWithWeather._1;
      _M0IPB13StringBuilderPB6Logger13write__string(sb, `position ${_M0FP39poipoiiii8moonaprs3web6latlon(_p$2)}  weather: ${_M0MP49poipoiiii8moonaprs3lib4aprs7Weather7summary(_w)}`);
      break;
    }
    case 2: {
      const _Weather = _bind;
      const _w$2 = _Weather._0;
      _M0IPB13StringBuilderPB6Logger13write__string(sb, `weather: ${_M0MP49poipoiiii8moonaprs3lib4aprs7Weather7summary(_w$2)}`);
      break;
    }
    case 3: {
      const _Telemetry = _bind;
      const _t = _Telemetry._0;
      _M0IPB13StringBuilderPB6Logger13write__string(sb, `telemetry ${_t.name} #${_M0MPC13int3Int18to__string_2einner(_t.seq, 10)}`);
      break;
    }
    case 4: {
      const _Status = _bind;
      const _s = _Status._0;
      _M0IPB13StringBuilderPB6Logger13write__string(sb, `status: ${_s.text}`);
      break;
    }
    case 5: {
      const _Message = _bind;
      const _m = _Message._0;
      const _p$3 = _m.ack_id;
      if (!(_p$3 === undefined)) {
        const _p$4 = _m.ack_id;
        let _tmp;
        if (_p$4 === undefined) {
          _tmp = $panic();
        } else {
          const _p$5 = _p$4;
          _tmp = _p$5;
        }
        _M0IPB13StringBuilderPB6Logger13write__string(sb, `ack ${_tmp}`);
      } else {
        _M0IPB13StringBuilderPB6Logger13write__string(sb, `message to ${_m.addressee}: ${_m.text}`);
      }
      break;
    }
    case 6: {
      const _Object = _bind;
      const _o = _Object._0;
      _M0IPB13StringBuilderPB6Logger13write__string(sb, `object ${_o.name}  ${_M0FP39poipoiiii8moonaprs3web6latlon(_o.position)}`);
      break;
    }
    case 7: {
      const _Item = _bind;
      const _i = _Item._0;
      _M0IPB13StringBuilderPB6Logger13write__string(sb, `item ${_i.name}  ${_M0FP39poipoiiii8moonaprs3web6latlon(_i.position)}`);
      break;
    }
    case 8: {
      const _Query = _bind;
      const _q = _Query._0;
      _M0IPB13StringBuilderPB6Logger13write__string(sb, `query: ${_q}`);
      break;
    }
    case 9: {
      const _ThirdParty = _bind;
      const _inner = _ThirdParty._0;
      _M0IPB13StringBuilderPB6Logger13write__string(sb, `third-party: ${_inner}`);
      break;
    }
    default: {
      const _Unknown = _bind;
      const _text = _Unknown._0;
      _M0IPB13StringBuilderPB6Logger13write__string(sb, `unhandled: ${_text}`);
    }
  }
  return sb.val;
}
function _M0FP39poipoiiii8moonaprs3web10parse__all(text) {
  const store = _M0MP49poipoiiii8moonaprs3lib5track10TrackStore3new();
  const report = _M0MPB13StringBuilder21StringBuilder_2einner(0);
  let total = 0;
  let ok = 0;
  const _it = _M0MPC16string6String5split(text, _M0FP39poipoiiii8moonaprs3web10parse__allN6recordS1159);
  while (true) {
    const _bind = _M0MPB4Iter4nextGRPC16string10StringViewE(_it);
    if (_bind === undefined) {
      break;
    } else {
      const _Some = _bind;
      const _line = _Some;
      const trimmed = _M0MPC16string10StringView9to__owned(_M0MPC16string10StringView4trim(_line, undefined));
      if (trimmed.length === 0 || _M0MPC16string6String11has__prefix(trimmed, _M0FP39poipoiiii8moonaprs3web10parse__allN6recordS1160)) {
        continue;
      }
      total = total + 1 | 0;
      const _bind$2 = _M0MP49poipoiiii8moonaprs3lib4aprs10AprsPacket5parse(trimmed);
      if (_bind$2.$tag === 1) {
        const _Ok = _bind$2;
        const _packet = _Ok._0;
        ok = ok + 1 | 0;
        _M0MP49poipoiiii8moonaprs3lib5track10TrackStore6ingest(store, _packet);
        _M0IPB13StringBuilderPB6Logger13write__string(report, `${_M0FP39poipoiiii8moonaprs3web9summarize(_packet)}\n`);
      } else {
        const _Err = _bind$2;
        const _e = _Err._0;
        _M0IPB13StringBuilderPB6Logger13write__string(report, `error: ${_e}\n`);
      }
      continue;
    }
  }
  _M0IPB13StringBuilderPB6Logger13write__string(report, "\n");
  _M0IPB13StringBuilderPB6Logger13write__string(report, `decoded ${_M0MPC13int3Int18to__string_2einner(ok, 10)}/${_M0MPC13int3Int18to__string_2einner(total, 10)} packets, ${_M0MPC13int3Int18to__string_2einner(store.tracks.length, 10)} stations tracked`);
  const svg = _M0FP49poipoiiii8moonaprs3lib3svg14render__tracks(store.tracks, 900, 540, "MoonAPRS track map");
  _M0FP39poipoiiii8moonaprs3web10js__render(report.val, svg);
}
(() => {
  _M0FP39poipoiiii8moonaprs3web8js__bind(_M0FP39poipoiiii8moonaprs3web10parse__all);
})();
