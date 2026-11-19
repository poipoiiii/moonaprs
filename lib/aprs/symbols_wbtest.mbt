///|
test "primary symbol lookup" {
  assert_eq(symbol_name_for('/', '-'), "house")
  assert_eq(symbol_name_for('/', '>'), "car")
  assert_eq(symbol_name_for('/', '_'), "weather station")
  assert_eq(symbol_category_for('/', '_'), "weather")
  assert_eq(symbol_category_for('/', '!'), "emergency")
}

///|
test "alternate symbol lookup" {
  assert_eq(symbol_name_for('\\', 'R'), "repeater")
  assert_eq(symbol_name_for('\\', '&'), "gateway")
  assert_eq(symbol_name_for('\\', 'S'), "satellite")
}

///|
test "overlay characters use the alternate table" {
  assert_eq(symbol_name_for('A', 'R'), "repeater")
  assert_eq(symbol_info('A', 'R').table_char(), 'A')
  assert_eq(symbol_info('A', 'R').code_char(), 'R')
}

///|
test "unknown symbols are labelled" {
  assert_eq(symbol_name_for('/', '~'), "unknown")
  assert_eq(symbol_category_for('/', '~'), "other")
}
