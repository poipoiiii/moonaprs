///|
/// Native APRS-IS TCP transport (Windows / Linux / macOS).

///|
#borrow(host)
extern "C" fn tcp_connect_ffi(
  host : Bytes,
  host_len : Int32,
  port : Int32,
) -> Int64 = "moonaprs_tcp_connect"

///|
/// Reads one line into `buf`; returns the line length (>= 0), -1 on EOF/error,
/// -2 if the line exceeded `buf`'s capacity.
#borrow(buf)
extern "C" fn tcp_read_line_ffi(
  handle : Int64,
  buf : Bytes,
  cap : Int32,
) -> Int32 = "moonaprs_tcp_read_line"

///|
#borrow(line)
extern "C" fn tcp_write_line_ffi(
  handle : Int64,
  line : Bytes,
  len : Int32,
) -> Int32 = "moonaprs_tcp_write_line"

///|
extern "C" fn tcp_close_ffi(handle : Int64) -> Unit = "moonaprs_tcp_close"

///|
extern "C" fn sleep_ms_ffi(ms : Int32) -> Unit = "moonaprs_sleep_ms"

///|
/// A connected TCP socket.
pub struct TcpTransport {
  handle : Int64
}

///|
/// Dial `host:port`; returns `None` on failure.
pub fn tcp_connect(host : String, port : Int32) -> TcpTransport? {
  let host_bytes = @aprs.utf8_encode(host)
  let handle = tcp_connect_ffi(host_bytes, host_bytes.length(), port)
  if handle < 0L {
    None
  } else {
    Some({ handle, })
  }
}

///|
pub fn sleep_ms(ms : Int32) -> Unit {
  sleep_ms_ffi(ms)
}

///|
impl @aprs.IsTransport for TcpTransport with fn read_line(self : TcpTransport) -> String? {
  let buf = Bytes::make(4096, 0)
  let n = tcp_read_line_ffi(self.handle, buf, buf.length())
  if n < 0 {
    None
  } else {
    Some(@aprs.utf8_decode_lossy(buf[0:n]))
  }
}

///|
impl @aprs.IsTransport for TcpTransport with fn write_line(
  self : TcpTransport,
  line : String,
) -> Unit {
  let bytes = @aprs.utf8_encode(line)
  ignore(tcp_write_line_ffi(self.handle, bytes, bytes.length()))
}

///|
impl @aprs.IsTransport for TcpTransport with fn close(self : TcpTransport) -> Unit {
  tcp_close_ffi(self.handle)
}
