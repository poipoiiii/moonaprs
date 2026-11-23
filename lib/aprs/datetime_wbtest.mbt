///|
fn ref_utc() -> DateTime {
  DateTime::from_ymd_hms(2026, 11, 23, 12, 0, 0)
}

///|
fn iso_of(text : String, reference : DateTime, offset : Int32) -> String {
  match Timestamp::parse(text) {
    Ok(ts) =>
      match resolve_aprs_time(ts, reference, offset) {
        Some(dt) => dt.to_iso8601()
        None => "NONE"
      }
    Err(_) => "ERR"
  }
}

///|
test "datetime round-trips through unix seconds" {
  let samples : Array[(Int32, Int32, Int32)] = [
    (1970, 1, 1),
    (1969, 12, 31),
    (2000, 2, 29),
    (2020, 2, 29),
    (2026, 11, 23),
    (2100, 3, 1),
    (1582, 10, 15),
  ]
  for (y, m, d) in samples {
    let dt = DateTime::from_ymd_hms(y, m, d, 13, 45, 7)
    let back = DateTime::from_unix_seconds(dt.to_unix_seconds())
    assert_eq(back.to_iso8601(), dt.to_iso8601())
  }
}

///|
test "datetime known epoch values" {
  let y2k = DateTime::from_ymd_hms(2000, 1, 1, 0, 0, 0)
  assert_eq(y2k.to_unix_seconds(), 946684800L)
  let epoch = DateTime::from_unix_ms(0L)
  assert_eq(epoch.to_iso8601(), "1970-01-01T00:00:00Z")
  assert_eq(
    DateTime::from_unix_seconds(86400L).to_iso8601(),
    "1970-01-02T00:00:00Z",
  )
}

///|
test "add_minutes rolls months and years" {
  let dt = DateTime::from_ymd_hms(2026, 1, 1, 0, 0, 0)
  assert_eq(dt.add_minutes(-1).to_iso8601(), "2025-12-31T23:59:00Z")
  assert_eq(dt.add_minutes(1440).to_iso8601(), "2026-01-02T00:00:00Z")
}

///|
test "resolve day-zulu stays in reference month" {
  let r = ref_utc()
  assert_eq(iso_of("231155z", r, 0), "2026-11-23T11:55:00Z")
  assert_eq(iso_of("010000z", r, 0), "2026-11-01T00:00:00Z")
}

///|
test "resolve day-zulu after reference day goes to previous month" {
  assert_eq(iso_of("240001z", ref_utc(), 0), "2026-10-24T00:01:00Z")
}

///|
test "resolve month-day-hour-minute rolls back a year" {
  assert_eq(iso_of("12312359", ref_utc(), 0), "2025-12-31T23:59:00Z")
  assert_eq(iso_of("11231100", ref_utc(), 0), "2026-11-23T11:00:00Z")
}

///|
test "resolve hour-minute-second rolls back a day" {
  let r = ref_utc()
  assert_eq(iso_of("130000h", r, 0), "2026-11-22T13:00:00Z")
  assert_eq(iso_of("110000h", r, 0), "2026-11-23T11:00:00Z")
}

///|
test "resolve day-local applies the utc offset" {
  let r = DateTime::from_ymd_hms(2026, 11, 23, 4, 0, 0)
  assert_eq(iso_of("231200/", r, 480), "2026-11-23T04:00:00Z")
  assert_eq(iso_of("230000/", r, 480), "2026-11-22T16:00:00Z")
}

///|
test "resolve refuses an impossible calendar date" {
  assert_eq(iso_of("02300000", ref_utc(), 0), "NONE")
}
