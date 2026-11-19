///|
/// The timestamp formats used by APRS reports.
pub(all) enum TimestampKind {
  /// `DDHHMMz` — day, hour, minute, UTC.
  DayZulu
  /// `DDHHMM/` — day, hour, minute, local time.
  DayLocal
  /// `HHMMSSh` — hour, minute, second.
  HourMinuteSecond
  /// `MMDDHHMM` — month, day, hour, minute (weather reports).
  MonthDayHourMinute
}

///|
/// A short stable label for the timestamp kind.
pub fn TimestampKind::label(self : TimestampKind) -> String {
  match self {
    DayZulu => "day-zulu"
    DayLocal => "day-local"
    HourMinuteSecond => "hour-minute-second"
    MonthDayHourMinute => "month-day-hour-minute"
  }
}

///|
/// A parsed APRS timestamp.
///
/// APRS timestamps carry no year, and the day-only forms carry no month. Fields
/// that are absent are zero and the original text is kept in `raw`.
pub struct Timestamp {
  kind : TimestampKind
  month : Int32
  day : Int32
  hour : Int32
  minute : Int32
  second : Int32
  raw : String
}

///|
/// The timestamp kind.
pub fn Timestamp::kind_of(self : Timestamp) -> TimestampKind {
  self.kind
}

///|
/// Month (1-12), or 0 when the format has no month.
pub fn Timestamp::month_of(self : Timestamp) -> Int32 {
  self.month
}

///|
/// Day of month (1-31), or 0 when the format has no day.
pub fn Timestamp::day_of(self : Timestamp) -> Int32 {
  self.day
}

///|
/// Hour (0-23).
pub fn Timestamp::hour_of(self : Timestamp) -> Int32 {
  self.hour
}

///|
/// Minute (0-59).
pub fn Timestamp::minute_of(self : Timestamp) -> Int32 {
  self.minute
}

///|
/// Second (0-59), or 0 when the format has no seconds.
pub fn Timestamp::second_of(self : Timestamp) -> Int32 {
  self.second
}

///|
/// The original timestamp text.
pub fn Timestamp::raw_text(self : Timestamp) -> String {
  self.raw
}

///|
/// Minutes since midnight.
pub fn Timestamp::minutes_of_day(self : Timestamp) -> Int32 {
  self.hour * 60 + self.minute
}

///|
/// Seconds since midnight.
pub fn Timestamp::seconds_of_day(self : Timestamp) -> Int32 {
  self.hour * 3600 + self.minute * 60 + self.second
}

///|
fn digits_value(cs : Array[Char], start : Int32, count : Int32) -> Int32? {
  if start + count > cs.length() {
    return None
  }
  let mut value = 0
  for i in 0..<count {
    let c = cs[start + i]
    if c < '0' || c > '9' {
      return None
    }
    value = value * 10 + (c.to_int() - '0'.to_int())
  }
  Some(value)
}

///|
fn valid_clock(hour : Int32, minute : Int32, second : Int32) -> Bool {
  hour >= 0 &&
  hour < 24 &&
  minute >= 0 &&
  minute < 60 &&
  second >= 0 &&
  second < 60
}

///|
fn valid_date(month : Int32, day : Int32) -> Bool {
  month >= 1 && month <= 12 && day >= 1 && day <= 31
}

///|
/// Parse an APRS timestamp.
///
/// Accepts `DDHHMMz`, `DDHHMM/`, `HHMMSSh` and the eight digit `MMDDHHMM`
/// weather timestamp. The caller may pass a longer string; extra characters are
/// preserved in `raw` but ignored for parsing.
pub fn Timestamp::parse(text : String) -> Result[Timestamp, String] {
  let cs = text.to_array()
  if cs.length() < 7 {
    return Err("timestamp is shorter than seven characters")
  }
  let raw_sb = StringBuilder()
  for i in 0..<7 {
    raw_sb.write_char(cs[i])
  }
  let raw = raw_sb.to_string()
  if cs.length() >= 8 {
    if digits_value(cs, 0, 8) is Some(_) {
      let month = digits_value(cs, 0, 2).unwrap()
      let day = digits_value(cs, 2, 2).unwrap()
      let hour = digits_value(cs, 4, 2).unwrap()
      let minute = digits_value(cs, 6, 2).unwrap()
      if !valid_date(month, day) {
        return Err("month/day out of range")
      }
      if !valid_clock(hour, minute, 0) {
        return Err("hour/minute out of range")
      }
      let raw8 = StringBuilder()
      for i in 0..<8 {
        raw8.write_char(cs[i])
      }
      return Ok({
        kind: MonthDayHourMinute,
        month,
        day,
        hour,
        minute,
        second: 0,
        raw: raw8.to_string(),
      })
    }
  }
  let suffix = cs[6]
  if suffix == 'z' || suffix == '/' {
    let day = match digits_value(cs, 0, 2) {
      Some(v) => v
      None => return Err("day is not numeric")
    }
    let hour = match digits_value(cs, 2, 2) {
      Some(v) => v
      None => return Err("hour is not numeric")
    }
    let minute = match digits_value(cs, 4, 2) {
      Some(v) => v
      None => return Err("minute is not numeric")
    }
    if day < 1 || day > 31 {
      return Err("day out of range")
    }
    if !valid_clock(hour, minute, 0) {
      return Err("hour/minute out of range")
    }
    Ok({
      kind: if suffix == 'z' {
        DayZulu
      } else {
        DayLocal
      },
      month: 0,
      day,
      hour,
      minute,
      second: 0,
      raw,
    })
  } else if suffix == 'h' {
    let hour = match digits_value(cs, 0, 2) {
      Some(v) => v
      None => return Err("hour is not numeric")
    }
    let minute = match digits_value(cs, 2, 2) {
      Some(v) => v
      None => return Err("minute is not numeric")
    }
    let second = match digits_value(cs, 4, 2) {
      Some(v) => v
      None => return Err("second is not numeric")
    }
    if !valid_clock(hour, minute, second) {
      return Err("time out of range")
    }
    Ok({ kind: HourMinuteSecond, month: 0, day: 0, hour, minute, second, raw, })
  } else {
    Err("unknown timestamp suffix")
  }
}

///|
/// Render the timestamp back to its wire form.
pub fn Timestamp::to_string(self : Timestamp) -> String {
  self.raw
}

///|
/// Difference in minutes from `self` to `other`, wrapping at midnight when both
/// timestamps use the same day-based format.
pub fn Timestamp::minutes_until(self : Timestamp, other : Timestamp) -> Int32 {
  let a = self.minutes_of_day() * 60 + self.second
  let b = other.minutes_of_day() * 60 + other.second
  let mut delta = b - a
  if delta < 0 && (self.kind is DayZulu || self.kind is DayLocal) {
    delta = delta + 24 * 3600
  }
  if delta >= 0 {
    delta / 60
  } else {
    (delta - 59) / 60
  }
}
