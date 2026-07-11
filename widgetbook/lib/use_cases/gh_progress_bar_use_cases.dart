import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHProgressBar].
WidgetbookComponent buildProgressBarComponent() {
  return WidgetbookComponent(
    name: 'GHProgressBar',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'Indicators', builder: _indicatorsUseCase),
      WidgetbookUseCase(name: 'Progression', builder: _progressionUseCase),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;

  final indicator = knobs.object.dropdown<GHProgressBarIndicator>(
    label: 'Indicator',
    options: GHProgressBarIndicator.values,
    labelBuilder: (i) => i.name,
  );
  final value = knobs.double.slider(label: 'Value', initialValue: 60, min: 0);

  return Center(
    child: SizedBox(
      width: 320,
      child: GHProgressBar(value: value, indicator: indicator),
    ),
  );
}

Widget _indicatorsUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 24,
        children: [for (final indicator in GHProgressBarIndicator.values) GHProgressBar(value: 60, indicator: indicator)],
      ),
    ),
  );
}

Widget _progressionUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          for (var value = 0; value <= 100; value += 20) GHProgressBar(value: value.toDouble(), indicator: GHProgressBarIndicator.labelAndValue),
        ],
      ),
    ),
  );
}
