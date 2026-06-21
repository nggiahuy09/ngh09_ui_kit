import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/radii.dart';

/// Semantic border-radius scale exposed as a [ThemeExtension].
///
/// Accessed via `context.radii`. Maps to primitive [RadiusTokens] and provides
/// ready-made [BorderRadius] getters for component use.
@immutable
class AppRadii extends ThemeExtension<AppRadii> {
  /// Creates a radius set.
  const AppRadii({
    required this.none,
    required this.sm,
    required this.md,
    required this.lg,
    required this.full,
  });

  /// The default radius scale.
  const AppRadii.standard()
    : none = RadiusTokens.none,
      sm = RadiusTokens.sm,
      md = RadiusTokens.md,
      lg = RadiusTokens.lg,
      full = RadiusTokens.full;

  /// No rounding.
  final double none;

  /// Small radius (4).
  final double sm;

  /// Medium radius (8).
  final double md;

  /// Large radius (16).
  final double lg;

  /// Fully rounded (pill / circle).
  final double full;

  /// [BorderRadius] for the [sm] scale.
  BorderRadius get borderRadiusSm => BorderRadius.circular(sm);

  /// [BorderRadius] for the [md] scale.
  BorderRadius get borderRadiusMd => BorderRadius.circular(md);

  /// [BorderRadius] for the [lg] scale.
  BorderRadius get borderRadiusLg => BorderRadius.circular(lg);

  /// [BorderRadius] for the [full] scale (pill shape).
  BorderRadius get borderRadiusFull => BorderRadius.circular(full);

  @override
  AppRadii copyWith({
    double? none,
    double? sm,
    double? md,
    double? lg,
    double? full,
  }) {
    return AppRadii(
      none: none ?? this.none,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      full: full ?? this.full,
    );
  }

  @override
  AppRadii lerp(ThemeExtension<AppRadii>? other, double t) {
    if (other is! AppRadii) return this;
    return AppRadii(
      none: lerpDouble(none, other.none, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      full: lerpDouble(full, other.full, t)!,
    );
  }
}
