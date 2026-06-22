import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/typography.dart';

/// Semantic text styles exposed as a [ThemeExtension].
///
/// Accessed via `context.textStyles`. Maps primitive [TypographyTokens] onto
/// the Material 3 type roles (display → label). Components reference these
/// roles instead of hardcoding sizes/weights.
@immutable
class GHAppTypography extends ThemeExtension<GHAppTypography> {
  /// Creates a typography set.
  const GHAppTypography({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  /// The default typography scale — the Finesse type scale mapped onto the
  /// Material type-role names. Each role binds the Inter family, its Finesse
  /// font size, a per-role `height` (line-height px ÷ font size) and letter
  /// spacing. Weights are retained per role (the Finesse design does not
  /// annotate weight per step). See `figma/typography.md`.
  const GHAppTypography.standard()
    : displayLarge = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeDisplayLarge,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.lineHeightDisplayLarge / TypographyTokens.sizeDisplayLarge,
        letterSpacing: TypographyTokens.letterSpacingDisplayLarge,
      ),
      displayMedium = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeDisplayMedium,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.lineHeightDisplayMedium / TypographyTokens.sizeDisplayMedium,
        letterSpacing: TypographyTokens.letterSpacingDisplayMedium,
      ),
      displaySmall = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeDisplaySmall,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.lineHeightDisplaySmall / TypographyTokens.sizeDisplaySmall,
        letterSpacing: TypographyTokens.letterSpacingDisplaySmall,
      ),
      headlineLarge = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeHeadlineLarge,
        fontWeight: TypographyTokens.semiBold,
        height: TypographyTokens.lineHeightHeadlineLarge / TypographyTokens.sizeHeadlineLarge,
        letterSpacing: TypographyTokens.letterSpacingHeadlineLarge,
      ),
      headlineMedium = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeHeadlineMedium,
        fontWeight: TypographyTokens.semiBold,
        height: TypographyTokens.lineHeightHeadlineMedium / TypographyTokens.sizeHeadlineMedium,
        letterSpacing: TypographyTokens.letterSpacingHeadlineMedium,
      ),
      headlineSmall = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeHeadlineSmall,
        fontWeight: TypographyTokens.semiBold,
        height: TypographyTokens.lineHeightHeadlineSmall / TypographyTokens.sizeHeadlineSmall,
        letterSpacing: TypographyTokens.letterSpacingHeadlineSmall,
      ),
      titleLarge = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeTitleLarge,
        fontWeight: TypographyTokens.semiBold,
        height: TypographyTokens.lineHeightTitleLarge / TypographyTokens.sizeTitleLarge,
        letterSpacing: TypographyTokens.letterSpacingTitleLarge,
      ),
      titleMedium = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeTitleMedium,
        fontWeight: TypographyTokens.medium,
        height: TypographyTokens.lineHeightTitleMedium / TypographyTokens.sizeTitleMedium,
        letterSpacing: TypographyTokens.letterSpacingTitleMedium,
      ),
      titleSmall = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeTitleSmall,
        fontWeight: TypographyTokens.medium,
        height: TypographyTokens.lineHeightTitleSmall / TypographyTokens.sizeTitleSmall,
        letterSpacing: TypographyTokens.letterSpacingTitleSmall,
      ),
      bodyLarge = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeBodyLarge,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.lineHeightBodyLarge / TypographyTokens.sizeBodyLarge,
        letterSpacing: TypographyTokens.letterSpacingBodyLarge,
      ),
      bodyMedium = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeBodyMedium,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.lineHeightBodyMedium / TypographyTokens.sizeBodyMedium,
        letterSpacing: TypographyTokens.letterSpacingBodyMedium,
      ),
      bodySmall = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeBodySmall,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.lineHeightBodySmall / TypographyTokens.sizeBodySmall,
        letterSpacing: TypographyTokens.letterSpacingBodySmall,
      ),
      labelLarge = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeLabelLarge,
        fontWeight: TypographyTokens.medium,
        height: TypographyTokens.lineHeightLabelLarge / TypographyTokens.sizeLabelLarge,
        letterSpacing: TypographyTokens.letterSpacingLabelLarge,
      ),
      labelMedium = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeLabelMedium,
        fontWeight: TypographyTokens.medium,
        height: TypographyTokens.lineHeightLabelMedium / TypographyTokens.sizeLabelMedium,
        letterSpacing: TypographyTokens.letterSpacingLabelMedium,
      ),
      labelSmall = const TextStyle(
        fontFamily: TypographyTokens.fontFamily,
        fontSize: TypographyTokens.sizeLabelSmall,
        fontWeight: TypographyTokens.medium,
        height: TypographyTokens.lineHeightLabelSmall / TypographyTokens.sizeLabelSmall,
        letterSpacing: TypographyTokens.letterSpacingLabelSmall,
      );

  /// Largest display style — hero headings.
  final TextStyle displayLarge;

  /// Medium display style.
  final TextStyle displayMedium;

  /// Small display style.
  final TextStyle displaySmall;

  /// Large headline style.
  final TextStyle headlineLarge;

  /// Medium headline style.
  final TextStyle headlineMedium;

  /// Small headline style.
  final TextStyle headlineSmall;

  /// Large title style — prominent section/app-bar titles.
  final TextStyle titleLarge;

  /// Medium title style.
  final TextStyle titleMedium;

  /// Small title style.
  final TextStyle titleSmall;

  /// Large body style — default reading text.
  final TextStyle bodyLarge;

  /// Medium body style.
  final TextStyle bodyMedium;

  /// Small body style — captions and footnotes.
  final TextStyle bodySmall;

  /// Large label style — button text.
  final TextStyle labelLarge;

  /// Medium label style.
  final TextStyle labelMedium;

  /// Small label style — overlines and tiny annotations.
  final TextStyle labelSmall;

  /// Builds a Material [TextTheme] from these semantic styles, so built-in
  /// Material widgets inherit the same type scale.
  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }

  @override
  GHAppTypography copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) {
    return GHAppTypography(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }

  @override
  GHAppTypography lerp(ThemeExtension<GHAppTypography>? other, double t) {
    if (other is! GHAppTypography) return this;
    return GHAppTypography(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
    );
  }
}
