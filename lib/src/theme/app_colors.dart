import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';

/// Semantic color roles for the UI kit, exposed as a [ThemeExtension].
///
/// Components read colors from here (via `context.colors`) instead of using
/// primitive [ColorTokens] directly, so re-theming touches only one place.
///
/// Roles are grouped into:
/// * **Brand** — [primary] / [onPrimary] / [primaryContainer] / …
/// * **Surfaces** — [background], [surface], [surfaceVariant] and their `on*`.
/// * **Borders** — [outline], [outlineVariant].
/// * **Status** — [success], [warning], [danger], [info] and their `on*`.
@immutable
class GHAppColors extends ThemeExtension<GHAppColors> {
  /// Creates a semantic color set. Prefer the [GHAppColors.light] and
  /// [GHAppColors.dark] presets unless you are building a custom brand theme.
  const GHAppColors({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.danger,
    required this.onDanger,
    required this.info,
    required this.onInfo,
  });

  /// The default light color set.
  const GHAppColors.light()
    : brightness = Brightness.light,
      primary = ColorTokens.brand500,
      onPrimary = ColorTokens.white,
      primaryContainer = ColorTokens.brand100,
      onPrimaryContainer = ColorTokens.brand900,
      background = ColorTokens.neutral50,
      onBackground = ColorTokens.neutral900,
      surface = ColorTokens.neutral0,
      onSurface = ColorTokens.neutral900,
      surfaceVariant = ColorTokens.neutral100,
      onSurfaceVariant = ColorTokens.neutral600,
      outline = ColorTokens.neutral300,
      outlineVariant = ColorTokens.neutral200,
      success = ColorTokens.success500,
      onSuccess = ColorTokens.white,
      warning = ColorTokens.warning500,
      onWarning = ColorTokens.neutral900,
      danger = ColorTokens.danger500,
      onDanger = ColorTokens.white,
      info = ColorTokens.info500,
      onInfo = ColorTokens.white;

  /// The default dark color set.
  const GHAppColors.dark()
    : brightness = Brightness.dark,
      primary = ColorTokens.brand300,
      onPrimary = ColorTokens.brand900,
      primaryContainer = ColorTokens.brand700,
      onPrimaryContainer = ColorTokens.brand100,
      background = ColorTokens.neutral900,
      onBackground = ColorTokens.neutral50,
      surface = ColorTokens.neutral800,
      onSurface = ColorTokens.neutral50,
      surfaceVariant = ColorTokens.neutral700,
      onSurfaceVariant = ColorTokens.neutral300,
      outline = ColorTokens.neutral600,
      outlineVariant = ColorTokens.neutral700,
      success = ColorTokens.success500,
      onSuccess = ColorTokens.white,
      warning = ColorTokens.warning500,
      onWarning = ColorTokens.neutral900,
      danger = ColorTokens.danger500,
      onDanger = ColorTokens.white,
      info = ColorTokens.info500,
      onInfo = ColorTokens.white;

  /// Whether this set targets a light or dark UI.
  final Brightness brightness;

  /// Primary brand color, used for prominent actions.
  final Color primary;

  /// Content color drawn on top of [primary].
  final Color onPrimary;

  /// Lower-emphasis brand surface (e.g. tonal buttons, selected chips).
  final Color primaryContainer;

  /// Content color drawn on top of [primaryContainer].
  final Color onPrimaryContainer;

  /// App background, behind all surfaces.
  final Color background;

  /// Content color drawn on top of [background].
  final Color onBackground;

  /// Default component surface (cards, sheets, dialogs).
  final Color surface;

  /// Content color drawn on top of [surface].
  final Color onSurface;

  /// Alternate surface for subtle separation (e.g. filled input fields).
  final Color surfaceVariant;

  /// Content color drawn on top of [surfaceVariant]; also used for muted text.
  final Color onSurfaceVariant;

  /// Default border / divider color.
  final Color outline;

  /// Lower-emphasis border color (e.g. dividers within a surface).
  final Color outlineVariant;

  /// Positive / success state color.
  final Color success;

  /// Content color drawn on top of [success].
  final Color onSuccess;

  /// Caution / warning state color.
  final Color warning;

  /// Content color drawn on top of [warning].
  final Color onWarning;

  /// Negative / error / destructive state color.
  final Color danger;

  /// Content color drawn on top of [danger].
  final Color onDanger;

  /// Informational state color.
  final Color info;

  /// Content color drawn on top of [info].
  final Color onInfo;

  /// Builds a Material [ColorScheme] from these semantic roles, so the kit's
  /// theme stays consistent with built-in Material widgets.
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: primary,
      onSecondary: onPrimary,
      secondaryContainer: primaryContainer,
      onSecondaryContainer: onPrimaryContainer,
      error: danger,
      onError: onDanger,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
    );
  }

  @override
  GHAppColors copyWith({
    Brightness? brightness,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? danger,
    Color? onDanger,
    Color? info,
    Color? onInfo,
  }) {
    return GHAppColors(
      brightness: brightness ?? this.brightness,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
    );
  }

  @override
  GHAppColors lerp(ThemeExtension<GHAppColors>? other, double t) {
    if (other is! GHAppColors) return this;
    return GHAppColors(
      brightness: t < 0.5 ? brightness : other.brightness,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer: Color.lerp(
        primaryContainer,
        other.primaryContainer,
        t,
      )!,
      onPrimaryContainer: Color.lerp(
        onPrimaryContainer,
        other.onPrimaryContainer,
        t,
      )!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onSurfaceVariant: Color.lerp(
        onSurfaceVariant,
        other.onSurfaceVariant,
        t,
      )!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      onDanger: Color.lerp(onDanger, other.onDanger, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
    );
  }
}
