/// The corner-radius shape of a `GHTooltip`.
///
/// Matches the two corner styles in the Finesse UI Kit "Tooltips" component set.
enum TooltipCorner {
  /// Squared-off corners (0 dp radius). The default.
  sharp,

  /// Softly rounded corners (the kit's `radii.md` scale, 8 dp).
  smooth,
}
