///|
test "parse zulu day timestamp" {
  let ts = Timestamp::parse("092345z").unwrap()
  assert_eq(ts.kind_of().label(), "day-zulu")
  assert_eq(ts.day_of(), 9)
  assert_eq(ts.hour_of(), 23)
  assert_eq(ts.minute_of(), 45)
  assert_eq(ts.minutes_of_day(), 23 * 60 + 45)
  assert_eq(ts.to_string(), "092345z")
}

///|
test "parse local day timestamp" {
  let ts = Timestamp::parse("011200/").unwrap()
  assert_eq(ts.kind_of().label(), "day-local")
  assert_eq(ts.day_of(), 1)
  assert_eq(ts.minute_of(), 0)
}

///|
test "parse hour minute second timestamp" {
  let ts = Timestamp::parse("234500h").unwrap()
  assert_eq(ts.kind_of().label(), "hour-minute-second")
  assert_eq(ts.hour_of(), 23)
  assert_eq(ts.second_of(), 0)
  assert_eq(ts.seconds_of_day(), 23 * 3600 + 45 * 60)
}

///|
test "parse weather month day timestamp" {
  let ts = Timestamp::parse("10090556").unwrap()
  assert_eq(ts.kind_of().label(), "month-day-hour-minute")
  assert_eq(ts.month_of(), 10)
  assert_eq(ts.day_of(), 9)
  assert_eq(ts.hour_of(), 5)
  assert_eq(ts.minute_of(), 56)
}

///|
test "timestamp rejects invalid values" {
  assert_true(Timestamp::parse("992345z") is Err(_))
  assert_true(Timestamp::parse("092460z") is Err(_))
  assert_true(Timestamp::parse("12345z") is Err(_))
  assert_true(Timestamp::parse("092345x") is Err(_))
}

///|
test "timestamp difference wraps midnight" {
  let late = Timestamp::parse("312355z").unwrap()
  let early = Timestamp::parse("010005z").unwrap()
  assert_eq(late.minutes_until(early), 10)
}
