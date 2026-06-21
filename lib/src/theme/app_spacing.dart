import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/spacing.dart';

/// Semantic spacing scale exposed as a [ThemeExtension].
///
/// Accessed via `context.spacing`. Maps to primitive [SpacingTokens].
@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  /// Creates a spacing set.
  const AppSpacing({
    required this.xxs,
    required this.xs,
    required this.sm,
    required this.smd,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  /// The default spacing scale.
  const AppSpacing.standard()
    : xxs = SpacingTokens.xxs,
      xs = SpacingTokens.xs,
      sm = SpacingTokens.sm,
      smd = SpacingTokens.smd,
      md = SpacingTokens.md,
      lg = SpacingTokens.lg,
      xl = SpacingTokens.xl,
      xxl = SpacingTokens.xxl;

  /// Extra-extra-small spacing (2).
  final double xxs;

  /// Extra-small spacing (4).
  final double xs;

  /// Small spacing (8).
  final double sm;

  /// Small-medium spacing (12).
  final double smd;

  /// Medium spacing — the default unit (16).
  final double md;

  /// Large spacing (24).
  final double lg;

  /// Extra-large spacing (32).
  final double xl;

  /// Extra-extra-large spacing (48).
  final double xxl;

  @override
  AppSpacing copyWith({
    double? xxs,
    double? xs,
    double? sm,
    double? smd,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return AppSpacing(
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      smd: smd ?? this.smd,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing(
      xxs: lerpDouble(xxs, other.xxs, t)!,
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      smd: lerpDouble(smd, other.smd, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      xxl: lerpDouble(xxl, other.xxl, t)!,
    );
  }
}
