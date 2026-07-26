/// The size of a `GHTooltip`, controlling its text scale, padding and icon
/// size.
///
/// Matches the three sizes in the Finesse UI Kit "Tooltips" component set:
///
/// | Finesse name | Dart value | Text  | Icon  |
/// |--------------|------------|-------|-------|
/// | Small        | [small]    | 12 dp | 12 dp |
/// | Medium       | [medium]   | 14 dp | 14 dp |
/// | Large        | [large]    | 16 dp | 16 dp |
enum TooltipSize {
  /// Small tooltip — 12 dp text. The default.
  small,

  /// Medium tooltip — 14 dp text.
  medium,

  /// Large tooltip — 16 dp text.
  large,
}
