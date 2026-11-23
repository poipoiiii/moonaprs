///|
test "session login line uses the filter" {
  let session = IsSession::new("N0CALL", 13023, "r/49.0/-72.0/100")
  assert_eq(
    session.login_line(),
    "user N0CALL pass 13023 vers MoonAPRS 0.7.0 filter r/49.0/-72.0/100",
  )
  assert_eq(session.is_logged_in(), false)
}

///|
test "session marks login verified" {
  let session = IsSession::new("N0CALL", -1, "")
  let event = session.handle_line(
    "# aprsc 2.1.4 logresp N0CALL unverified, server T2ONTARIO",
  )
  match event {
    Comment(text) => assert_true(text.contains("logresp"))
    _ => abort("expected a comment")
  }
  assert_eq(session.is_logged_in(), false)
  ignore(
    session.handle_line(
      "# aprsc 2.1.4 logresp N0CALL verified, server T2ONTARIO",
    ),
  )
  assert_eq(session.is_logged_in(), true)
  assert_true(session.server_name().contains("aprsc"))
}

///|
test "session dispatches packets and malformed lines" {
  let session = IsSession::new("N0CALL", -1, "")
  match session.handle_line("N0CALL>APRS:!4903.50N/07201.75W-Test") {
    Packet(packet) => assert_eq(packet.header().source().to_string(), "N0CALL")
    _ => abort("expected a packet")
  }
  match session.handle_line("this is not a packet") {
    Malformed(_) => ()
    _ => abort("expected malformed")
  }
  assert_eq(session.packet_count(), 1)
  assert_eq(session.comment_count(), 0)
}

///|
test "session ignores blank lines" {
  let session = IsSession::new("N0CALL", -1, "")
  match session.handle_line("   ") {
    Ignored => ()
    _ => abort("expected ignored")
  }
}
