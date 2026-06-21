/// Primitive spacing scale based on a 4pt grid.
///
/// Low-level tokens; widgets should read spacing from the semantic theme layer
/// (`AppSpacing`) rather than these constants directly.
abstract final class SpacingTokens {
  /// 4 logical pixels.
  static const double xs = 4;

  /// 8 logical pixels.
  static const double sm = 8;

  /// 16 logical pixels.
  static const double md = 16;

  /// 24 logical pixels.
  static const double lg = 24;

  /// 32 logical pixels.
  static const double xl = 32;
}
