import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/spacing.dart';

/// Semantic spacing scale exposed as a [ThemeExtension].
///
/// Accessed via `context.spacing`. Maps to primitive [SpacingTokens].
@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  /// Creates a spacing set.
  const AppSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  /// The default spacing scale.
  const AppSpacing.standard()
    : xs = SpacingTokens.xs,
      sm = SpacingTokens.sm,
      md = SpacingTokens.md,
      lg = SpacingTokens.lg,
      xl = SpacingTokens.xl;

  /// Extra-small spacing.
  final double xs;

  /// Small spacing.
  final double sm;

  /// Medium spacing (the default unit).
  final double md;

  /// Large spacing.
  final double lg;

  /// Extra-large spacing.
  final double xl;

  @override
  AppSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return AppSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing(
      xs: lerpDouble(xs, other.xs, t),
      sm: lerpDouble(sm, other.sm, t),
      md: lerpDouble(md, other.md, t),
      lg: lerpDouble(lg, other.lg, t),
      xl: lerpDouble(xl, other.xl, t),
    );
  }

  /// Linearly interpolates between two doubles (spacing never animates `null`).
  static double lerpDouble(double a, double b, double t) => a + (b - a) * t;
}
