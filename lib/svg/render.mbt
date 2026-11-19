///|
fn pi() -> Double {
  3.141592653589793
}

///|
/// Clamp a latitude to the Web Mercator domain.
fn clamp_lat(lat : Double) -> Double {
  if lat > 85.05112878 {
    85.05112878
  } else if lat < -85.05112878 {
    -85.05112878
  } else {
    lat
  }
}

///|
/// Normalised Web Mercator X in `[0, 1]`, where 0 is 180°W.
pub fn lon_to_mercator_x(lon : Double) -> Double {
  (lon + 180.0) / 360.0
}

///|
/// Normalised Web Mercator Y in `[0, 1]`, where 0 is the north edge.
pub fn lat_to_mercator_y(lat : Double) -> Double {
  let phi = clamp_lat(lat) * pi() / 180.0
  0.5 - @math.ln(@math.tan(pi() / 4.0 + phi / 2.0)) / (2.0 * pi())
}

///|
/// Maps latitude/longitude onto SVG pixel coordinates for a fixed width and
/// height, preserving aspect ratio.
pub struct Projector {
  scale : Double
  offset_x : Double
  offset_y : Double
}

///|
/// Build a projector that fits the given bounds into `width` x `height` with a
/// pixel margin.
pub fn Projector::new(
  min_lat : Double,
  max_lat : Double,
  min_lon : Double,
  max_lon : Double,
  width : Int32,
  height : Int32,
  margin : Double,
) -> Projector {
  let x0 = lon_to_mercator_x(min_lon)
  let x1 = lon_to_mercator_x(max_lon)
  let y0 = lat_to_mercator_y(max_lat)
  let y1 = lat_to_mercator_y(min_lat)
  let dx = if x1 - x0 > 1.0e-9 { x1 - x0 } else { 1.0e-9 }
  let dy = if y1 - y0 > 1.0e-9 { y1 - y0 } else { 1.0e-9 }
  let avail_w = Double::from_int(width) - 2.0 * margin
  let avail_h = Double::from_int(height) - 2.0 * margin
  let sx = avail_w / dx
  let sy = avail_h / dy
  let scale = if sx < sy { sx } else { sy }
  let used_w = dx * scale
  let used_h = dy * scale
  {
    scale,
    offset_x: margin + (avail_w - used_w) / 2.0 - x0 * scale,
    offset_y: margin + (avail_h - used_h) / 2.0 - y0 * scale,
  }
}

///|
/// Project a point to SVG coordinates.
pub fn Projector::project(
  self : Projector,
  lat : Double,
  lon : Double,
) -> (Double, Double) {
  let x = lon_to_mercator_x(lon) * self.scale + self.offset_x
  let y = lat_to_mercator_y(lat) * self.scale + self.offset_y
  (x, y)
}

///|
/// Human readable name for common APRS symbol codes.
pub fn symbol_name(code : Char) -> String {
  match code {
    '-' => "house"
    '>' => "car"
    '_' => "weather station"
    'k' => "truck"
    'j' => "jeep"
    'b' => "bicycle"
    'R' => "repeater"
    '#' => "digipeater"
    '&' => "gateway"
    'W' => "weather"
    'S' => "satellite"
    'P' => "police"
    'A' => "aid station"
    'Y' => "yacht"
    '/' => "dot"
    _ => "station"
  }
}

///|
fn escape_xml(s : String) -> String {
  let sb = StringBuilder()
  for c in s.to_array() {
    if c == '&' {
      sb.write_string("&amp;")
    } else if c == '<' {
      sb.write_string("&lt;")
    } else if c == '>' {
      sb.write_string("&gt;")
    } else if c == '"' {
      sb.write_string("&quot;")
    } else {
      sb.write_char(c)
    }
  }
  sb.to_string()
}

///|
let palette : Array[String] = [
  "#2563eb", "#dc2626", "#059669", "#d97706", "#7c3aed", "#0891b2", "#db2777", "#65a30d",
]

///|
/// Render the given tracks as an SVG map.
///
/// The map uses Web Mercator projection, a light background, one coloured
/// polyline per station, a hollow circle at the first point and a filled
/// circle with the callsign label at the last point.
pub fn render_tracks(
  tracks : Array[@track.Track],
  width : Int32,
  height : Int32,
  title : String,
) -> String {
  let mut min_lat = 90.0
  let mut max_lat = -90.0
  let mut min_lon = 180.0
  let mut max_lon = -180.0
  let mut has_points = false
  for track in tracks {
    for point in track.points() {
      has_points = true
      if point.latitude() < min_lat {
        min_lat = point.latitude()
      }
      if point.latitude() > max_lat {
        max_lat = point.latitude()
      }
      if point.longitude() < min_lon {
        min_lon = point.longitude()
      }
      if point.longitude() > max_lon {
        max_lon = point.longitude()
      }
    }
  }
  if !has_points {
    min_lat = 48.0
    max_lat = 50.0
    min_lon = -73.0
    max_lon = -71.0
  }
  let lat_span = max_lat - min_lat
  let lon_span = max_lon - min_lon
  if lat_span < 0.01 {
    min_lat = min_lat - 0.005
    max_lat = max_lat + 0.005
  } else {
    min_lat = min_lat - lat_span * 0.08
    max_lat = max_lat + lat_span * 0.08
  }
  if lon_span < 0.01 {
    min_lon = min_lon - 0.005
    max_lon = max_lon + 0.005
  } else {
    min_lon = min_lon - lon_span * 0.08
    max_lon = max_lon + lon_span * 0.08
  }
  let projector = Projector::new(
    min_lat, max_lat, min_lon, max_lon, width, height, 36.0,
  )
  let sb = StringBuilder()
  sb.write_string("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
  sb.write_string("<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"")
  sb.write_string(width.to_string())
  sb.write_string("\" height=\"")
  sb.write_string(height.to_string())
  sb.write_string("\" viewBox=\"0 0 ")
  sb.write_string(width.to_string())
  sb.write_string(" ")
  sb.write_string(height.to_string())
  sb.write_string("\" role=\"img\" aria-label=\"")
  sb.write_string(escape_xml(title))
  sb.write_string("\">\n")
  sb.write_string(
    "<rect width=\"100%\" height=\"100%\" fill=\"#f8fafc\" stroke=\"#cbd5e1\"/>\n",
  )
  // Simple graticule.
  let mut grid_lat = -80
  while grid_lat <= 80 {
    let (_, gy) = projector.project(Double::from_int(grid_lat), min_lon)
    if gy > 0.0 && gy < Double::from_int(height) {
      sb.write_string("<line x1=\"0\" y1=\"")
      sb.write_string(@aprs.format_fixed(gy, 1))
      sb.write_string("\" x2=\"")
      sb.write_string(width.to_string())
      sb.write_string("\" y2=\"")
      sb.write_string(@aprs.format_fixed(gy, 1))
      sb.write_string("\" stroke=\"#e2e8f0\" stroke-width=\"1\"/>\n")
    }
    grid_lat = grid_lat + 10
  }
  let mut color_index = 0
  for track in tracks {
    let points = track.points()
    if points.length() == 0 {
      continue
    }
    let color = palette[color_index % palette.length()]
    color_index = color_index + 1
    if points.length() > 1 {
      sb.write_string("<path d=\"")
      for i in 0..<points.length() {
        let (x, y) = projector.project(
          points[i].latitude(),
          points[i].longitude(),
        )
        if i == 0 {
          sb.write_string("M ")
        } else {
          sb.write_string(" L ")
        }
        sb.write_string(@aprs.format_fixed(x, 1))
        sb.write_string(" ")
        sb.write_string(@aprs.format_fixed(y, 1))
      }
      sb.write_string("\" fill=\"none\" stroke=\"")
      sb.write_string(color)
      sb.write_string("\" stroke-width=\"2.5\" stroke-linejoin=\"round\"/>\n")
    }
    let first = points[0]
    let (fx, fy) = projector.project(first.latitude(), first.longitude())
    sb.write_string("<circle cx=\"")
    sb.write_string(@aprs.format_fixed(fx, 1))
    sb.write_string("\" cy=\"")
    sb.write_string(@aprs.format_fixed(fy, 1))
    sb.write_string("\" r=\"4\" fill=\"none\" stroke=\"")
    sb.write_string(color)
    sb.write_string("\" stroke-width=\"2\"/>\n")
    let last = points[points.length() - 1]
    let (lx, ly) = projector.project(last.latitude(), last.longitude())
    sb.write_string("<circle cx=\"")
    sb.write_string(@aprs.format_fixed(lx, 1))
    sb.write_string("\" cy=\"")
    sb.write_string(@aprs.format_fixed(ly, 1))
    sb.write_string("\" r=\"5\" fill=\"")
    sb.write_string(color)
    sb.write_string("\"/>\n")
    sb.write_string("<text x=\"")
    sb.write_string(@aprs.format_fixed(lx + 9.0, 1))
    sb.write_string("\" y=\"")
    sb.write_string(@aprs.format_fixed(ly + 4.0, 1))
    sb.write_string(
      "\" font-family=\"ui-monospace, Menlo, Consolas, monospace\" font-size=\"12\" fill=\"#0f172a\">",
    )
    sb.write_string(escape_xml(track.callsign()))
    sb.write_string("</text>\n")
  }
  sb.write_string(
    "<text x=\"12\" y=\"22\" font-family=\"ui-sans-serif, system-ui, sans-serif\" font-size=\"14\" font-weight=\"600\" fill=\"#0f172a\">",
  )
  sb.write_string(escape_xml(title))
  sb.write_string("</text>\n")
  sb.write_string("</svg>\n")
  sb.to_string()
}
