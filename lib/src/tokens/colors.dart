import 'package:flutter/widgets.dart';

/// Primitive color palette (raw, non-semantic values).
///
/// These are the lowest-level tokens: fixed hues with no meaning attached.
/// Do **not** consume them directly in widgets — use the semantic theme layer
/// (`GHAppColors`, via `context.colors`) instead, so re-theming touches one
/// spot.
///
/// Values come from the **Finesse UI Kit** color system (see `figma/colors.md`).
/// Each ramp runs 50–1000. Finesse's primary/brand is deliberately black &
/// white, so there is no colored brand ramp.
abstract final class ColorTokens {
  /// Pure white — the Finesse `Primary/White`.
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black — the Finesse `Primary/Black` (the brand/primary color).
  static const Color black = Color(0xFF000000);

  /// Fully transparent.
  static const Color transparent = Color(0x00000000);

  // ---------------------------------------------------------------------------
  // Gray — neutral foundation (text, fields, surfaces, borders, dividers).
  // ---------------------------------------------------------------------------

  /// Gray 50 — lightest neutral.
  static const Color gray50 = Color(0xFFFAFAFA);

  /// Gray 100.
  static const Color gray100 = Color(0xFFF6F7F9);

  /// Gray 200.
  static const Color gray200 = Color(0xFFE5E7EA);

  /// Gray 300.
  static const Color gray300 = Color(0xFFCED2D6);

  /// Gray 400.
  static const Color gray400 = Color(0xFF9EA5AD);

  /// Gray 500 — mid neutral.
  static const Color gray500 = Color(0xFF676E76);

  /// Gray 600.
  static const Color gray600 = Color(0xFF596066);

  /// Gray 700.
  static const Color gray700 = Color(0xFF454C52);

  /// Gray 800.
  static const Color gray800 = Color(0xFF383F45);

  /// Gray 900.
  static const Color gray900 = Color(0xFF24292E);

  /// Gray 1000 — darkest neutral.
  static const Color gray1000 = Color(0xFF1A1D1F);

  // ---------------------------------------------------------------------------
  // Error — red (destructive / negative states).
  // ---------------------------------------------------------------------------

  // TODO(colors): Error/50 is #FAFAFA (a neutral gray) in the Finesse free kit
  // rather than a pale red — likely a design slip. Captured verbatim; confirm
  // with design whether it should be a light red.
  /// Error 50 — see TODO above (captured as a neutral gray).
  static const Color error50 = Color(0xFFFAFAFA);

  /// Error 100.
  static const Color error100 = Color(0xFFFEF2F2);

  /// Error 200.
  static const Color error200 = Color(0xFFFDE9E9);

  /// Error 300.
  static const Color error300 = Color(0xFFFAC7C7);

  /// Error 400.
  static const Color error400 = Color(0xFFF7A1A1);

  /// Error 500 — base error color.
  static const Color error500 = Color(0xFFF37373);

  /// Error 600.
  static const Color error600 = Color(0xFFF34141);

  /// Error 700.
  static const Color error700 = Color(0xFFCD3636);

  /// Error 800.
  static const Color error800 = Color(0xFFA32E2E);

  /// Error 900.
  static const Color error900 = Color(0xFF7C2323);

  /// Error 1000 — darkest error shade.
  static const Color error1000 = Color(0xFF601B1B);

  // ---------------------------------------------------------------------------
  // Warning — amber (caution / on-hold states).
  // ---------------------------------------------------------------------------

  /// Warning 50.
  static const Color warning50 = Color(0xFFFFFCF5);

  /// Warning 100.
  static const Color warning100 = Color(0xFFFEFAF5);

  /// Warning 200.
  static const Color warning200 = Color(0xFFFBF2CB);

  /// Warning 300.
  static const Color warning300 = Color(0xFFFDE57E);

  /// Warning 400.
  static const Color warning400 = Color(0xFFFFD16A);

  /// Warning 500 — base warning color.
  static const Color warning500 = Color(0xFFFBBC55);

  /// Warning 600.
  static const Color warning600 = Color(0xFFE9A23B);

  /// Warning 700.
  static const Color warning700 = Color(0xFFC8811A);

  /// Warning 800.
  static const Color warning800 = Color(0xFFA35C00);

  /// Warning 900.
  static const Color warning900 = Color(0xFF8B4400);

  /// Warning 1000 — darkest warning shade.
  static const Color warning1000 = Color(0xFF78310B);

  // ---------------------------------------------------------------------------
  // Success — green (positive / confirmation states).
  // ---------------------------------------------------------------------------

  /// Success 50.
  static const Color success50 = Color(0xFFF6FEF9);

  /// Success 100.
  static const Color success100 = Color(0xFFEFFDF6);

  /// Success 200.
  static const Color success200 = Color(0xFFD9F9E6);

  /// Success 300.
  static const Color success300 = Color(0xFFB8F1D2);

  /// Success 400.
  static const Color success400 = Color(0xFF8EE4BA);

  /// Success 500 — base success color.
  static const Color success500 = Color(0xFF6AD09D);

  /// Success 600.
  static const Color success600 = Color(0xFF53B483);

  /// Success 700.
  static const Color success700 = Color(0xFF2F9461);

  /// Success 800.
  static const Color success800 = Color(0xFF2F7657);

  /// Success 900.
  static const Color success900 = Color(0xFF255E46);

  /// Success 1000 — darkest success shade.
  static const Color success1000 = Color(0xFF1E4D3A);

  // ---------------------------------------------------------------------------
  // Info — LEGACY blue. NOT part of the Finesse palette; retained for
  // back-compat (e.g. `BadgeStatus.info`) during the migration. Deprecated —
  // remove once consumers no longer reference the `info` role.
  // ---------------------------------------------------------------------------

  /// Info 50 (legacy, non-Finesse).
  static const Color info50 = Color(0xFFE6F4FB);

  /// Info 500 — base informational color (legacy, non-Finesse).
  static const Color info500 = Color(0xFF2196C3);

  /// Info 700 (legacy, non-Finesse).
  static const Color info700 = Color(0xFF166585);
}
