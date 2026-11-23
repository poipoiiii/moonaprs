///|
/// Wall-clock instants (UTC) and APRS timestamp resolution.
///
/// APRS timestamps never carry a year and some omit the month, so they are
/// ambiguous on their own.  `resolve_aprs_time` anchors them to a reference
/// wall-clock instant (typically "now") by choosing the most recent matching
/// instant that does not lie in the future of the reference.

///|
/// A UTC instant decomposed into civil calendar fields.
pub struct DateTime {
  year : Int32
  month : Int32
  day : Int32
  hour : Int32
  minute : Int32
  second : Int32
}

///|
pub fn DateTime::from_ymd_hms(
  year : Int32,
  month : Int32,
  day : Int32,
  hour : Int32,
  minute : Int32,
  second : Int32,
) -> DateTime {
  { year, month, day, hour, minute, second, }
}

///|
/// True for Gregorian leap years.
fn is_leap_year(year : Int32) -> Bool {
  (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
}

///|
/// Number of days in a month, or 0 for an invalid month.
pub fn days_in_month(year : Int32, month : Int32) -> Int32 {
  match month {
    1 | 3 | 5 | 7 | 8 | 10 | 12 => 31
    4 | 6 | 9 | 11 => 30
    2 => if is_leap_year(year) { 29 } else { 28 }
    _ => 0
  }
}

///|
/// Days from 1970-01-01 (the Unix epoch) to the given civil date.
fn days_from_civil(y : Int32, m : Int32, d : Int32) -> Int64 {
  let y2 = if m <= 2 { y - 1 } else { y }
  let era = (if y2 >= 0 { y2 } else { y2 - 399 }) / 400
  let yoe = y2 - era * 400
  let m2 = if m > 2 { m - 3 } else { m + 9 }
  let doy = (153 * m2 + 2) / 5 + d - 1
  let doe = yoe * 365 + yoe / 4 - yoe / 100 + doy
  Int64::from_int(era) * 146097L + Int64::from_int(doe) - 719468L
}

///|
/// (year, month, day) from days since the Unix epoch.
fn civil_from_days(z : Int64) -> (Int32, Int32, Int32) {
  let z2 = z + 719468L
  let era = (if z2 >= 0L { z2 } else { z2 - 146096L }) / 146097L
  let doe = (z2 - era * 146097L).to_int()
  let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365
  let y = yoe + era.to_int() * 400
  let doy = doe - (365 * yoe + yoe / 4 - yoe / 100)
  let mp = (5 * doy + 2) / 153
  let day = doy - (153 * mp + 2) / 5 + 1
  let month = if mp < 10 { mp + 3 } else { mp - 9 }
  let year = if month <= 2 { y + 1 } else { y }
  (year, month, day)
}

///|
/// Floor division (correct for negative operands, unlike plain `/`).
fn floor_div(a : Int64, b : Int64) -> Int64 {
  let q = a / b
  if a % b != 0L && (a < 0L) != (b < 0L) {
    q - 1L
  } else {
    q
  }
}

///|
/// Build a `DateTime` from milliseconds since the Unix epoch (UTC).
pub fn DateTime::from_unix_ms(ms : Int64) -> DateTime {
  DateTime::from_unix_seconds(floor_div(ms, 1000L))
}

///|
/// Build a `DateTime` from seconds since the Unix epoch (UTC).
pub fn DateTime::from_unix_seconds(secs : Int64) -> DateTime {
  let day = floor_div(secs, 86400L)
  let rem = secs - day * 86400L
  let s = rem.to_int()
  let (year, month, day_of_month) = civil_from_days(day)
  {
    year,
    month,
    day: day_of_month,
    hour: s / 3600,
    minute: s % 3600 / 60,
    second: s % 60,
  }
}

///|
/// Seconds since the Unix epoch (UTC).
pub fn DateTime::to_unix_seconds(self : DateTime) -> Int64 {
  days_from_civil(self.year, self.month, self.day) * 86400L +
  Int64::from_int(self.hour * 3600 + self.minute * 60 + self.second)
}

///|
/// Shift this instant by `minutes` (may be negative), rolling the calendar.
pub fn DateTime::add_minutes(self : DateTime, minutes : Int32) -> DateTime {
  DateTime::from_unix_seconds(
    self.to_unix_seconds() + Int64::from_int(minutes) * 60L,
  )
}

///|
fn pad2(n : Int32) -> String {
  if n < 0 {
    "-" + pad2(-n)
  } else if n < 10 {
    "0" + n.to_string()
  } else {
    n.to_string()
  }
}

///|
fn pad4(n : Int32) -> String {
  if n < 0 {
    "-" + pad4(-n)
  } else {
    let s = n.to_string()
    if s.length() == 4 {
      s
    } else if s.length() == 3 {
      "0" + s
    } else if s.length() == 2 {
      "00" + s
    } else if s.length() == 1 {
      "000" + s
    } else {
      s
    }
  }
}

///|
/// ISO 8601 UTC representation, e.g. `2026-11-23T12:00:00Z`.
pub fn DateTime::to_iso8601(self : DateTime) -> String {
  pad4(self.year) +
  "-" +
  pad2(self.month) +
  "-" +
  pad2(self.day) +
  "T" +
  pad2(self.hour) +
  ":" +
  pad2(self.minute) +
  ":" +
  pad2(self.second) +
  "Z"
}

///|
fn not_after(a : DateTime, b : DateTime) -> Bool {
  a.to_unix_seconds() <= b.to_unix_seconds()
}

///|
/// Which APRS timestamp kinds are expressed in local time and therefore need
/// the caller-supplied UTC offset to be anchored.
fn is_local_kind(kind : TimestampKind) -> Bool {
  match kind {
    DayLocal => true
    MonthDayHourMinute => true
    _ => false
  }
}

///|
fn resolve_mdhm(ts : Timestamp, reference : DateTime) -> DateTime? {
  let mut year = reference.year
  let mut tries = 0
  while tries < 10 {
    let dim = days_in_month(year, ts.month_of())
    if dim > 0 && ts.day_of() <= dim {
      let cand = DateTime::from_ymd_hms(
        year,
        ts.month_of(),
        ts.day_of(),
        ts.hour_of(),
        ts.minute_of(),
        0,
      )
      if not_after(cand, reference) {
        return Some(cand)
      }
    }
    year = year - 1
    tries = tries + 1
  }
  None
}

///|
fn resolve_day(ts : Timestamp, reference : DateTime) -> DateTime? {
  let mut year = reference.year
  let mut month = reference.month
  let mut tries = 0
  while tries < 24 {
    let dim = days_in_month(year, month)
    if ts.day_of() > 0 && ts.day_of() <= dim {
      let cand = DateTime::from_ymd_hms(
        year,
        month,
        ts.day_of(),
        ts.hour_of(),
        ts.minute_of(),
        0,
      )
      if not_after(cand, reference) {
        return Some(cand)
      }
    }
    month = month - 1
    if month < 1 {
      month = 12
      year = year - 1
    }
    tries = tries + 1
  }
  None
}

///|
fn resolve_hms(ts : Timestamp, reference : DateTime) -> DateTime {
  let cand = DateTime::from_ymd_hms(
    reference.year,
    reference.month,
    reference.day,
    ts.hour_of(),
    ts.minute_of(),
    ts.second_of(),
  )
  if not_after(cand, reference) {
    cand
  } else {
    cand.add_minutes(-1440)
  }
}

///|
/// Anchor an APRS timestamp to a real UTC instant.
///
/// `reference` is the wall-clock instant used for disambiguation (usually the
/// current time).  `local_offset_min` converts local-form timestamps to UTC;
/// for example a station reporting in UTC+8 passes `480`.  Timestamps that are
/// inherently UTC (`z`, `h`) ignore the offset.
pub fn resolve_aprs_time(
  ts : Timestamp,
  reference : DateTime,
  local_offset_min : Int32,
) -> DateTime? {
  let offset = if is_local_kind(ts.kind_of()) { local_offset_min } else { 0 }
  let ref_local = reference.add_minutes(offset)
  let local_dt = match ts.kind_of() {
    MonthDayHourMinute => resolve_mdhm(ts, ref_local)
    DayZulu => resolve_day(ts, ref_local)
    DayLocal => resolve_day(ts, ref_local)
    HourMinuteSecond => Some(resolve_hms(ts, ref_local))
  }
  match local_dt {
    Some(dt) => Some(dt.add_minutes(-offset))
    None => None
  }
}
