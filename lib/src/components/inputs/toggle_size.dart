/// The size of a `GHAppToggle`, controlling track and thumb dimensions.
///
/// Matches the three toggle sizes in the Finesse UI Kit:
///
/// | Finesse name | Dart value | Track      | Thumb |
/// |--------------|------------|------------|-------|
/// | Small        | [small]    | 36 × 20 dp | 16 dp |
/// | Medium       | [medium]   | 44 × 24 dp | 20 dp |
/// | Large        | [large]    | 52 × 32 dp | 24 dp |
enum ToggleSize {
  /// Small toggle — 36 × 20 dp track, 16 dp thumb.
  small,

  /// Medium toggle — 44 × 24 dp track, 20 dp thumb.
  medium,

  /// Large toggle — 52 × 32 dp track, 24 dp thumb.
  large,
}
