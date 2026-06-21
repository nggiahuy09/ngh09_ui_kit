import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/theme/app_colors.dart';
import 'package:ngh09_ui_kit/src/theme/app_radii.dart';
import 'package:ngh09_ui_kit/src/theme/app_spacing.dart';
import 'package:ngh09_ui_kit/src/theme/app_typography.dart';

/// Entry point for building the UI kit's [ThemeData].
///
/// Wraps Material 3 and attaches the kit's semantic [ThemeExtension]s
/// ([AppColors], [AppSpacing], [AppRadii], [AppTypography]) so components can
/// read tokens via `context.colors`, `context.spacing`, etc. The semantic
/// colors and typography are also projected onto the underlying Material
/// [ColorScheme] and [TextTheme] so built-in Material widgets stay consistent.
abstract final class AppTheme {
  /// Builds the light [ThemeData] for the UI kit.
  ///
  /// Pass a custom [colors]/[typography] to brand the kit; the defaults are
  /// [AppColors.light] and [AppTypography.standard].
  static ThemeData light({
    AppColors colors = const AppColors.light(),
    AppTypography typography = const AppTypography.standard(),
  }) => _build(colors: colors, typography: typography);

  /// Builds the dark [ThemeData] for the UI kit.
  static ThemeData dark({
    AppColors colors = const AppColors.dark(),
    AppTypography typography = const AppTypography.standard(),
  }) => _build(colors: colors, typography: typography);

  static ThemeData _build({
    required AppColors colors,
    required AppTypography typography,
  }) {
    const spacing = AppSpacing.standard();
    const radii = AppRadii.standard();
    final colorScheme = colors.toColorScheme();
    final textTheme = typography.toTextTheme();

    final base = ThemeData(
      useMaterial3: true,
      brightness: colors.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.background,
    );

    return base.copyWith(
      extensions: <ThemeExtension<dynamic>>[
        colors,
        spacing,
        radii,
        typography,
      ],
    );
  }
}
