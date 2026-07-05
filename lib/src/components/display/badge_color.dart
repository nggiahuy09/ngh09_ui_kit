import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';

/// The color of a `GHAppBadge`, controlling its background, label and
/// leading-dot tints.
///
/// Matches the four colors in the Finesse UI Kit "Badges" component set.
enum BadgeColor {
  /// Neutral gray — the default, non-emphasized color.
  primary,

  /// Negative / destructive color.
  error,

  /// Caution color.
  warning,

  /// Positive / success color.
  success;

  /// The badge's background tint.
  Color get background => switch (this) {
    BadgeColor.primary => ColorTokens.gray100,
    BadgeColor.error => ColorTokens.error200,
    BadgeColor.warning => ColorTokens.warning200,
    BadgeColor.success => ColorTokens.success200,
  };

  /// The label and icon content color.
  Color get foreground => switch (this) {
    BadgeColor.primary => ColorTokens.gray900,
    BadgeColor.error => ColorTokens.error700,
    BadgeColor.warning => ColorTokens.warning700,
    BadgeColor.success => ColorTokens.success700,
  };

  /// The fill color of a `GHAppBadge.dot`'s leading dot.
  Color get dot => switch (this) {
    BadgeColor.primary => ColorTokens.gray700,
    BadgeColor.error => ColorTokens.error600,
    BadgeColor.warning => ColorTokens.warning600,
    BadgeColor.success => ColorTokens.success600,
  };
}
