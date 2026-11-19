///|
fn weather_sample() -> Weather {
  parse_weather("10090556c220s010g020t077r100p050P200h50b10159")
}

///|
test "fahrenheit to celsius" {
  let w = weather_sample()
  assert_true((w.temperature_celsius().unwrap() - 25.0).abs() < 0.01)
}

///|
test "wind conversions" {
  let w = weather_sample()
  assert_true((w.wind_speed_kmh().unwrap() - 16.09344).abs() < 0.001)
  assert_true((w.gust_kmh().unwrap() - 32.18688).abs() < 0.001)
}

///|
test "rain and pressure conversions" {
  let w = weather_sample()
  assert_true((w.rain_1h_mm().unwrap() - 25.4).abs() < 0.001)
  assert_true((w.rain_24h_mm().unwrap() - 12.7).abs() < 0.001)
  assert_true((w.pressure_hpa().unwrap() - 1015.9).abs() < 0.001)
}

///|
test "missing weather fields stay missing" {
  let w = parse_weather("")
  assert_eq(w.temperature_celsius() is None, true)
  assert_eq(w.pressure_hpa() is None, true)
}
