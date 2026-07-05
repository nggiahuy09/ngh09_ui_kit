import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

const List<({String label, GHIconData icon})> _trail = [
  (label: 'Home', icon: GHIcons.home),
  (label: 'Settings', icon: GHIcons.cog6Tooth),
  (label: 'Account', icon: GHIcons.userCircle),
  (label: 'Address Management', icon: GHIcons.map),
  (label: 'Edit Address', icon: GHIcons.pencilSquare),
  (label: 'Delete Address', icon: GHIcons.trash),
];

List<GHBreadcrumbItem> _items(int count) {
  return [
    for (final entry in _trail.take(count)) GHBreadcrumbItem(label: entry.label, icon: GHHeroIcon(entry.icon), onTap: () {}),
  ];
}

/// The Widgetbook component entry for [GHBreadcrumbs].
WidgetbookComponent buildBreadcrumbsComponent() {
  return WidgetbookComponent(
    name: 'GHBreadcrumbs',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'Sections', builder: _sectionsUseCase),
      WidgetbookUseCase(name: 'Collapsed (tap "…" to expand)', builder: _collapsedUseCase),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;

  final type = knobs.object.dropdown<BreadcrumbType>(
    label: 'Type',
    options: BreadcrumbType.values,
    labelBuilder: (t) => t.name,
  );
  final sections = knobs.int.slider(label: 'Sections', initialValue: 3, min: 1, max: _trail.length);

  return Center(
    child: GHBreadcrumbs(items: _items(sections), type: type),
  );
}

Widget _sectionsUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [for (var count = 1; count <= _trail.length; count++) GHBreadcrumbs(items: _items(count))],
    ),
  );
}

Widget _collapsedUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        for (final type in BreadcrumbType.values) GHBreadcrumbs(items: _items(_trail.length), type: type),
      ],
    ),
  );
}
