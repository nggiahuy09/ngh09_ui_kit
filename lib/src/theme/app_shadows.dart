import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/shadows.dart';

/// Semantic shadow roles for the UI kit, exposed as a [ThemeExtension].
///
/// Components read shadows from here (via `context.shadows`) instead of using
/// primitive [ShadowTokens] directly, so re-theming touches only one place.
///
/// Roles mirror the **Finesse UI Kit** shadow system:
/// * **Normal** — [small], [medium], [large] for components at rest.
/// * **Hover** — [hoverPrimary] / [hoverSecondary] / [hoverError] /
///   [hoverWarning] / [hoverSuccess] for the hovered state.
/// * **Focus** — [focusPrimary] / [focusSecondary] / [focusError] /
///   [focusWarning] / [focusSuccess] for the focused state.
///
/// Shadows are mode-independent (the same set is used for light and dark).
@immutable
class GHAppShadows extends ThemeExtension<GHAppShadows> {
  /// Creates a shadow set. Prefer the [GHAppShadows.standard] preset.
  const GHAppShadows({
    required this.small,
    required this.medium,
    required this.large,
    required this.hoverPrimary,
    required this.hoverSecondary,
    required this.hoverError,
    required this.hoverWarning,
    required this.hoverSuccess,
    required this.focusPrimary,
    required this.focusSecondary,
    required this.focusError,
    required this.focusWarning,
    required this.focusSuccess,
  });

  /// The default shadow set, mapped from the Finesse [ShadowTokens].
  const GHAppShadows.standard()
    : small = ShadowTokens.small,
      medium = ShadowTokens.medium,
      large = ShadowTokens.large,
      hoverPrimary = ShadowTokens.hoverPrimary,
      hoverSecondary = ShadowTokens.hoverSecondary,
      hoverError = ShadowTokens.hoverError,
      hoverWarning = ShadowTokens.hoverWarning,
      hoverSuccess = ShadowTokens.hoverSuccess,
      focusPrimary = ShadowTokens.focusPrimary,
      focusSecondary = ShadowTokens.focusSecondary,
      focusError = ShadowTokens.focusError,
      focusWarning = ShadowTokens.focusWarning,
      focusSuccess = ShadowTokens.focusSuccess;

  /// Subtle resting elevation (buttons, cards).
  final List<BoxShadow> small;

  /// Resting elevation with a hairline ring.
  final List<BoxShadow> medium;

  /// Prominent floating elevation (modals, popovers).
  final List<BoxShadow> large;

  /// Hovered state — primary (dark ring).
  final List<BoxShadow> hoverPrimary;

  /// Hovered state — secondary (neutral ring).
  final List<BoxShadow> hoverSecondary;

  /// Hovered state — error (red ring).
  final List<BoxShadow> hoverError;

  /// Hovered state — warning (amber ring).
  final List<BoxShadow> hoverWarning;

  /// Hovered state — success (green ring).
  final List<BoxShadow> hoverSuccess;

  /// Focused state — primary (dark ring + halo).
  final List<BoxShadow> focusPrimary;

  /// Focused state — secondary (neutral ring + halo).
  final List<BoxShadow> focusSecondary;

  /// Focused state — error (red ring + halo).
  final List<BoxShadow> focusError;

  /// Focused state — warning (amber ring + halo).
  final List<BoxShadow> focusWarning;

  /// Focused state — success (green ring + halo).
  final List<BoxShadow> focusSuccess;

  @override
  GHAppShadows copyWith({
    List<BoxShadow>? small,
    List<BoxShadow>? medium,
    List<BoxShadow>? large,
    List<BoxShadow>? hoverPrimary,
    List<BoxShadow>? hoverSecondary,
    List<BoxShadow>? hoverError,
    List<BoxShadow>? hoverWarning,
    List<BoxShadow>? hoverSuccess,
    List<BoxShadow>? focusPrimary,
    List<BoxShadow>? focusSecondary,
    List<BoxShadow>? focusError,
    List<BoxShadow>? focusWarning,
    List<BoxShadow>? focusSuccess,
  }) {
    return GHAppShadows(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      hoverPrimary: hoverPrimary ?? this.hoverPrimary,
      hoverSecondary: hoverSecondary ?? this.hoverSecondary,
      hoverError: hoverError ?? this.hoverError,
      hoverWarning: hoverWarning ?? this.hoverWarning,
      hoverSuccess: hoverSuccess ?? this.hoverSuccess,
      focusPrimary: focusPrimary ?? this.focusPrimary,
      focusSecondary: focusSecondary ?? this.focusSecondary,
      focusError: focusError ?? this.focusError,
      focusWarning: focusWarning ?? this.focusWarning,
      focusSuccess: focusSuccess ?? this.focusSuccess,
    );
  }

  @override
  GHAppShadows lerp(ThemeExtension<GHAppShadows>? other, double t) {
    if (other is! GHAppShadows) return this;
    return GHAppShadows(
      small: BoxShadow.lerpList(small, other.small, t) ?? small,
      medium: BoxShadow.lerpList(medium, other.medium, t) ?? medium,
      large: BoxShadow.lerpList(large, other.large, t) ?? large,
      hoverPrimary:
          BoxShadow.lerpList(hoverPrimary, other.hoverPrimary, t) ??
          hoverPrimary,
      hoverSecondary:
          BoxShadow.lerpList(hoverSecondary, other.hoverSecondary, t) ??
          hoverSecondary,
      hoverError:
          BoxShadow.lerpList(hoverError, other.hoverError, t) ?? hoverError,
      hoverWarning:
          BoxShadow.lerpList(hoverWarning, other.hoverWarning, t) ??
          hoverWarning,
      hoverSuccess:
          BoxShadow.lerpList(hoverSuccess, other.hoverSuccess, t) ??
          hoverSuccess,
      focusPrimary:
          BoxShadow.lerpList(focusPrimary, other.focusPrimary, t) ??
          focusPrimary,
      focusSecondary:
          BoxShadow.lerpList(focusSecondary, other.focusSecondary, t) ??
          focusSecondary,
      focusError:
          BoxShadow.lerpList(focusError, other.focusError, t) ?? focusError,
      focusWarning:
          BoxShadow.lerpList(focusWarning, other.focusWarning, t) ??
          focusWarning,
      focusSuccess:
          BoxShadow.lerpList(focusSuccess, other.focusSuccess, t) ??
          focusSuccess,
    );
  }
}
