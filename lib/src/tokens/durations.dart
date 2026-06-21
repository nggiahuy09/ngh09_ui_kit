/// Primitive animation duration and curve tokens.
///
/// Low-level tokens consumed by components and the theme layer.
abstract final class DurationTokens {
  /// Fast transitions (e.g. ripples, small state changes).
  static const Duration fast = Duration(milliseconds: 150);

  /// Default transition duration.
  static const Duration normal = Duration(milliseconds: 250);

  /// Slow transitions (e.g. large surfaces, page transitions).
  static const Duration slow = Duration(milliseconds: 400);
}
