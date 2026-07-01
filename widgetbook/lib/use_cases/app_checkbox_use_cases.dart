import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppCheckbox].
WidgetbookComponent buildAppCheckboxComponent() {
  return WidgetbookComponent(
    name: 'GHAppCheckbox',
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
        name: 'States',
        builder: _statesUseCase,
      ),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;
  final size = knobs.object.dropdown<CheckboxSize>(
    label: 'Size',
    options: CheckboxSize.values,
    initialOption: CheckboxSize.small,
    labelBuilder: (v) => v.name,
  );
  final disabled = knobs.boolean(label: 'Disabled');
  final value = knobs.boolean(label: 'Checked');

  return Center(
    child: GHAppCheckbox(value: value, size: size, onChanged: disabled ? null : (_) {}),
  );
}

Widget _sizesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        for (final size in CheckboxSize.values)
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              GHAppCheckbox(value: false, size: size, onChanged: (_) {}),
              GHAppCheckbox(value: true, size: size, onChanged: (_) {}),
            ],
          ),
      ],
    ),
  );
}

Widget _statesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        GHAppCheckbox(value: false, onChanged: (_) {}),
        GHAppCheckbox(value: true, onChanged: (_) {}),
        GHAppCheckbox(value: false, onChanged: null),
        GHAppCheckbox(value: true, onChanged: null),
      ],
    ),
  );
}
