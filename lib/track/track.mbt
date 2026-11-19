///|
/// One position sample in a track.
pub struct TrackPoint {
  lat : Double
  lon : Double
  time : String?
  comment : String
  symbol : Char?
}

///|
/// Build a track point without symbol information.
pub fn TrackPoint::new(
  lat : Double,
  lon : Double,
  time : String?,
  comment : String,
) -> TrackPoint {
  { lat, lon, time, comment, symbol: None, }
}

///|
/// Build a track point with an APRS symbol code.
pub fn TrackPoint::with_symbol(
  lat : Double,
  lon : Double,
  time : String?,
  comment : String,
  symbol : Char,
) -> TrackPoint {
  { lat, lon, time, comment, symbol: Some(symbol), }
}

///|
/// The APRS symbol code, when the point came from a position packet.
pub fn TrackPoint::symbol_code(self : TrackPoint) -> Char? {
  self.symbol
}

///|
/// Latitude in decimal degrees.
pub fn TrackPoint::latitude(self : TrackPoint) -> Double {
  self.lat
}

///|
/// Longitude in decimal degrees.
pub fn TrackPoint::longitude(self : TrackPoint) -> Double {
  self.lon
}

///|
/// The raw APRS timestamp, when the packet carried one.
pub fn TrackPoint::timestamp_text(self : TrackPoint) -> String? {
  self.time
}

///|
/// The free-form comment of the originating packet.
pub fn TrackPoint::comment_text(self : TrackPoint) -> String {
  self.comment
}

///|
/// An axis-aligned latitude/longitude box.
pub struct BoundingBox {
  min_lat : Double
  max_lat : Double
  min_lon : Double
  max_lon : Double
}

///|
pub fn BoundingBox::min_latitude(self : BoundingBox) -> Double {
  self.min_lat
}

///|
pub fn BoundingBox::max_latitude(self : BoundingBox) -> Double {
  self.max_lat
}

///|
pub fn BoundingBox::min_longitude(self : BoundingBox) -> Double {
  self.min_lon
}

///|
pub fn BoundingBox::max_longitude(self : BoundingBox) -> Double {
  self.max_lon
}

///|
/// Expand the box by a margin in degrees on every side.
pub fn BoundingBox::padded(
  self : BoundingBox,
  margin_deg : Double,
) -> BoundingBox {
  {
    min_lat: self.min_lat - margin_deg,
    max_lat: self.max_lat + margin_deg,
    min_lon: self.min_lon - margin_deg,
    max_lon: self.max_lon + margin_deg,
  }
}

///|
/// A station track: an ordered list of position samples.
pub struct Track {
  callsign : String
  points : Array[TrackPoint]
}

///|
/// Create an empty track for a callsign.
pub fn Track::new(callsign : String) -> Track {
  { callsign, points: [], }
}

///|
/// The station callsign.
pub fn Track::callsign(self : Track) -> String {
  self.callsign
}

///|
/// The recorded points, oldest first.
pub fn Track::points(self : Track) -> Array[TrackPoint] {
  self.points
}

///|
/// Append a position sample. Samples within 20 metres of the previous one are
/// treated as duplicate beacons and ignored. Returns whether the point was
/// added.
pub fn Track::add(self : Track, point : TrackPoint) -> Bool {
  let n = self.points.length()
  if n > 0 &&
    distance_km(
      self.points[n - 1].lat,
      self.points[n - 1].lon,
      point.lat,
      point.lon,
    ) <
    0.02 {
    return false
  }
  self.points.push(point)
  true
}

///|
/// Total path length in kilometres.
pub fn Track::length_km(self : Track) -> Double {
  let mut total = 0.0
  for i in 1..<self.points.length() {
    let a = self.points[i - 1]
    let b = self.points[i]
    total = total + distance_km(a.lat, a.lon, b.lat, b.lon)
  }
  total
}

///|
/// Bounding box of all points, or `None` for an empty track.
pub fn Track::bounds(self : Track) -> BoundingBox? {
  if self.points.length() == 0 {
    return None
  }
  let first = self.points[0]
  let mut min_lat = first.lat
  let mut max_lat = first.lat
  let mut min_lon = first.lon
  let mut max_lon = first.lon
  for point in self.points {
    if point.lat < min_lat {
      min_lat = point.lat
    }
    if point.lat > max_lat {
      max_lat = point.lat
    }
    if point.lon < min_lon {
      min_lon = point.lon
    }
    if point.lon > max_lon {
      max_lon = point.lon
    }
  }
  Some({ min_lat, max_lat, min_lon, max_lon, })
}

///|
fn local_xy(lat : Double, lon : Double, ref_lat : Double) -> (Double, Double) {
  let x = lon * 111.320 * @math.cos(ref_lat * 3.141592653589793 / 180.0)
  let y = lat * 110.574
  (x, y)
}

///|
fn segment_distance_km(
  a : TrackPoint,
  b : TrackPoint,
  p : TrackPoint,
) -> Double {
  let (ax, ay) = local_xy(a.lat, a.lon, a.lat)
  let (bx, by) = local_xy(b.lat, b.lon, a.lat)
  let (px, py) = local_xy(p.lat, p.lon, a.lat)
  let dx = bx - ax
  let dy = by - ay
  let len_sq = dx * dx + dy * dy
  if len_sq == 0.0 {
    let ex = px - ax
    let ey = py - ay
    return (ex * ex + ey * ey).sqrt()
  }
  let mut t = ((px - ax) * dx + (py - ay) * dy) / len_sq
  if t < 0.0 {
    t = 0.0
  }
  if t > 1.0 {
    t = 1.0
  }
  let cx = ax + t * dx
  let cy = ay + t * dy
  ((px - cx) * (px - cx) + (py - cy) * (py - cy)).sqrt()
}

///|
fn douglas_peucker(
  points : Array[TrackPoint],
  keep : Array[Bool],
  first : Int32,
  last : Int32,
  tolerance_km : Double,
) -> Unit {
  if last <= first + 1 {
    return
  }
  let mut max_dist = 0.0
  let mut index = first
  for i in (first + 1)..<last {
    let d = segment_distance_km(points[first], points[last], points[i])
    if d > max_dist {
      max_dist = d
      index = i
    }
  }
  if max_dist > tolerance_km {
    keep[index] = true
    douglas_peucker(points, keep, first, index, tolerance_km)
    douglas_peucker(points, keep, index, last, tolerance_km)
  }
}

///|
/// Simplify a path with the Douglas-Peucker algorithm. The tolerance is a
/// perpendicular distance in kilometres; endpoints are always kept.
pub fn simplify(
  points : Array[TrackPoint],
  tolerance_km : Double,
) -> Array[TrackPoint] {
  let n = points.length()
  if n <= 2 {
    let copy : Array[TrackPoint] = []
    for point in points {
      copy.push(point)
    }
    return copy
  }
  let keep : Array[Bool] = Array::make(n, false)
  keep[0] = true
  keep[n - 1] = true
  douglas_peucker(points, keep, 0, n - 1, tolerance_km)
  let out : Array[TrackPoint] = []
  for i in 0..<n {
    if keep[i] {
      out.push(points[i])
    }
  }
  out
}

///|
/// A collection of tracks keyed by callsign.
pub struct TrackStore {
  tracks : Array[Track]
}

///|
pub fn TrackStore::new() -> TrackStore {
  { tracks: [], }
}

///|
fn TrackStore::find(self : TrackStore, callsign : String) -> Track? {
  for track in self.tracks {
    if track.callsign == callsign {
      return Some(track)
    }
  }
  None
}

///|
/// The number of tracks in the store.
pub fn TrackStore::size(self : TrackStore) -> Int32 {
  self.tracks.length()
}

///|
/// All tracks in insertion order.
pub fn TrackStore::all(self : TrackStore) -> Array[Track] {
  self.tracks
}

///|
/// Look up a track by callsign.
pub fn TrackStore::track(self : TrackStore, callsign : String) -> Track? {
  self.find(callsign)
}

///|
/// Extract a position from an APRS payload and record it, keyed by the packet
/// source (or by object / item name for those reports). Returns whether a
/// position was recorded.
pub fn TrackStore::ingest(self : TrackStore, packet : @aprs.AprsPacket) -> Bool {
  let header = packet.header()
  match packet.body() {
    @aprs.Position(p) => self.record(header.source().to_string(), p)
    @aprs.PositionWithWeather(p, _) =>
      self.record(header.source().to_string(), p)
    @aprs.Object(o) => self.record(o.object_name(), o.position())
    @aprs.Item(i) => self.record(i.item_name(), i.position())
    @aprs.MicE(m) =>
      self.record_point(
        header.source().to_string(),
        TrackPoint::with_symbol(
          m.latitude(),
          m.longitude(),
          None,
          m.status_text(),
          m.symbol(),
        ),
      )
    _ => false
  }
}

///|
fn TrackStore::record(
  self : TrackStore,
  key : String,
  position : @aprs.Position,
) -> Bool {
  self.record_point(
    key,
    TrackPoint::with_symbol(
      position.latitude(),
      position.longitude(),
      position.timestamp_text(),
      position.comment_text(),
      position.symbol(),
    ),
  )
}

///|
fn TrackStore::record_point(
  self : TrackStore,
  key : String,
  point : TrackPoint,
) -> Bool {
  match self.find(key) {
    Some(track) => track.add(point)
    None => {
      let track = Track::new(key)
      ignore(track.add(point))
      self.tracks.push(track)
      true
    }
  }
}
