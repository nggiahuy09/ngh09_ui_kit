import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppToggle].
WidgetbookComponent buildAppToggleComponent() {
  return WidgetbookComponent(
    name: 'GHAppToggle',
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
  final size = knobs.object.dropdown<ToggleSize>(
    label: 'Size',
    options: ToggleSize.values,
    initialOption: ToggleSize.small,
    labelBuilder: (v) => v.name,
  );
  final disabled = knobs.boolean(label: 'Disabled');
  final value = knobs.boolean(label: 'Checked');

  return Center(
    child: GHAppToggle(value: value, size: size, onChanged: disabled ? null : (_) {}),
  );
}

Widget _sizesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        for (final size in ToggleSize.values)
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              GHAppToggle(value: false, size: size, onChanged: (_) {}),
              GHAppToggle(value: true, size: size, onChanged: (_) {}),
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
        GHAppToggle(value: false, onChanged: (_) {}),
        GHAppToggle(value: true, onChanged: (_) {}),
        GHAppToggle(value: false, onChanged: null),
        GHAppToggle(value: true, onChanged: null),
      ],
    ),
  );
}
