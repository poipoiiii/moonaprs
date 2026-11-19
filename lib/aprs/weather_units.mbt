///|
/// Temperature in degrees Celsius, converted from the APRS Fahrenheit field.
pub fn Weather::temperature_celsius(self : Weather) -> Double? {
  match self.temperature_f {
    Some(f) => Some((Double::from_int(f) - 32.0) * 5.0 / 9.0)
    None => None
  }
}

///|
/// Conversion factor from miles per hour to kilometres per hour.
let mph_to_kmh : Double = 1.609344

///|
/// Wind speed in kilometres per hour.
pub fn Weather::wind_speed_kmh(self : Weather) -> Double? {
  match self.wind_speed {
    Some(v) => Some(Double::from_int(v) * mph_to_kmh)
    None => None
  }
}

///|
/// Gust speed in kilometres per hour.
pub fn Weather::gust_kmh(self : Weather) -> Double? {
  match self.gust {
    Some(v) => Some(Double::from_int(v) * mph_to_kmh)
    None => None
  }
}

///|
fn hundredths_inch_to_mm(value : Int32) -> Double {
  Double::from_int(value) * 0.254
}

///|
/// Rain in the last hour, in millimetres.
pub fn Weather::rain_1h_mm(self : Weather) -> Double? {
  match self.rain_last_hour {
    Some(v) => Some(hundredths_inch_to_mm(v))
    None => None
  }
}

///|
/// Rain in the last 24 hours, in millimetres.
pub fn Weather::rain_24h_mm(self : Weather) -> Double? {
  match self.rain_last_24h {
    Some(v) => Some(hundredths_inch_to_mm(v))
    None => None
  }
}

///|
/// Barometric pressure in hectopascals.
pub fn Weather::pressure_hpa(self : Weather) -> Double? {
  match self.pressure_tenths_hpa {
    Some(v) => Some(Double::from_int(v) / 10.0)
    None => None
  }
}
