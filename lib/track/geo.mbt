///|
/// Mean Earth radius in kilometres (IUGG).
pub let earth_radius_km : Double = 6371.0088

///|
fn to_radians(deg : Double) -> Double {
  deg * 3.141592653589793 / 180.0
}

///|
fn to_degrees(rad : Double) -> Double {
  rad * 180.0 / 3.141592653589793
}

///|
/// Great-circle distance in kilometres between two points (haversine formula).
pub fn distance_km(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Double {
  let phi1 = to_radians(lat1)
  let phi2 = to_radians(lat2)
  let dphi = to_radians(lat2 - lat1)
  let dlambda = to_radians(lon2 - lon1)
  let a = @math.sin(dphi / 2.0) * @math.sin(dphi / 2.0) +
    @math.cos(phi1) *
    @math.cos(phi2) *
    @math.sin(dlambda / 2.0) *
    @math.sin(dlambda / 2.0)
  let c = 2.0 * @math.atan2(a.sqrt(), (1.0 - a).sqrt())
  earth_radius_km * c
}

///|
/// Initial bearing from point 1 to point 2, in degrees clockwise from north.
pub fn bearing_deg(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Double {
  let phi1 = to_radians(lat1)
  let phi2 = to_radians(lat2)
  let dlambda = to_radians(lon2 - lon1)
  let y = @math.sin(dlambda) * @math.cos(phi2)
  let x = @math.cos(phi1) * @math.sin(phi2) -
    @math.sin(phi1) * @math.cos(phi2) * @math.cos(dlambda)
  let deg = to_degrees(@math.atan2(y, x))
  if deg < 0.0 {
    deg + 360.0
  } else {
    deg
  }
}

///|
/// One-letter compass point for a bearing (N, NE, E, ...).
pub fn compass_point(bearing : Double) -> String {
  let names : Array[String] = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
  let index = ((bearing + 22.5) / 45.0).to_int() % 8
  names[if index < 0 { index + 8 } else { index }]
}

///|
/// Maidenhead locator for a latitude/longitude pair, e.g. `FN42`.
pub fn maidenhead(lat : Double, lon : Double) -> String {
  let adjusted_lon = lon + 180.0
  let adjusted_lat = lat + 90.0
  let field_lon = (adjusted_lon / 20.0).to_int()
  let field_lat = (adjusted_lat / 10.0).to_int()
  let square_lon = ((adjusted_lon - Double::from_int(field_lon) * 20.0) / 2.0).to_int()
  let square_lat = (adjusted_lat - Double::from_int(field_lat) * 10.0).to_int()
  let sb = StringBuilder()
  sb.write_char(('A'.to_int() + field_lon).unsafe_to_char())
  sb.write_char(('A'.to_int() + field_lat).unsafe_to_char())
  sb.write_char(('0'.to_int() + square_lon).unsafe_to_char())
  sb.write_char(('0'.to_int() + square_lat).unsafe_to_char())
  sb.to_string()
}
