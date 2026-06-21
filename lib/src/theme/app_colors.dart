import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';

/// Semantic color roles for the UI kit, exposed as a [ThemeExtension].
///
/// Components read colors from here (via `context.colors`) instead of using
/// primitive [ColorTokens] directly, so re-theming touches only one place.
///
/// This is a foundation stub; the full palette is defined in Phase A.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  /// Creates a semantic color set.
  const AppColors({
    required this.background,
    required this.onBackground,
  });

  /// Default light color set.
  const AppColors.light()
    : background = ColorTokens.white,
      onBackground = ColorTokens.black;

  /// Default dark color set.
  const AppColors.dark()
    : background = ColorTokens.black,
      onBackground = ColorTokens.white;

  /// Base background surface color.
  final Color background;

  /// Color for content drawn on top of [background].
  final Color onBackground;

  @override
  AppColors copyWith({Color? background, Color? onBackground}) {
    return AppColors(
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
    );
  }
}
