import 'package:flutter/widgets.dart';

/// A single page/section entry in a `GHBreadcrumbs` trail.
class GHBreadcrumbItem {
  /// Creates a breadcrumb entry.
  const GHBreadcrumbItem({required this.label, this.icon, this.onTap});

  /// The page/section title.
  final String label;

  /// The leading icon, typically an 18dp `GHHeroIcon`.
  ///
  /// Hidden when the trail's `BreadcrumbType` is `onlyText`.
  final Widget? icon;

  /// Called when this crumb is tapped.
  ///
  /// Ignored for the trail's last (active/current) item, which is always rendered non-interactive.
  final VoidCallback? onTap;
}
