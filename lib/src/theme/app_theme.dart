import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/theme/app_colors.dart';
import 'package:ngh09_ui_kit/src/theme/app_radii.dart';
import 'package:ngh09_ui_kit/src/theme/app_spacing.dart';
import 'package:ngh09_ui_kit/src/theme/app_typography.dart';

/// Entry point for building the UI kit's [ThemeData].
///
/// Wraps Material 3 and attaches the kit's semantic [ThemeExtension]s
/// ([AppColors], [AppSpacing], [AppRadii], [AppTypography]) so components can
/// read tokens via `context.colors`, `context.spacing`, etc.
abstract final class AppTheme {
  /// Builds the light [ThemeData] for the UI kit.
  static ThemeData light() => _build(
    brightness: Brightness.light,
    colors: const AppColors.light(),
  );

  /// Builds the dark [ThemeData] for the UI kit.
  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    colors: const AppColors.dark(),
  );

  static ThemeData _build({
    required Brightness brightness,
    required AppColors colors,
  }) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
    );
    return base.copyWith(
      extensions: <ThemeExtension<dynamic>>[
        colors,
        const AppSpacing.standard(),
        const AppRadii.standard(),
        const AppTypography.standard(),
      ],
    );
  }
}
