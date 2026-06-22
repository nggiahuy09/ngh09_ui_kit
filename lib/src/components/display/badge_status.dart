import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/theme/app_colors.dart';

/// The semantic status conveyed by an `GHAppBadge`.
///
/// Each status maps to one of the kit's semantic color roles
/// (`context.colors`) so badges re-theme along with the rest of the kit and
/// never hardcode a primitive color.
enum BadgeStatus {
  /// Default, non-emphasized status — uses the muted surface roles.
  neutral,

  /// Positive / success status.
  success,

  /// Caution / warning status.
  warning,

  /// Negative / error / destructive status.
  danger,

  /// Informational status.
  info;

  /// Resolves the background color for this status from [colors].
  Color background(GHAppColors colors) => switch (this) {
    BadgeStatus.neutral => colors.surfaceVariant,
    BadgeStatus.success => colors.success,
    BadgeStatus.warning => colors.warning,
    BadgeStatus.danger => colors.danger,
    BadgeStatus.info => colors.info,
  };

  /// Resolves the foreground (content) color for this status from [colors].
  Color foreground(GHAppColors colors) => switch (this) {
    BadgeStatus.neutral => colors.onSurfaceVariant,
    BadgeStatus.success => colors.onSuccess,
    BadgeStatus.warning => colors.onWarning,
    BadgeStatus.danger => colors.onDanger,
    BadgeStatus.info => colors.onInfo,
  };
}

/// The size of an `GHAppBadge`, controlling height, padding and label style.
enum BadgeSize {
  /// Compact badge — for dense layouts.
  small,

  /// Default badge size.
  medium,
}
