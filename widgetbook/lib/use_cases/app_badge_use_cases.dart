import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [AppBadge], grouping all of its
/// use cases.
///
/// Declared by hand (no code generation) so the catalog stays a plain Dart
/// project that anyone can read and extend.
WidgetbookComponent buildAppBadgeComponent() {
  return WidgetbookComponent(
    name: 'AppBadge',
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
        ? AppBadge.dot(status: status, size: size)
        : AppBadge(
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
          AppBadge(label: status.name, status: status),
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
        const AppBadge(label: 'New', status: BadgeStatus.info),
        AppBadge.count(count: 128, max: 99, status: BadgeStatus.danger),
        const AppBadge.dot(status: BadgeStatus.success),
      ],
    ),
  );
}
