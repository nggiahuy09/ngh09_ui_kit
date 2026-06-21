import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/typography.dart';

/// Semantic text styles exposed as a [ThemeExtension].
///
/// Accessed via `context.textStyles`. Maps primitive [TypographyTokens] onto
/// the Material 3 type roles (display → label). Components reference these
/// roles instead of hardcoding sizes/weights.
@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  /// Creates a typography set.
  const AppTypography({
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

  /// The default typography scale (Material 3 type roles).
  const AppTypography.standard()
    : displayLarge = const TextStyle(
        fontSize: TypographyTokens.sizeDisplayLarge,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.heightTight,
      ),
      displayMedium = const TextStyle(
        fontSize: TypographyTokens.sizeDisplayMedium,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.heightTight,
      ),
      displaySmall = const TextStyle(
        fontSize: TypographyTokens.sizeDisplaySmall,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.heightTight,
      ),
      headlineLarge = const TextStyle(
        fontSize: TypographyTokens.sizeHeadlineLarge,
        fontWeight: TypographyTokens.semiBold,
        height: TypographyTokens.heightSnug,
      ),
      headlineMedium = const TextStyle(
        fontSize: TypographyTokens.sizeHeadlineMedium,
        fontWeight: TypographyTokens.semiBold,
        height: TypographyTokens.heightSnug,
      ),
      headlineSmall = const TextStyle(
        fontSize: TypographyTokens.sizeHeadlineSmall,
        fontWeight: TypographyTokens.semiBold,
        height: TypographyTokens.heightSnug,
      ),
      titleLarge = const TextStyle(
        fontSize: TypographyTokens.sizeTitleLarge,
        fontWeight: TypographyTokens.semiBold,
        height: TypographyTokens.heightSnug,
      ),
      titleMedium = const TextStyle(
        fontSize: TypographyTokens.sizeTitleMedium,
        fontWeight: TypographyTokens.medium,
        height: TypographyTokens.heightSnug,
      ),
      titleSmall = const TextStyle(
        fontSize: TypographyTokens.sizeTitleSmall,
        fontWeight: TypographyTokens.medium,
        height: TypographyTokens.heightSnug,
      ),
      bodyLarge = const TextStyle(
        fontSize: TypographyTokens.sizeBodyLarge,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.heightRelaxed,
      ),
      bodyMedium = const TextStyle(
        fontSize: TypographyTokens.sizeBodyMedium,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.heightRelaxed,
      ),
      bodySmall = const TextStyle(
        fontSize: TypographyTokens.sizeBodySmall,
        fontWeight: TypographyTokens.regular,
        height: TypographyTokens.heightRelaxed,
      ),
      labelLarge = const TextStyle(
        fontSize: TypographyTokens.sizeLabelLarge,
        fontWeight: TypographyTokens.medium,
        height: TypographyTokens.heightSnug,
      ),
      labelMedium = const TextStyle(
        fontSize: TypographyTokens.sizeLabelMedium,
        fontWeight: TypographyTokens.medium,
        height: TypographyTokens.heightSnug,
      ),
      labelSmall = const TextStyle(
        fontSize: TypographyTokens.sizeLabelSmall,
        fontWeight: TypographyTokens.medium,
        height: TypographyTokens.heightSnug,
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
  AppTypography copyWith({
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
    return AppTypography(
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
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;
    return AppTypography(
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
