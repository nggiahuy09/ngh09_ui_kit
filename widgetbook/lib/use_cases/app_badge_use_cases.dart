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
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'Colors', builder: _colorsUseCase),
      WidgetbookUseCase(name: 'Types', builder: _typesUseCase),
      WidgetbookUseCase(name: 'Sizes', builder: _sizesUseCase),
      WidgetbookUseCase(name: 'Corners', builder: _cornersUseCase),
    ],
  );
}

/// Interactive use case driven by knobs for every public prop.
Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;

  final label = knobs.string(label: 'Label', initialValue: 'New');
  final color = knobs.object.dropdown<BadgeColor>(
    label: 'Color',
    options: BadgeColor.values,
    labelBuilder: (value) => value.name,
  );
  final size = knobs.object.dropdown<BadgeSize>(
    label: 'Size',
    options: BadgeSize.values,
    initialOption: BadgeSize.medium,
    labelBuilder: (value) => value.name,
  );
  final corner = knobs.object.dropdown<BadgeCorner>(
    label: 'Corner',
    options: BadgeCorner.values,
    initialOption: BadgeCorner.smooth,
    labelBuilder: (value) => value.name,
  );
  final expanded = knobs.boolean(label: 'Expanded');

  return Center(
    child: GHAppBadge(label: label, color: color, size: size, corner: corner, expanded: expanded),
  );
}

/// Static gallery of every [BadgeColor].
Widget _colorsUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        for (final color in BadgeColor.values) GHAppBadge(label: color.name, color: color),
      ],
    ),
  );
}

/// Static gallery of the five leading-visual types.
Widget _typesUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const GHAppBadge(label: 'Simple'),
        const GHAppBadge.dot(label: 'Dot', color: BadgeColor.success),
        GHAppBadge.icon(label: 'Icon', leadingIcon: const Icon(Icons.check), color: BadgeColor.warning),
        const GHAppBadge.avatar(label: 'Avatar', avatar: FlutterLogo()),
        GHAppBadge.flag(label: 'Flag', country: GHCountry.unitedStates, color: BadgeColor.error),
        GHAppBadge.count(count: 128, max: 99, color: BadgeColor.error),
      ],
    ),
  );
}

/// Static gallery of every [BadgeSize].
Widget _sizesUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final size in BadgeSize.values) GHAppBadge.dot(label: size.name, size: size, color: BadgeColor.success),
      ],
    ),
  );
}

/// Static gallery of every [BadgeCorner].
Widget _cornersUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        for (final corner in BadgeCorner.values) GHAppBadge(label: corner.name, corner: corner),
      ],
    ),
  );
}
