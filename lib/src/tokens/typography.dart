/// Primitive typography tokens — raw font sizes and weights.
///
/// Low-level tokens consumed by the semantic theme layer (`AppTypography`).
abstract final class TypographyTokens {
  /// Default font family. `null` uses the platform default (Roboto on Android).
  static const String? fontFamily = null;

  /// Body text size (16px).
  static const double sizeBody = 16;

  /// Title text size (22px).
  static const double sizeTitle = 22;

  /// Display text size (36px).
  static const double sizeDisplay = 36;
}
