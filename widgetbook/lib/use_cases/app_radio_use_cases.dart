import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppRadio].
WidgetbookComponent buildAppRadioComponent() {
  return WidgetbookComponent(
    name: 'GHAppRadio',
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
  final size = knobs.object.dropdown<RadioSize>(
    label: 'Size',
    options: RadioSize.values,
    initialOption: RadioSize.small,
    labelBuilder: (v) => v.name,
  );
  final disabled = knobs.boolean(label: 'Disabled');
  final value = knobs.boolean(label: 'Selected');

  return Center(
    child: GHAppRadio(value: value, size: size, onChanged: disabled ? null : (_) {}),
  );
}

Widget _sizesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        for (final size in RadioSize.values)
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              GHAppRadio(value: false, size: size, onChanged: (_) {}),
              GHAppRadio(value: true, size: size, onChanged: (_) {}),
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
        GHAppRadio(value: false, onChanged: (_) {}),
        GHAppRadio(value: true, onChanged: (_) {}),
        GHAppRadio(value: false, onChanged: null),
        GHAppRadio(value: true, onChanged: null),
      ],
    ),
  );
}
