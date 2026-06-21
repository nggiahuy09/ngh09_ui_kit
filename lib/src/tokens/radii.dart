/// Primitive border-radius scale.
///
/// Low-level tokens; consumed by the semantic theme layer (`AppRadii`).
abstract final class RadiusTokens {
  /// No rounding.
  static const double none = 0;

  /// Small radius (4px).
  static const double sm = 4;

  /// Medium radius (8px).
  static const double md = 8;

  /// Large radius (16px).
  static const double lg = 16;

  /// Fully rounded (pill / circle).
  static const double full = 9999;
}
