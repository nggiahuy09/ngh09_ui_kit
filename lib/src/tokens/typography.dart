import 'package:flutter/widgets.dart';

/// Primitive typography tokens — raw font sizes, weights and line heights.
///
/// Low-level values consumed by the semantic theme layer (`GHAppTypography`).
/// Sizes follow the Material 3 type scale (display → label).
abstract final class TypographyTokens {
  /// Default font family. `null` uses the platform default (Roboto on Android,
  /// SF on iOS), which keeps the package asset-free.
  static const String? fontFamily = null;

  // Font weights ------------------------------------------------------------

  /// Regular weight (400).
  static const FontWeight regular = FontWeight.w400;

  /// Medium weight (500).
  static const FontWeight medium = FontWeight.w500;

  /// Semi-bold weight (600).
  static const FontWeight semiBold = FontWeight.w600;

  /// Bold weight (700).
  static const FontWeight bold = FontWeight.w700;

  // Font sizes (Material 3 type scale, logical px) --------------------------

  /// Display large (57px).
  static const double sizeDisplayLarge = 57;

  /// Display medium (45px).
  static const double sizeDisplayMedium = 45;

  /// Display small (36px).
  static const double sizeDisplaySmall = 36;

  /// Headline large (32px).
  static const double sizeHeadlineLarge = 32;

  /// Headline medium (28px).
  static const double sizeHeadlineMedium = 28;

  /// Headline small (24px).
  static const double sizeHeadlineSmall = 24;

  /// Title large (22px).
  static const double sizeTitleLarge = 22;

  /// Title medium (16px).
  static const double sizeTitleMedium = 16;

  /// Title small (14px).
  static const double sizeTitleSmall = 14;

  /// Body large (16px).
  static const double sizeBodyLarge = 16;

  /// Body medium (14px).
  static const double sizeBodyMedium = 14;

  /// Body small (12px).
  static const double sizeBodySmall = 12;

  /// Label large (14px).
  static const double sizeLabelLarge = 14;

  /// Label medium (12px).
  static const double sizeLabelMedium = 12;

  /// Label small (11px).
  static const double sizeLabelSmall = 11;

  // Line heights (as multipliers of font size) ------------------------------

  /// Tight line height for large display text.
  static const double heightTight = 1.15;

  /// Standard line height for headings and titles.
  static const double heightSnug = 1.3;

  /// Relaxed line height for body copy.
  static const double heightRelaxed = 1.45;
}
