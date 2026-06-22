import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [AppChip], grouping all of its use cases.
///
/// Declared by hand (no code generation) so the catalog stays a plain Dart
/// project that anyone can read and extend.
WidgetbookComponent buildAppChipComponent() {
  return WidgetbookComponent(
    name: 'AppChip',
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
    initialValue: 'Label',
  );
  final variant = knobs.object.dropdown<ChipVariant>(
    label: 'Variant',
    options: ChipVariant.values,
    labelBuilder: (value) => value.name,
  );
  final size = knobs.object.dropdown<ChipSize>(
    label: 'Size',
    options: ChipSize.values,
    initialOption: ChipSize.medium,
    labelBuilder: (value) => value.name,
  );
  final selected = knobs.boolean(label: 'Selected');
  final enabled = knobs.boolean(label: 'Enabled', initialValue: true);
  final expanded = knobs.boolean(label: 'Expanded');
  final hasLeading = knobs.boolean(label: 'Leading icon');
  final deletable = knobs.boolean(label: 'Deletable (input)');

  return Center(
    child: AppChip(
      label: label,
      variant: variant,
      size: size,
      selected: selected,
      enabled: enabled,
      expanded: expanded,
      leading: hasLeading ? const Icon(Icons.tag) : null,
      onPressed: () {},
      onSelected: (_) {},
      onDeleted: deletable ? () {} : null,
    ),
  );
}

/// Static gallery of every [ChipVariant], showing selected & unselected states.
Widget _variantsUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppChip.input(
          label: 'input',
          leading: const Icon(Icons.tag),
          onDeleted: () {},
        ),
        AppChip.filter(
          label: 'filter off',
          selected: false,
          onSelected: (_) {},
        ),
        AppChip.filter(label: 'filter on', selected: true, onSelected: (_) {}),
        AppChip.choice(
          label: 'choice off',
          selected: false,
          onSelected: (_) {},
        ),
        AppChip.choice(label: 'choice on', selected: true, onSelected: (_) {}),
      ],
    ),
  );
}

/// Static gallery of the available [ChipSize]s.
Widget _sizesUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final size in ChipSize.values)
          AppChip.filter(
            label: size.name,
            selected: true,
            size: size,
            onSelected: (_) {},
          ),
      ],
    ),
  );
}
