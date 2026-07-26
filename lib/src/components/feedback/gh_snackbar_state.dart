import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';

/// The semantic state of a `GHSnackbar`, controlling its color scheme.
enum GHSnackbarState {
  /// Neutral informational snackbar (grey content, white background).
  active,

  /// Error / destructive snackbar (red palette).
  error,

  /// Caution snackbar (amber/orange palette).
  warning,

  /// Positive confirmation snackbar (green palette).
  success;

  /// The background surface for this state.
  Color get backgroundColor => switch (this) {
    GHSnackbarState.active => ColorTokens.white,
    // #FFFBFA — Finesse Error/50 (kit's error50 token is grey, not this tint)
    GHSnackbarState.error => const Color(0xFFFFFBFA),
    GHSnackbarState.warning => ColorTokens.warning50,
    GHSnackbarState.success => ColorTokens.success50,
  };

  /// The leading icon and message text color for this state.
  Color get contentColor => switch (this) {
    GHSnackbarState.active => ColorTokens.gray500,
    GHSnackbarState.error => ColorTokens.error700,
    GHSnackbarState.warning => ColorTokens.warning700,
    GHSnackbarState.success => ColorTokens.success700,
  };

  /// The color of the trailing "Dismiss" CTA label.
  ///
  /// Matches [contentColor] for the colored states, but the Finesse spec
  /// keeps it pure black (rather than grey) for [active].
  Color get dismissLabelColor =>
      this == GHSnackbarState.active ? ColorTokens.black : contentColor;
}
