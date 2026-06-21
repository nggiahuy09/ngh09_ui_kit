import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/typography.dart';

/// Semantic text styles exposed as a [ThemeExtension].
///
/// Accessed via `context.textStyles`. Maps to primitive [TypographyTokens].
@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  /// Creates a typography set.
  const AppTypography({
    required this.body,
    required this.title,
    required this.display,
  });

  /// The default typography scale.
  const AppTypography.standard()
    : body = const TextStyle(
        fontSize: TypographyTokens.sizeBody,
        fontWeight: FontWeight.w400,
      ),
      title = const TextStyle(
        fontSize: TypographyTokens.sizeTitle,
        fontWeight: FontWeight.w600,
      ),
      display = const TextStyle(
        fontSize: TypographyTokens.sizeDisplay,
        fontWeight: FontWeight.w700,
      );

  /// Body text style.
  final TextStyle body;

  /// Title text style.
  final TextStyle title;

  /// Display (largest) text style.
  final TextStyle display;

  @override
  AppTypography copyWith({
    TextStyle? body,
    TextStyle? title,
    TextStyle? display,
  }) {
    return AppTypography(
      body: body ?? this.body,
      title: title ?? this.title,
      display: display ?? this.display,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;
    return AppTypography(
      body: TextStyle.lerp(body, other.body, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      display: TextStyle.lerp(display, other.display, t)!,
    );
  }
}
