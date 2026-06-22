/// Primitive spacing scale based on a 4pt grid.
///
/// Low-level tokens; widgets should read spacing from the semantic theme layer
/// (`GHAppSpacing`, via `context.spacing`) rather than these constants
/// directly.
abstract final class SpacingTokens {
  /// 0 logical pixels — no spacing.
  static const double none = 0;

  /// 2 logical pixels.
  static const double xxs = 2;

  /// 4 logical pixels.
  static const double xs = 4;

  /// 8 logical pixels.
  static const double sm = 8;

  /// 12 logical pixels.
  static const double smd = 12;

  /// 16 logical pixels (the default unit).
  static const double md = 16;

  /// 24 logical pixels.
  static const double lg = 24;

  /// 32 logical pixels.
  static const double xl = 32;

  /// 48 logical pixels.
  static const double xxl = 48;

  /// 64 logical pixels.
  static const double xxxl = 64;
}
