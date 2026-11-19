///|
test "bulletin classification and subject" {
  let msg = parse_info(":BLN1     :ARES  Net tonight at 8pm").unwrap()
  match msg {
    Message(m) => {
      assert_eq(classify_message(m).label(), "bulletin-1")
      assert_eq(bulletin_subject(m).unwrap(), "ARES")
      assert_eq(bulletin_body(m).unwrap(), "Net tonight at 8pm")
      assert_eq(
        describe_message(m),
        "bulletin 1 [ARES] Net tonight at 8pm",
      )
    }
    _ => abort("expected a message")
  }
}

///|
test "NWS messages are classified" {
  let msg = parse_info(":NWS-WARN :Tornado warning for the area").unwrap()
  match msg {
    Message(m) => assert_eq(classify_message(m).label(), "nws")
    _ => abort("expected a message")
  }
}

///|
test "personal messages stay personal" {
  let msg = parse_info(":N0CALL   :hello").unwrap()
  match msg {
    Message(m) => {
      assert_eq(classify_message(m).label(), "personal")
      assert_eq(bulletin_subject(m) is None, true)
    }
    _ => abort("expected a message")
  }
}
