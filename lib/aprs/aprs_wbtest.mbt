///|
fn near(a : Double, b : Double) -> Bool {
  (a - b).abs() < 0.0005
}

///|
test "aprs-is passcode vectors" {
  assert_eq(passcode("N0CALL").unwrap(), 13023)
  assert_eq(passcode("APRS").unwrap(), 24801)
  assert_eq(passcode("WIDE2-2").unwrap(), 21230)
  assert_eq(passcode("K1ABC").unwrap(), 14993)
  assert_true(passcode("bad!") is Err(_))
}

///|
test "login line formatting" {
  assert_eq(
    login_line("N0CALL", 13023, ""),
    "user N0CALL pass 13023 vers MoonAPRS 0.6.0",
  )
  assert_eq(
    login_line("N0CALL", -1, filter_range(49.0, -72.0, 100)),
    "user N0CALL pass -1 vers MoonAPRS 0.6.0 filter r/49.0000/-72.0000/100",
  )
}

///|
test "filter builder joins terms" {
  let filter = FilterBuilder::new()
    .range(49.0, -72.0, 100)
    .prefix(["APRS", "WIDE"])
    .budlist(["N0CALL", "K1ABC"])
  assert_eq(
    filter.to_string(),
    "r/49.0000/-72.0000/100 p/APRS/WIDE b/N0CALL/K1ABC",
  )
}

///|
test "tnc2 header parsing" {
  let packet = Tnc2Packet::parse("N0CALL-9>APRS,WIDE2-1,WIDE1*:hi").unwrap()
  assert_eq(packet.source().to_string(), "N0CALL-9")
  assert_eq(packet.destination().to_string(), "APRS")
  assert_eq(packet.path().length(), 2)
  assert_eq(packet.path()[1].is_repeated(), true)
  assert_eq(packet.info_field(), "hi")
  assert_eq(packet.to_string(), "N0CALL-9>APRS,WIDE2-1,WIDE1*:hi")
}

///|
test "tnc2 rejects malformed lines" {
  assert_true(Tnc2Packet::parse("N0CALL APRS:hi") is Err(_))
  assert_true(Tnc2Packet::parse("N0CALL>APRS") is Err(_))
  assert_true(Tnc2Packet::parse(">APRS:hi") is Err(_))
}

///|
test "uncompressed position without timestamp" {
  let body = parse_info("!4903.50N/07201.75W-Test").unwrap()
  match body {
    Position(p) => {
      assert_true(near(p.latitude(), 49.058333))
      assert_true(near(p.longitude(), -72.029167))
      assert_eq(p.table(), '/')
      assert_eq(p.symbol(), '-')
      assert_eq(p.comment_text(), "Test")
      assert_eq(p.timestamp_text() is None, true)
    }
    _ => abort("expected a position")
  }
}

///|
test "position with timestamp" {
  let body = parse_info("@092345z4903.50N/07201.75W>Test").unwrap()
  match body {
    Position(p) => {
      assert_eq(p.timestamp_text().unwrap(), "092345z")
      assert_eq(p.symbol(), '>')
    }
    _ => abort("expected a position")
  }
}

///|
test "compressed position matches the spec example" {
  let body = parse_info("!/5L!!<*e7>7P[").unwrap()
  match body {
    Position(p) => {
      assert_true(near(p.latitude(), 49.5))
      assert_true(near(p.longitude(), -72.75))
      assert_eq(p.is_compressed(), true)
      assert_eq(p.symbol(), '>')
    }
    _ => abort("expected a compressed position")
  }
}

///|
test "position with ambiguity" {
  let body = parse_info("!4903.  N/07201.  W-").unwrap()
  match body {
    Position(p) => assert_true(p.ambiguity_digits() >= 2)
    _ => abort("expected a position")
  }
}

///|
test "positionless weather" {
  let body = parse_info("_10090556c220s004g005t077r000p000P000h50b10159").unwrap()
  match body {
    Weather(w) => {
      assert_eq(w.wind_direction().unwrap(), 220)
      assert_eq(w.wind_speed_mph().unwrap(), 4)
      assert_eq(w.gust_mph().unwrap(), 5)
      assert_eq(w.temperature().unwrap(), 77)
      assert_eq(w.humidity().unwrap(), 50)
      assert_eq(w.pressure().unwrap(), 10159)
      assert_eq(w.timestamp_text().unwrap(), "10090556")
    }
    _ => abort("expected weather")
  }
}

///|
test "position with weather suffix" {
  let body = parse_info("!4903.50N/07201.75W_220/004g005t077").unwrap()
  match body {
    PositionWithWeather(_, w) => {
      assert_eq(w.wind_direction().unwrap(), 220)
      assert_eq(w.wind_speed_mph().unwrap(), 4)
      assert_eq(w.gust_mph().unwrap(), 5)
      assert_eq(w.temperature().unwrap(), 77)
    }
    _ => abort("expected a position with weather")
  }
}

///|
test "telemetry" {
  let body = parse_info("T#MIC,123,1,2,3,4,5,10101010").unwrap()
  match body {
    Telemetry(t) => {
      assert_eq(t.channel(), "MIC")
      assert_eq(t.sequence(), 123)
      assert_eq(t.analog_values().length(), 5)
      assert_eq(t.digital_bits(), "10101010")
    }
    _ => abort("expected telemetry")
  }
}

///|
test "message and acknowledgement" {
  match parse_info(":N0CALL   :Hello there{123").unwrap() {
    Message(m) => {
      assert_eq(m.to_call(), "N0CALL")
      assert_eq(m.body(), "Hello there")
      assert_eq(m.id().unwrap(), "123")
      assert_eq(m.is_ack(), false)
    }
    _ => abort("expected a message")
  }
  match parse_info(":N0CALL   :ack123").unwrap() {
    Message(m) => {
      assert_eq(m.is_ack(), true)
      assert_eq(m.acked_id().unwrap(), "123")
    }
    _ => abort("expected a message")
  }
}

///|
test "status with and without timestamp" {
  match parse_info(">Net control").unwrap() {
    Status(s) => {
      assert_eq(s.text_of(), "Net control")
      assert_eq(s.timestamp_text() is None, true)
    }
    _ => abort("expected status")
  }
  match parse_info(">092345zNet control").unwrap() {
    Status(s) => assert_eq(s.timestamp_text().unwrap(), "092345z")
    _ => abort("expected status")
  }
}

///|
test "object and item reports" {
  match parse_info(";LEADER   *092345z4903.50N/07201.75W>Test").unwrap() {
    Object(o) => {
      assert_eq(o.object_name(), "LEADER")
      assert_eq(o.is_alive(), true)
      assert_true(near(o.position().latitude(), 49.058333))
    }
    _ => abort("expected object")
  }
  match parse_info(")AID!4903.50N/07201.75W>Test").unwrap() {
    Item(i) => {
      assert_eq(i.item_name(), "AID")
      assert_eq(i.is_alive(), true)
    }
    _ => abort("expected item")
  }
}

///|
test "full packet parse" {
  let packet = AprsPacket::parse(
    "N0CALL-9>APRS,WIDE2-1:!4903.50N/07201.75W-Test",
  ).unwrap()
  assert_eq(packet.header().source().to_string(), "N0CALL-9")
  assert_eq(packet.body().describe(), "position 49.0583,-72.0292")
}

///|
test "unknown payload is preserved" {
  match parse_info("Xsomething").unwrap() {
    Unknown(text) => assert_eq(text, "Xsomething")
    _ => abort("expected unknown")
  }
}

///|
test "bad position is an error" {
  assert_true(parse_info("!4903.50X/07201.75W-") is Err(_))
  assert_true(parse_info("!4903.5N/07201.75W-") is Err(_))
}
