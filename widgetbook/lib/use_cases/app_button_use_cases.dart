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
      isLoading: isLoading,
      expanded: expanded,
      leading: showLeading ? const Icon(Icons.star) : null,
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
            onPressed: () {},
          ),
      ],
    ),
  );
}

/// Static gallery of every [ButtonSize].
Widget _sizesUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final size in ButtonSize.values)
          GHAppButton(
            label: size.name,
            size: size,
            onPressed: () {},
          ),
      ],
    ),
  );
}
