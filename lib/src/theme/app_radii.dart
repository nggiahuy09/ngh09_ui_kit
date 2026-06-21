import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/radii.dart';

/// Semantic border-radius scale exposed as a [ThemeExtension].
///
/// Accessed via `context.radii`. Maps to primitive [RadiusTokens].
@immutable
class AppRadii extends ThemeExtension<AppRadii> {
  /// Creates a radius set.
  const AppRadii({
    required this.sm,
    required this.md,
    required this.lg,
  });

  /// The default radius scale.
  const AppRadii.standard()
    : sm = RadiusTokens.sm,
      md = RadiusTokens.md,
      lg = RadiusTokens.lg;

  /// Small radius.
  final double sm;

  /// Medium radius.
  final double md;

  /// Large radius.
  final double lg;

  @override
  AppRadii copyWith({double? sm, double? md, double? lg}) {
    return AppRadii(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  AppRadii lerp(ThemeExtension<AppRadii>? other, double t) {
    if (other is! AppRadii) return this;
    return AppRadii(
      sm: sm + (other.sm - sm) * t,
      md: md + (other.md - md) * t,
      lg: lg + (other.lg - lg) * t,
    );
  }
}
