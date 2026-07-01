/// The corner-radius shape of a `GHAppButton`.
///
/// Mirrors the four corner variants documented in the Finesse UI Kit. The
/// default for most button use-cases is [medium] (8 px).
enum ButtonCorner {
  /// No rounding — sharp, square corners (0 px radius).
  none,

  /// Small rounding — subtle softening (4 px radius).
  small,

  /// Medium rounding — the standard Finesse button shape (8 px radius).
  medium,

  /// Fully rounded — pill / capsule shape (9 999 px radius).
  full,
}
