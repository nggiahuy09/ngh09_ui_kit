import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/display/badge_color.dart';
import 'package:ngh09_ui_kit/src/components/display/badge_corner.dart';
import 'package:ngh09_ui_kit/src/components/display/badge_size.dart';
import 'package:ngh09_ui_kit/src/components/flags/gh_country.dart';
import 'package:ngh09_ui_kit/src/components/flags/gh_country_flag.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// The leading visual a [GHAppBadge] shows before its label. Mutually exclusive — set by which named constructor was used, never by the caller.
enum _BadgeType { simple, dot, icon, avatar, flag }

/// A small status pill built on the Finesse UI Kit design tokens.
///
/// `GHAppBadge` always shows a [label], optionally preceded by a leading visual that depends on which constructor is used:
/// * The default constructor shows the label alone.
/// * [GHAppBadge.dot] precedes it with a small colored dot.
/// * [GHAppBadge.icon] precedes and/or follows it with [leadingIcon] /
///   [trailingIcon].
/// * [GHAppBadge.avatar] precedes it with a circular [avatar].
/// * [GHAppBadge.flag] precedes it with a [GHCountryFlag] for [country].
///
/// [GHAppBadge.count] is a convenience over the default constructor that renders an integer and can clamp large values to `"<max>+"`.
///
/// The [color] selects one of the four Finesse badge colors, [size] one of three heights, and [corner] a squared or fully-rounded (pill) shape.
///
/// ```dart
/// const GHAppBadge(label: 'New', color: BadgeColor.success);
/// const GHAppBadge.dot(label: 'Live', color: BadgeColor.error);
/// GHAppBadge.icon(label: 'Verified', leadingIcon: const Icon(Icons.check));
/// GHAppBadge.count(count: 128, max: 99, color: BadgeColor.error);
/// ```
class GHAppBadge extends StatelessWidget {
  /// Creates a badge showing [label] alone.
  const GHAppBadge({
    required this.label,
    this.color = BadgeColor.primary,
    this.size = BadgeSize.medium,
    this.corner = BadgeCorner.smooth,
    this.expanded = false,
    super.key,
  }) : _type = _BadgeType.simple,
       leadingIcon = null,
       trailingIcon = null,
       avatar = null,
       country = null;

  /// Creates a badge preceded by a small colored dot.
  const GHAppBadge.dot({
    required this.label,
    this.color = BadgeColor.primary,
    this.size = BadgeSize.medium,
    this.corner = BadgeCorner.smooth,
    this.expanded = false,
    super.key,
  }) : _type = _BadgeType.dot,
       leadingIcon = null,
       trailingIcon = null,
       avatar = null,
       country = null;

  /// Creates a badge with a [leadingIcon], a [trailingIcon], or both.
  const GHAppBadge.icon({
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.color = BadgeColor.primary,
    this.size = BadgeSize.medium,
    this.corner = BadgeCorner.smooth,
    this.expanded = false,
    super.key,
  }) : _type = _BadgeType.icon,
       avatar = null,
       country = null,
       assert(leadingIcon != null || trailingIcon != null, 'Provide a leadingIcon, a trailingIcon, or both.');

  /// Creates a badge preceded by a circular [avatar].
  const GHAppBadge.avatar({
    required this.label,
    required Widget this.avatar,
    this.color = BadgeColor.primary,
    this.size = BadgeSize.medium,
    this.corner = BadgeCorner.smooth,
    this.expanded = false,
    super.key,
  }) : _type = _BadgeType.avatar,
       leadingIcon = null,
       trailingIcon = null,
       country = null;

  /// Creates a badge preceded by the flag of [country].
  const GHAppBadge.flag({
    required this.label,
    required GHCountry this.country,
    this.color = BadgeColor.primary,
    this.size = BadgeSize.medium,
    this.corner = BadgeCorner.smooth,
    this.expanded = false,
    super.key,
  }) : _type = _BadgeType.flag,
       leadingIcon = null,
       trailingIcon = null,
       avatar = null;

  /// Creates a badge showing `count`.
  ///
  /// When `max` is provided and `count` exceeds it, the label is clamped to
  /// `"<max>+"` (e.g. `count: 128, max: 99` renders `"99+"`).
  factory GHAppBadge.count({
    required int count,
    int? max,
    BadgeColor color = BadgeColor.primary,
    BadgeSize size = BadgeSize.medium,
    BadgeCorner corner = BadgeCorner.smooth,
    bool expanded = false,
    Key? key,
  }) {
    final label = (max != null && count > max) ? '$max+' : '$count';
    return GHAppBadge(label: label, color: color, size: size, corner: corner, expanded: expanded, key: key);
  }

  /// The badge's text.
  final String label;

  /// Which leading visual this badge shows. Set internally by the named constructor used, never directly by the caller.
  final _BadgeType _type;

  /// The badge's color. See [BadgeColor].
  final BadgeColor color;

  /// The size of the badge. See [BadgeSize].
  final BadgeSize size;

  /// The corner-radius shape. See [BadgeCorner].
  final BadgeCorner corner;

  /// Whether the badge should stretch to fill the available horizontal space.
  final bool expanded;

  /// The leading icon, for a [GHAppBadge.icon].
  final Widget? leadingIcon;

  /// The trailing icon, for a [GHAppBadge.icon].
  final Widget? trailingIcon;

  /// The leading avatar, for a [GHAppBadge.avatar].
  final Widget? avatar;

  /// The country whose flag to show, for a [GHAppBadge.flag].
  final GHCountry? country;

  @override
  Widget build(BuildContext context) {
    final foreground = color.foreground;
    final labelStyle = _labelStyle(context).copyWith(color: foreground);

    final leading = switch (_type) {
      _BadgeType.simple => null,
      _BadgeType.dot => _Dot(diameter: _dotDiameter, color: color.dot),
      _BadgeType.icon =>
        leadingIcon == null
            ? null
            : IconTheme.merge(
                data: IconThemeData(size: _iconSize, color: foreground),
                child: leadingIcon!,
              ),
      _BadgeType.avatar => SizedBox.square(
        dimension: _avatarSize,
        child: ClipOval(child: avatar),
      ),
      _BadgeType.flag => GHCountryFlag(country!, size: _avatarSize),
    };

    final trailing = _type == _BadgeType.icon && trailingIcon != null
        ? IconTheme.merge(
            data: IconThemeData(size: _iconSize, color: foreground),
            child: trailingIcon!,
          )
        : null;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[ExcludeSemantics(child: leading), SizedBox(width: _gap)],
        Flexible(
          child: Text(label, style: labelStyle, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
        ),
        if (trailing != null) ...[SizedBox(width: _gap), ExcludeSemantics(child: trailing)],
      ],
    );

    // The [Text] child already exposes [label] to accessibility, so no extra Semantics wrapper is needed here.
    return Container(
      constraints: BoxConstraints(minWidth: expanded ? double.infinity : 0, minHeight: _height),
      padding: _padding,
      // Only center within the box when expanded; an unconditional alignment would make the badge greedily fill loose constraints.
      alignment: expanded ? Alignment.center : null,
      decoration: BoxDecoration(color: color.background, borderRadius: _borderRadius(context)),
      child: content,
    );
  }

  // ── Dimensions ─────────────────────────────────────────────────────────────

  double get _height => switch (size) {
    BadgeSize.small => 22,
    BadgeSize.medium => 26,
    BadgeSize.large => 32,
  };

  EdgeInsets get _padding => switch (size) {
    BadgeSize.small => const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    BadgeSize.medium => const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    BadgeSize.large => const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  };

  double get _gap => switch (size) {
    BadgeSize.small => 4,
    BadgeSize.medium => 5,
    BadgeSize.large => 6,
  };

  // The dot doesn't scale with badge size in the Finesse spec — always 6dp.
  double get _dotDiameter => 6;

  double get _iconSize => switch (size) {
    BadgeSize.small => 10,
    BadgeSize.medium => 12,
    BadgeSize.large => 14,
  };

  double get _avatarSize => switch (size) {
    BadgeSize.small => 14,
    BadgeSize.medium => 16,
    BadgeSize.large => 18,
  };

  // ── Typography ─────────────────────────────────────────────────────────────

  TextStyle _labelStyle(BuildContext context) {
    final styles = context.textStyles;
    return switch (size) {
      BadgeSize.small => styles.labelMedium,
      BadgeSize.medium => styles.labelLarge,
      BadgeSize.large => styles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
    };
  }

  // ── Shape ──────────────────────────────────────────────────────────────────

  BorderRadius _borderRadius(BuildContext context) => switch (corner) {
    BadgeCorner.sharp => context.radii.borderRadiusSm,
    BadgeCorner.smooth => context.radii.borderRadiusFull,
  };
}

/// The small filled circle rendered inside a [GHAppBadge.dot].
class _Dot extends StatelessWidget {
  const _Dot({required this.diameter, required this.color});

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: diameter,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
