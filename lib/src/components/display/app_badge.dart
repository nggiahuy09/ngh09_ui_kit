import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/display/badge_status.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A small status indicator built on the kit's semantic tokens.
///
/// `AppBadge` comes in two shapes:
/// * A **labelled** badge (default constructor) shows short text — typically a
///   count or status word — inside a rounded pill.
/// * A **dot** badge ([AppBadge.dot]) is a tiny filled circle with no label,
///   used to flag the presence of something (e.g. unread state).
///
/// A count badge ([AppBadge.count]) is a convenience over the labelled badge
/// that renders an integer and can clamp large values to `"<max>+"`.
///
/// The [status] selects a semantic color role (`neutral` / `success` /
/// `warning` / `danger` / `info`). All colors, radii, spacing and text styles
/// are read from the active theme (`context.colors`, `context.radii`, …), so
/// the badge adapts to light/dark mode and any custom brand theme — nothing is
/// hardcoded.
///
/// ```dart
/// const AppBadge(label: 'New', status: BadgeStatus.success);
/// AppBadge.count(count: 128, max: 99, status: BadgeStatus.danger);
/// const AppBadge.dot(status: BadgeStatus.warning);
/// const AppBadge(label: 'Pending', expanded: true);
/// ```
class AppBadge extends StatelessWidget {
  /// Creates a labelled badge showing [label].
  const AppBadge({
    required this.label,
    this.status = BadgeStatus.neutral,
    this.size = BadgeSize.medium,
    this.expanded = false,
    super.key,
  }) : _isDot = false;

  /// Creates a dot badge — a small filled circle with no label.
  const AppBadge.dot({
    this.status = BadgeStatus.neutral,
    this.size = BadgeSize.medium,
    super.key,
  }) : label = null,
       expanded = false,
       _isDot = true;

  /// Creates a labelled badge showing `count`.
  ///
  /// When `max` is provided and `count` exceeds it, the label is clamped to
  /// `"<max>+"` (e.g. `count: 128, max: 99` renders `"99+"`).
  factory AppBadge.count({
    required int count,
    int? max,
    BadgeStatus status = BadgeStatus.neutral,
    BadgeSize size = BadgeSize.medium,
    bool expanded = false,
    Key? key,
  }) {
    final label = (max != null && count > max) ? '$max+' : '$count';
    return AppBadge(
      label: label,
      status: status,
      size: size,
      expanded: expanded,
      key: key,
    );
  }

  /// The badge's text. `null` for a [AppBadge.dot] badge.
  final String? label;

  /// The semantic status, selecting the badge's color. See [BadgeStatus].
  final BadgeStatus status;

  /// The size of the badge. See [BadgeSize].
  final BadgeSize size;

  /// Whether the badge should stretch to fill the available horizontal space.
  ///
  /// Has no effect on a [AppBadge.dot] badge, which is always a fixed circle.
  final bool expanded;

  /// Whether this badge renders as a dot rather than a label.
  final bool _isDot;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final background = status.background(colors);

    if (_isDot) {
      final diameter = _dotDiameter;
      return SizedBox(
        width: diameter,
        height: diameter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
          ),
        ),
      );
    }

    final foreground = status.foreground(colors);

    // The [Text] child already exposes [label] to accessibility, so no extra
    // Semantics wrapper is needed here.
    return Container(
      constraints: BoxConstraints(
        minWidth: expanded ? double.infinity : _minWidth,
        minHeight: _height,
      ),
      padding: _padding,
      // Only center within the box when expanded; otherwise an unconditional
      // alignment would make the badge greedily fill loose constraints.
      alignment: expanded ? Alignment.center : null,
      decoration: BoxDecoration(
        color: background,
        borderRadius: context.radii.borderRadiusFull,
      ),
      child: Text(
        label!,
        style: _labelStyle(context).copyWith(color: foreground),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  TextStyle _labelStyle(BuildContext context) {
    final styles = context.textStyles;
    return switch (size) {
      BadgeSize.small => styles.labelSmall,
      BadgeSize.medium => styles.labelMedium,
    };
  }

  double get _height => switch (size) {
    BadgeSize.small => 16,
    BadgeSize.medium => 20,
  };

  /// Keeps short labels (e.g. single digits) from collapsing to a sliver,
  /// nudging them toward a circular footprint.
  double get _minWidth => _height;

  double get _dotDiameter => switch (size) {
    BadgeSize.small => 6,
    BadgeSize.medium => 8,
  };

  EdgeInsets get _padding => switch (size) {
    BadgeSize.small => const EdgeInsets.symmetric(horizontal: 6),
    BadgeSize.medium => const EdgeInsets.symmetric(horizontal: 8),
  };
}
