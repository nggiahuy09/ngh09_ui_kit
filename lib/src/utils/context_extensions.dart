import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/theme/app_colors.dart';
import 'package:ngh09_ui_kit/src/theme/app_radii.dart';
import 'package:ngh09_ui_kit/src/theme/app_spacing.dart';
import 'package:ngh09_ui_kit/src/theme/app_typography.dart';
import 'package:ngh09_ui_kit/src/tokens/breakpoints.dart';

/// Convenience accessors for the UI kit's theme extensions and common
/// `MediaQuery`/`Theme` lookups.
///
/// These let components read semantic tokens without verbose
/// `Theme.of(context).extension<...>()!` calls:
///
/// ```dart
/// Container(color: context.colors.surface);
/// SizedBox(height: context.spacing.md);
/// Text('Hi', style: context.textStyles.titleLarge);
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

  /// Whether the active theme is dark.
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

/// Shortcuts for layout-related `MediaQuery` values and responsive checks.
extension AppMediaQueryContext on BuildContext {
  /// The current logical screen size.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// The current logical screen width.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// The current logical screen height.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Whether the layout is in the mobile range (width < tablet breakpoint).
  bool get isMobile => screenWidth < BreakpointTokens.mobile;

  /// Whether the layout is in the tablet range
  /// (mobile breakpoint ≤ width < tablet breakpoint).
  bool get isTablet =>
      screenWidth >= BreakpointTokens.mobile &&
      screenWidth < BreakpointTokens.tablet;

  /// Whether the layout is in the desktop range (width ≥ tablet breakpoint).
  bool get isDesktop => screenWidth >= BreakpointTokens.tablet;
}
