///|
/// Speed and course between two consecutive track points.
pub struct SpeedSample {
  from_index : Int
  to_index : Int
  speed_kmh : Double
  course_deg : Double
}

///|
/// Index of the earlier point.
pub fn SpeedSample::from_point(self : SpeedSample) -> Int {
  self.from_index
}

///|
/// Index of the later point.
pub fn SpeedSample::to_point(self : SpeedSample) -> Int {
  self.to_index
}

///|
/// Ground speed in kilometres per hour.
pub fn SpeedSample::speed_kmh(self : SpeedSample) -> Double {
  self.speed_kmh
}

///|
/// Course over ground in degrees clockwise from north.
pub fn SpeedSample::course(self : SpeedSample) -> Double {
  self.course_deg
}

///|
/// Compute speed and course for every consecutive pair of points that carries
/// parseable timestamps.
pub fn Track::speeds(self : Track) -> Array[SpeedSample] {
  let out : Array[SpeedSample] = []
  let points = self.points
  for i in 1..<points.length() {
    let a = points[i - 1]
    let b = points[i]
    let (from_ts, to_ts) = match (a.time, b.time) {
      (Some(x), Some(y)) => (x, y)
      _ => continue
    }
    let ta = match @aprs.Timestamp::parse(from_ts) {
      Ok(t) => t
      Err(_) => continue
    }
    let tb = match @aprs.Timestamp::parse(to_ts) {
      Ok(t) => t
      Err(_) => continue
    }
    let minutes = ta.minutes_until(tb)
    if minutes <= 0 {
      continue
    }
    let km = distance_km(a.lat, a.lon, b.lat, b.lon)
    out.push({
      from_index: i - 1,
      to_index: i,
      speed_kmh: km * 60.0 / Double::from_int(minutes),
      course_deg: bearing_deg(a.lat, a.lon, b.lat, b.lon),
    })
  }
  out
}

///|
/// Mean ground speed over all timed segments, or 0 when no segment has a usable
/// timestamp.
pub fn Track::average_speed_kmh(self : Track) -> Double {
  let samples = self.speeds()
  if samples.length() == 0 {
    return 0.0
  }
  let mut total = 0.0
  for sample in samples {
    total = total + sample.speed_kmh
  }
  total / Double::from_int(samples.length())
}
