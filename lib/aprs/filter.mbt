///|
/// Build an APRS-IS filter term for a radius (`r/lat/lon/radius_km`).
pub fn filter_range(lat : Double, lon : Double, radius_km : Int32) -> String {
  "r/" +
  format_fixed(lat, 4) +
  "/" +
  format_fixed(lon, 4) +
  "/" +
  radius_km.to_string()
}

///|
/// Build an APRS-IS filter term for a latitude/longitude box
/// (`a/lat/lon/height/width`, in degrees).
pub fn filter_area(
  lat : Double,
  lon : Double,
  height_deg : Double,
  width_deg : Double,
) -> String {
  "a/" +
  format_fixed(lat, 4) +
  "/" +
  format_fixed(lon, 4) +
  "/" +
  format_fixed(height_deg, 2) +
  "/" +
  format_fixed(width_deg, 2)
}

///|
/// Build a prefix filter term (`p/area1/area2`).
pub fn filter_prefix(areas : Array[String]) -> String {
  "p/" + join_strings(areas, "/")
}

///|
/// Build a buddy filter term (`b/call1/call2`).
pub fn filter_budlist(calls : Array[String]) -> String {
  "b/" + join_strings(calls, "/")
}

///|
/// Build a type filter term (`t/p` for position reports, `t/poimqstunw` for
/// everything commonly useful).
pub fn filter_type(types : String) -> String {
  "t/" + types
}

///|
/// A small builder that joins filter terms with spaces.
pub struct FilterBuilder {
  terms : Array[String]
}

///|
pub fn FilterBuilder::new() -> FilterBuilder {
  { terms: [], }
}

///|
/// Append an arbitrary filter term.
pub fn FilterBuilder::term(
  self : FilterBuilder,
  term : String,
) -> FilterBuilder {
  self.terms.push(term)
  self
}

///|
/// Shorthand for `term(filter_range(...))`.
pub fn FilterBuilder::range(
  self : FilterBuilder,
  lat : Double,
  lon : Double,
  radius_km : Int32,
) -> FilterBuilder {
  self.term(filter_range(lat, lon, radius_km))
}

///|
/// Shorthand for `term(filter_prefix(...))`.
pub fn FilterBuilder::prefix(
  self : FilterBuilder,
  areas : Array[String],
) -> FilterBuilder {
  self.term(filter_prefix(areas))
}

///|
/// Shorthand for `term(filter_budlist(...))`.
pub fn FilterBuilder::budlist(
  self : FilterBuilder,
  calls : Array[String],
) -> FilterBuilder {
  self.term(filter_budlist(calls))
}

///|
/// Render the filter expression.
pub fn FilterBuilder::to_string(self : FilterBuilder) -> String {
  join_strings(self.terms, " ")
}
