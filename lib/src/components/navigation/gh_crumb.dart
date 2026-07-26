import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A single crumb — the atomic building block of a `GHBreadcrumbs` trail.
///
/// Renders an optional [icon], an optional [label], and an optional
/// [trailingIcon] left to right with an 8dp gap between whichever parts are
/// present. [active] switches between the Finesse "current page" look (bold
/// black) and the default muted gray, per the Finesse UI Kit spec.
///
/// ```dart
/// GHCrumb(label: 'Home', icon: GHHeroIcon(GHIcons.home), active: true);
///
/// GHCrumb(
///   label: 'Home',
///   icon: GHHeroIcon(GHIcons.home),
///   trailingIcon: GHHeroIcon(GHIcons.arrowRight),
///   onTap: goHome,
/// );
/// ```
///
/// Used standalone or composed (without [trailingIcon]) inside
/// `GHBreadcrumbs`, which supplies its own separators between crumbs.
class GHCrumb extends StatelessWidget {
  /// Creates a crumb. Provide a [label], an [icon], or both.
  const GHCrumb({
    this.label,
    this.icon,
    this.trailingIcon,
    this.active = false,
    this.onTap,
    super.key,
  }) : assert(label != null || icon != null, 'Provide a label, an icon, or both.');

  /// The crumb's text, shown in the Finesse `Body/sm/Semi Bold` style.
  final String? label;

  /// The crumb's leading icon, typically an 18dp `GHHeroIcon`.
  final Widget? icon;

  /// An optional trailing icon shown after [label] — e.g. a link affordance.
  final Widget? trailingIcon;

  /// Whether this crumb represents the current page.
  ///
  /// Active crumbs render bold black; inactive crumbs render muted gray.
  final bool active;

  /// Called when the crumb is tapped.
  ///
  /// When `null`, the crumb is not interactive.
  final VoidCallback? onTap;

  bool get _isEnabled => onTap != null;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = active ? colors.onSurface : colors.onSurfaceVariant;
    final style = context.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600, color: color);

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        if (icon != null) IconTheme.merge(data: IconThemeData(size: 18, color: color), child: icon!),
        if (label != null) Text(label!, style: style),
        if (trailingIcon != null) IconTheme.merge(data: IconThemeData(size: 18, color: color), child: trailingIcon!),
      ],
    );

    return Semantics(
      container: true,
      button: _isEnabled,
      enabled: _isEnabled,
      label: label,
      onTap: onTap,
      child: MouseRegion(
        cursor: _isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: ExcludeSemantics(child: content),
        ),
      ),
    );
  }
}
