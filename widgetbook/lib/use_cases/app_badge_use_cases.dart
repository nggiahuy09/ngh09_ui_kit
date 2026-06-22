import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppBadge], grouping all of its
/// use cases.
///
/// Declared by hand (no code generation) so the catalog stays a plain Dart
/// project that anyone can read and extend.
WidgetbookComponent buildAppBadgeComponent() {
  return WidgetbookComponent(
    name: 'GHAppBadge',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: _playgroundUseCase,
      ),
      WidgetbookUseCase(
        name: 'Statuses',
        builder: _statusesUseCase,
      ),
      WidgetbookUseCase(
        name: 'Shapes',
        builder: _shapesUseCase,
      ),
    ],
  );
}

/// Interactive use case driven by knobs for every public prop.
Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;

  final label = knobs.string(
    label: 'Label',
    initialValue: 'New',
  );
  final status = knobs.object.dropdown<BadgeStatus>(
    label: 'Status',
    options: BadgeStatus.values,
    labelBuilder: (value) => value.name,
  );
  final size = knobs.object.dropdown<BadgeSize>(
    label: 'Size',
    options: BadgeSize.values,
    initialOption: BadgeSize.medium,
    labelBuilder: (value) => value.name,
  );
  final isDot = knobs.boolean(label: 'Dot');
  final expanded = knobs.boolean(label: 'Expanded');

  return Center(
    child: isDot
        ? GHAppBadge.dot(status: status, size: size)
        : GHAppBadge(
            label: label,
            status: status,
            size: size,
            expanded: expanded,
          ),
  );
}

/// Static gallery of every [BadgeStatus].
Widget _statusesUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        for (final status in BadgeStatus.values)
          GHAppBadge(label: status.name, status: status),
      ],
    ),
  );
}

/// Static gallery of the label / count / dot shapes.
Widget _shapesUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const GHAppBadge(label: 'New', status: BadgeStatus.info),
        GHAppBadge.count(count: 128, max: 99, status: BadgeStatus.danger),
        const GHAppBadge.dot(status: BadgeStatus.success),
      ],
    ),
  );
}
