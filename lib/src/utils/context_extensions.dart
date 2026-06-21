import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/theme/app_colors.dart';
import 'package:ngh09_ui_kit/src/theme/app_radii.dart';
import 'package:ngh09_ui_kit/src/theme/app_spacing.dart';
import 'package:ngh09_ui_kit/src/theme/app_typography.dart';

/// Convenience accessors for the UI kit's theme extensions.
///
/// These let components read semantic tokens without verbose
/// `Theme.of(context).extension<...>()!` calls:
///
/// ```dart
/// Container(color: context.colors.background);
/// SizedBox(height: context.spacing.md);
/// ```
extension AppThemeContext on BuildContext {
  /// The semantic color set for the current theme.
  AppColors get colors => Theme.of(this).extension<AppColors>()!;

  /// The semantic spacing scale for the current theme.
  AppSpacing get spacing => Theme.of(this).extension<AppSpacing>()!;

  /// The semantic radius scale for the current theme.
  AppRadii get radii => Theme.of(this).extension<AppRadii>()!;

  /// The semantic text styles for the current theme.
  AppTypography get textStyles => Theme.of(this).extension<AppTypography>()!;
}
