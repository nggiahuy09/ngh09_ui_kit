/// The size of a `GHAppBadge`, controlling height, padding, gap and label
/// style.
///
/// Matches the three sizes in the Finesse UI Kit "Badges" component set:
///
/// | Finesse name | Dart value | Height | H-pad | V-pad | Gap |
/// |--------------|------------|--------|-------|-------|-----|
/// | Small        | [small]    | 22 dp  | 8 dp  | 2 dp  | 4 dp|
/// | Medium       | [medium]   | 26 dp  | 9 dp  | 3 dp  | 5 dp|
/// | Large        | [large]    | 32 dp  | 10 dp | 4 dp  | 6 dp|
enum BadgeSize {
  /// Small badge — 22 dp tall. For dense layouts.
  small,

  /// Default badge size — 26 dp tall.
  medium,

  /// Large badge — 32 dp tall.
  large,
}
