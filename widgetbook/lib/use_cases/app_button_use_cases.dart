import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppButton], grouping all of its
/// use cases.
///
/// Declared by hand (no code generation) so the catalog stays a plain Dart
/// project that anyone can read and extend.
WidgetbookComponent buildAppButtonComponent() {
  return WidgetbookComponent(
    name: 'GHAppButton',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: _playgroundUseCase,
      ),
      WidgetbookUseCase(
        name: 'Variants',
        builder: _variantsUseCase,
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

  final label = knobs.string(
    label: 'Label',
    initialValue: 'Button',
  );
  final variant = knobs.object.dropdown<ButtonVariant>(
    label: 'Variant',
    options: ButtonVariant.values,
    labelBuilder: (value) => value.name,
  );
  final size = knobs.object.dropdown<ButtonSize>(
    label: 'Size',
    options: ButtonSize.values,
    initialOption: ButtonSize.medium,
    labelBuilder: (value) => value.name,
  );
  final corner = knobs.object.dropdown<ButtonCorner>(
    label: 'Corner',
    options: ButtonCorner.values,
    initialOption: ButtonCorner.medium,
    labelBuilder: (value) => value.name,
  );
  final isLoading = knobs.boolean(label: 'Loading');
  final disabled = knobs.boolean(label: 'Disabled');
  final expanded = knobs.boolean(label: 'Expanded');
  final showLeading = knobs.boolean(label: 'Leading icon');
  final showTrailing = knobs.boolean(label: 'Trailing icon');

  return Center(
    child: GHAppButton(
      label: label,
      variant: variant,
      size: size,
      corner: corner,
      isLoading: isLoading,
      expanded: expanded,
      leading: showLeading ? const Icon(Icons.mail_outline) : null,
      trailing: showTrailing ? const Icon(Icons.arrow_forward) : null,
      onPressed: disabled ? null : () {},
    ),
  );
}

/// Static gallery of every [ButtonVariant].
Widget _variantsUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        for (final variant in ButtonVariant.values)
          GHAppButton(
            label: variant.name,
            variant: variant,
            leading: const Icon(Icons.mail_outline),
            trailing: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
      ],
    ),
  );
}

/// Static gallery of every [ButtonSize].
Widget _sizesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: context.spacing.md,
      children: [
        for (final size in ButtonSize.values)
          GHAppButton(
            label: size.name,
            size: size,
            leading: const Icon(Icons.mail_outline),
            trailing: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
      ],
    ),
  );
}

/// Static gallery of every [ButtonCorner] shape.
Widget _cornersUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        for (final corner in ButtonCorner.values)
          GHAppButton(
            label: corner.name,
            corner: corner,
            leading: const Icon(Icons.mail_outline),
            trailing: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
      ],
    ),
  );
}
