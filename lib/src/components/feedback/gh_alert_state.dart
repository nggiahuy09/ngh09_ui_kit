import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';

/// The semantic state of a `GHAppAlert`, controlling its color scheme.
enum GHAlertState {
  /// Neutral informational alert (grey palette, white background).
  active,

  /// Error / destructive alert (red palette).
  error,

  /// Caution alert (amber/orange palette).
  warning,

  /// Positive confirmation alert (green palette).
  success;

  /// The tinted background surface for this state.
  Color get backgroundColor => switch (this) {
    GHAlertState.active => ColorTokens.white,
    // #FFFBFA — Finesse Error/50 (kit's error50 token is grey, not this tint)
    GHAlertState.error => const Color(0xFFFFFBFA),
    GHAlertState.warning => ColorTokens.warning50,
    GHAlertState.success => ColorTokens.success50,
  };

  /// The headline text color for this state.
  Color get headlineColor => switch (this) {
    GHAlertState.active => ColorTokens.gray600,
    GHAlertState.error => ColorTokens.error700,
    GHAlertState.warning => ColorTokens.warning700,
    GHAlertState.success => ColorTokens.success700,
  };

  /// The supporting text color for this state.
  Color get bodyColor => switch (this) {
    GHAlertState.active => ColorTokens.gray500,
    GHAlertState.error => ColorTokens.error600,
    GHAlertState.warning => ColorTokens.warning600,
    GHAlertState.success => ColorTokens.success600,
  };
}
