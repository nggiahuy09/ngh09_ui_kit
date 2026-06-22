import 'package:flutter/widgets.dart';

/// Primitive typography tokens — raw font sizes, weights, line heights and
/// letter spacing.
///
/// Low-level values consumed by the semantic theme layer (`GHAppTypography`).
/// Sizes follow the **Finesse UI Kit** type scale (Titles → Headings → Body),
/// projected onto the Material type-role names that the semantic layer exposes.
/// See `figma/typography.md` for the source design and the role mapping.
abstract final class TypographyTokens {
  /// Default font family. The Finesse design system is built on **Inter**;
  /// the static weights are bundled under `assets/fonts/` (see `pubspec.yaml`).
  static const String fontFamily = 'Inter';

  // Font weights ------------------------------------------------------------

  /// Regular weight (400).
  static const FontWeight regular = FontWeight.w400;

  /// Medium weight (500).
  static const FontWeight medium = FontWeight.w500;

  /// Semi-bold weight (600).
  static const FontWeight semiBold = FontWeight.w600;

  /// Bold weight (700).
  static const FontWeight bold = FontWeight.w700;

  // Font sizes (Finesse scale, logical px) ----------------------------------
  // Role ← Finesse step:
  //   display* ← Titles/Large, Titles/Small, Headings/Huge
  //   headline* ← Headings/Extra Large, Large, Medium
  //   title* ← Headings/Small, Extra Small, Body/Extra Large
  //   body* ← Body/Large, Medium, Small
  //   label* ← Body/Small (reused), Extra Small, Tiny

  /// Display large — Finesse Titles/Large (120px).
  static const double sizeDisplayLarge = 120;

  /// Display medium — Finesse Titles/Small (96px).
  static const double sizeDisplayMedium = 96;

  /// Display small — Finesse Headings/Huge (72px).
  static const double sizeDisplaySmall = 72;

  /// Headline large — Finesse Headings/Extra Large (60px).
  static const double sizeHeadlineLarge = 60;

  /// Headline medium — Finesse Headings/Large (48px).
  static const double sizeHeadlineMedium = 48;

  /// Headline small — Finesse Headings/Medium (36px).
  static const double sizeHeadlineSmall = 36;

  /// Title large — Finesse Headings/Small (30px).
  static const double sizeTitleLarge = 30;

  /// Title medium — Finesse Headings/Extra Small (24px).
  static const double sizeTitleMedium = 24;

  /// Title small — Finesse Body/Extra Large (20px).
  static const double sizeTitleSmall = 20;

  /// Body large — Finesse Body/Large (18px).
  static const double sizeBodyLarge = 18;

  /// Body medium — Finesse Body/Medium (16px).
  static const double sizeBodyMedium = 16;

  /// Body small — Finesse Body/Small (14px).
  static const double sizeBodySmall = 14;

  /// Label large — Finesse Body/Small (14px).
  static const double sizeLabelLarge = 14;

  /// Label medium — Finesse Body/Extra Small (12px).
  static const double sizeLabelMedium = 12;

  /// Label small — Finesse Body/Tiny (10px).
  static const double sizeLabelSmall = 10;

  // Line heights (absolute logical px, matching Finesse "Line Spacing") ------
  // The semantic layer divides these by the matching font size to derive
  // Flutter's `TextStyle.height` multiplier.

  /// Display large line height (150px).
  static const double lineHeightDisplayLarge = 150;

  /// Display medium line height (120px).
  static const double lineHeightDisplayMedium = 120;

  /// Display small line height (90px).
  static const double lineHeightDisplaySmall = 90;

  /// Headline large line height (72px).
  static const double lineHeightHeadlineLarge = 72;

  /// Headline medium line height (60px).
  static const double lineHeightHeadlineMedium = 60;

  /// Headline small line height (44px).
  static const double lineHeightHeadlineSmall = 44;

  /// Title large line height (38px).
  static const double lineHeightTitleLarge = 38;

  /// Title medium line height (32px).
  static const double lineHeightTitleMedium = 32;

  /// Title small line height (30px).
  static const double lineHeightTitleSmall = 30;

  /// Body large line height (28px).
  static const double lineHeightBodyLarge = 28;

  /// Body medium line height (24px).
  static const double lineHeightBodyMedium = 24;

  /// Body small line height (20px).
  static const double lineHeightBodySmall = 20;

  /// Label large line height (20px).
  static const double lineHeightLabelLarge = 20;

  /// Label medium line height (18px).
  static const double lineHeightLabelMedium = 18;

  /// Label small line height (16px).
  static const double lineHeightLabelSmall = 16;

  // Height multipliers (line height ÷ font size) ----------------------------
  // Derived from the absolute line heights above; this is what Flutter's
  // `TextStyle.height` expects. Kept as named constants so the semantic layer
  // stays terse (one short token per role).

  /// Display large height multiplier (150 ÷ 120).
  static const double heightDisplayLarge =
      lineHeightDisplayLarge / sizeDisplayLarge;

  /// Display medium height multiplier (120 ÷ 96).
  static const double heightDisplayMedium =
      lineHeightDisplayMedium / sizeDisplayMedium;

  /// Display small height multiplier (90 ÷ 72).
  static const double heightDisplaySmall =
      lineHeightDisplaySmall / sizeDisplaySmall;

  /// Headline large height multiplier (72 ÷ 60).
  static const double heightHeadlineLarge =
      lineHeightHeadlineLarge / sizeHeadlineLarge;

  /// Headline medium height multiplier (60 ÷ 48).
  static const double heightHeadlineMedium =
      lineHeightHeadlineMedium / sizeHeadlineMedium;

  /// Headline small height multiplier (44 ÷ 36).
  static const double heightHeadlineSmall =
      lineHeightHeadlineSmall / sizeHeadlineSmall;

  /// Title large height multiplier (38 ÷ 30).
  static const double heightTitleLarge =
      lineHeightTitleLarge / sizeTitleLarge;

  /// Title medium height multiplier (32 ÷ 24).
  static const double heightTitleMedium =
      lineHeightTitleMedium / sizeTitleMedium;

  /// Title small height multiplier (30 ÷ 20).
  static const double heightTitleSmall =
      lineHeightTitleSmall / sizeTitleSmall;

  /// Body large height multiplier (28 ÷ 18).
  static const double heightBodyLarge = lineHeightBodyLarge / sizeBodyLarge;

  /// Body medium height multiplier (24 ÷ 16).
  static const double heightBodyMedium =
      lineHeightBodyMedium / sizeBodyMedium;

  /// Body small height multiplier (20 ÷ 14).
  static const double heightBodySmall = lineHeightBodySmall / sizeBodySmall;

  /// Label large height multiplier (20 ÷ 14).
  static const double heightLabelLarge =
      lineHeightLabelLarge / sizeLabelLarge;

  /// Label medium height multiplier (18 ÷ 12).
  static const double heightLabelMedium =
      lineHeightLabelMedium / sizeLabelMedium;

  /// Label small height multiplier (16 ÷ 10).
  static const double heightLabelSmall =
      lineHeightLabelSmall / sizeLabelSmall;

  // Letter spacing (logical px) ---------------------------------------------
  // Finesse applies -2% tracking to the larger steps (≥36px) and 0 elsewhere.
  // Resolved px = fontSize * -0.02.

  /// Display large letter spacing (-2.40px).
  static const double letterSpacingDisplayLarge = -2.40;

  /// Display medium letter spacing (-1.92px).
  static const double letterSpacingDisplayMedium = -1.92;

  /// Display small letter spacing (-1.44px).
  static const double letterSpacingDisplaySmall = -1.44;

  /// Headline large letter spacing (-1.20px).
  static const double letterSpacingHeadlineLarge = -1.20;

  /// Headline medium letter spacing (-0.96px).
  static const double letterSpacingHeadlineMedium = -0.96;

  /// Headline small letter spacing (-0.72px).
  static const double letterSpacingHeadlineSmall = -0.72;

  /// Title large letter spacing (0px).
  static const double letterSpacingTitleLarge = 0;

  /// Title medium letter spacing (0px).
  static const double letterSpacingTitleMedium = 0;

  /// Title small letter spacing (0px).
  static const double letterSpacingTitleSmall = 0;

  /// Body large letter spacing (0px).
  static const double letterSpacingBodyLarge = 0;

  /// Body medium letter spacing (0px).
  static const double letterSpacingBodyMedium = 0;

  /// Body small letter spacing (0px).
  static const double letterSpacingBodySmall = 0;

  /// Label large letter spacing (0px).
  static const double letterSpacingLabelLarge = 0;

  /// Label medium letter spacing (0px).
  static const double letterSpacingLabelMedium = 0;

  /// Label small letter spacing (0px).
  static const double letterSpacingLabelSmall = 0;
}
