import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/components/icons/heroicon_style.dart';
import 'package:ngh09_ui_kit/src/components/navigation/breadcrumb_type.dart';
import 'package:ngh09_ui_kit/src/components/navigation/gh_breadcrumb_item.dart';
import 'package:ngh09_ui_kit/src/components/navigation/gh_crumb.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A horizontal trail of `GHCrumb`s showing the user's place in the information hierarchy, per the Finesse UI Kit spec.
///
/// The last [items] entry is always rendered active (bold, non-interactive) — it represents the current page. Earlier entries render muted gray and call their [GHBreadcrumbItem.onTap] when tapped.
///
/// [type] controls whether crumbs show their icon, their label, or both.
///
/// ```dart
/// GHBreadcrumbs(
///   items: [
///     GHBreadcrumbItem(label: 'Home', icon: const GHHeroIcon(GHIcons.home), onTap: goHome),
///     GHBreadcrumbItem(label: 'Settings', onTap: goSettings),
///     const GHBreadcrumbItem(label: 'Account'),
///   ],
/// );
/// ```
///
/// **Long trails.** When there are more than five [items], the trail collapses to the first item, an intermediate "…" crumb, and the last three items — matching the Finesse spec (second item through currently-active-minus-two are folded into "…"). Tapping "…" expands the full trail inline.
class GHBreadcrumbs extends StatefulWidget {
  /// Creates a breadcrumb trail with at least one item.
  ///
  /// Not a `const` constructor: [items] must be non-empty, which Dart's const evaluator cannot validate for a `List`.
  GHBreadcrumbs({required this.items, this.type = BreadcrumbType.textAndIcon, super.key}) : assert(items.isNotEmpty, 'GHBreadcrumbs needs at least one item.');

  /// The trail's pages/sections, in order from root to current.
  final List<GHBreadcrumbItem> items;

  /// Which parts of each crumb to show. See [BreadcrumbType].
  final BreadcrumbType type;

  static const int _maxVisible = 5;
  static const int _trailingCount = 3;

  @override
  State<GHBreadcrumbs> createState() => _GHBreadcrumbsState();
}

class _GHBreadcrumbsState extends State<GHBreadcrumbs> {
  bool _expanded = false;

  bool get _collapsible => widget.items.length > GHBreadcrumbs._maxVisible;

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final lastIndex = items.length - 1;
    final showAll = _expanded || !_collapsible;

    final indices = showAll
        ? List<int>.generate(items.length, (i) => i)
        : <int>[0, -1, for (var i = lastIndex - GHBreadcrumbs._trailingCount + 1; i <= lastIndex; i++) i];

    final children = <Widget>[];
    for (final index in indices) {
      if (children.isNotEmpty) children.add(const _BreadcrumbSeparator());

      if (index == -1) {
        children.add(GHCrumb(label: '...', onTap: () => setState(() => _expanded = true)));
        continue;
      }

      final item = items[index];
      children.add(
        GHCrumb(
          label: widget.type == BreadcrumbType.onlyIcon ? null : item.label,
          icon: widget.type == BreadcrumbType.onlyText ? null : item.icon,
          active: index == lastIndex,
          onTap: index == lastIndex ? null : item.onTap,
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(mainAxisSize: MainAxisSize.min, spacing: 4, children: children),
    );
  }
}

/// The chevron rendered between crumbs in a [GHBreadcrumbs] trail.
class _BreadcrumbSeparator extends StatelessWidget {
  const _BreadcrumbSeparator();

  @override
  Widget build(BuildContext context) => GHHeroIcon(GHIcons.chevronRight, style: HeroIconStyle.mini, size: 14, color: context.colors.onSurfaceVariant);
}
