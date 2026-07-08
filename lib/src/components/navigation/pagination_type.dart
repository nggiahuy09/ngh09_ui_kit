/// The layout mode of a `GHPagination` control.
///
/// Controls whether the trail between the "Previous" and "Next" controls
/// shows individual page-number chips or a compact page count — matching the
/// two pagination layouts documented in the Finesse UI Kit.
enum PaginationType {
  /// Shows tappable page-number chips, collapsing to an ellipsis for long
  /// page ranges (see `GHPagination.siblingCount`/`boundaryCount`).
  numbered,

  /// Shows a compact "Page X of Y" label instead of individual page numbers.
  simple,
}
