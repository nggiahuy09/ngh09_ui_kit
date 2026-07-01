import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppIconButton], grouping all of its
/// use cases.
///
/// Declared by hand (no code generation) so the catalog stays a plain Dart
/// project that anyone can read and extend.
WidgetbookComponent buildAppIconButtonComponent() {
  return WidgetbookComponent(
    name: 'GHAppIconButton',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: _playgroundUseCase,
      ),
      WidgetbookUseCase(
        name: 'Sizes',
        builder: _sizesUseCase,
      ),
      WidgetbookUseCase(
        name: 'Corners',
        builder: _cornersUseCase,
      ),
    ],
  );
}

/// Interactive use case driven by knobs for every public prop.
Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;

  final size = knobs.object.dropdown<IconButtonSize>(
    label: 'Size',
    options: IconButtonSize.values,
    initialOption: IconButtonSize.medium,
    labelBuilder: (value) => value.name,
  );
  final corner = knobs.object.dropdown<IconButtonCorner>(
    label: 'Corner',
    options: IconButtonCorner.values,
    initialOption: IconButtonCorner.sharp,
    labelBuilder: (value) => value.name,
  );
  final disabled = knobs.boolean(label: 'Disabled');

  return Center(
    child: GHAppIconButton(
      icon: const Icon(Icons.add),
      size: size,
      corner: corner,
      semanticLabel: 'Add',
      onPressed: disabled ? null : () {},
    ),
  );
}

/// Static gallery of every [IconButtonSize].
Widget _sizesUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        for (final size in IconButtonSize.values) GHAppIconButton(icon: const Icon(Icons.add), size: size, semanticLabel: size.name, onPressed: () {}),
      ],
    ),
  );
}

/// Static gallery of every [IconButtonCorner] shape.
Widget _cornersUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        for (final corner in IconButtonCorner.values)
          GHAppIconButton(icon: const Icon(Icons.add), corner: corner, semanticLabel: corner.name, onPressed: () {}),
      ],
    ),
  );
}
