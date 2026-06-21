import 'package:flutter/widgets.dart';

/// Primitive color palette (raw, non-semantic values).
///
/// These are the lowest-level tokens: fixed hues with no meaning attached.
/// Do **not** consume them directly in widgets — use the semantic theme layer
/// (`AppColors`, via `context.colors`) instead, so re-theming touches one spot.
///
/// Each hue is provided as a 50–900 ramp following the Material tonal model.
abstract final class ColorTokens {
  /// Pure white.
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black.
  static const Color black = Color(0xFF000000);

  /// Fully transparent.
  static const Color transparent = Color(0x00000000);

  // ---------------------------------------------------------------------------
  // Brand (indigo) — the primary accent ramp.
  // ---------------------------------------------------------------------------

  /// Brand 50 — lightest tint.
  static const Color brand50 = Color(0xFFEEF0FF);

  /// Brand 100.
  static const Color brand100 = Color(0xFFD9DEFF);

  /// Brand 200.
  static const Color brand200 = Color(0xFFB3BCFF);

  /// Brand 300.
  static const Color brand300 = Color(0xFF8A97FB);

  /// Brand 400.
  static const Color brand400 = Color(0xFF6675F2);

  /// Brand 500 — the base brand color.
  static const Color brand500 = Color(0xFF4754E0);

  /// Brand 600.
  static const Color brand600 = Color(0xFF3641C2);

  /// Brand 700.
  static const Color brand700 = Color(0xFF2A3399);

  /// Brand 800.
  static const Color brand800 = Color(0xFF1F2670);

  /// Brand 900 — darkest shade.
  static const Color brand900 = Color(0xFF141A4D);

  // ---------------------------------------------------------------------------
  // Neutral (slate-gray) — surfaces, text, borders.
  // ---------------------------------------------------------------------------

  /// Neutral 0 — white surface.
  static const Color neutral0 = Color(0xFFFFFFFF);

  /// Neutral 50.
  static const Color neutral50 = Color(0xFFF7F8FA);

  /// Neutral 100.
  static const Color neutral100 = Color(0xFFEDEFF3);

  /// Neutral 200.
  static const Color neutral200 = Color(0xFFD9DDE5);

  /// Neutral 300.
  static const Color neutral300 = Color(0xFFBFC5D2);

  /// Neutral 400.
  static const Color neutral400 = Color(0xFF98A1B3);

  /// Neutral 500.
  static const Color neutral500 = Color(0xFF6B7384);

  /// Neutral 600.
  static const Color neutral600 = Color(0xFF4D5462);

  /// Neutral 700.
  static const Color neutral700 = Color(0xFF373D49);

  /// Neutral 800.
  static const Color neutral800 = Color(0xFF22272F);

  /// Neutral 900 — near-black surface.
  static const Color neutral900 = Color(0xFF13161B);

  // ---------------------------------------------------------------------------
  // Semantic status ramps — success / warning / danger / info.
  // ---------------------------------------------------------------------------

  /// Success 50.
  static const Color success50 = Color(0xFFE7F8EF);

  /// Success 500 — base success color.
  static const Color success500 = Color(0xFF1FA463);

  /// Success 700.
  static const Color success700 = Color(0xFF137045);

  /// Warning 50.
  static const Color warning50 = Color(0xFFFFF6E5);

  /// Warning 500 — base warning color.
  static const Color warning500 = Color(0xFFE0962E);

  /// Warning 700.
  static const Color warning700 = Color(0xFF98631A);

  /// Danger 50.
  static const Color danger50 = Color(0xFFFDEBEC);

  /// Danger 500 — base danger/error color.
  static const Color danger500 = Color(0xFFDC3545);

  /// Danger 700.
  static const Color danger700 = Color(0xFF98232E);

  /// Info 50.
  static const Color info50 = Color(0xFFE6F4FB);

  /// Info 500 — base informational color.
  static const Color info500 = Color(0xFF2196C3);

  /// Info 700.
  static const Color info700 = Color(0xFF166585);
}
