/// The corner-radius shape of a `GHAppSegmentedControl`.
///
/// Matches the two corner styles documented in the Finesse UI Kit. The
/// radius (when [smooth]) applies only to the outer corners of the leading
/// and trailing segments — internal seams between segments stay square.
enum SegmentedControlCorner {
  /// Square corners — no rounding.
  sharp,

  /// Rounded outer corners (8dp, the kit's `radii.md` scale).
  smooth,
}
