import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHProgressStepper].
WidgetbookComponent buildProgressStepperComponent() {
  return WidgetbookComponent(
    name: 'GHProgressStepper',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'Indicators', builder: _indicatorsUseCase),
      WidgetbookUseCase(name: 'With labels', builder: _labelsUseCase),
    ],
  );
}

final List<GHProgressStep> _steps = [
  const GHProgressStep(label: 'Home', icon: GHIcons.home),
  const GHProgressStep(label: 'Settings', icon: GHIcons.cog6Tooth),
  const GHProgressStep(label: 'Account', icon: GHIcons.userCircle),
];

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;

  final indicator = knobs.object.dropdown<GHProgressStepIndicator>(
    label: 'Indicator',
    options: GHProgressStepIndicator.values,
    labelBuilder: (i) => i.name,
  );
  final showLabels = knobs.boolean(label: 'Show labels');
  final currentStep = knobs.int.slider(label: 'Current step', initialValue: 2, min: 1, max: _steps.length);

  return Center(
    child: SizedBox(
      width: 320,
      child: GHProgressStepper(
        steps: _steps,
        currentStep: currentStep,
        indicator: indicator,
        showLabels: showLabels && indicator != GHProgressStepIndicator.chip,
      ),
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
        children: [
          for (final indicator in GHProgressStepIndicator.values) GHProgressStepper(steps: _steps, currentStep: 2, indicator: indicator),
        ],
      ),
    ),
  );
}

Widget _labelsUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        for (final indicator in [GHProgressStepIndicator.number, GHProgressStepIndicator.icon])
          GHProgressStepper(steps: _steps, currentStep: 2, indicator: indicator, showLabels: true),
      ],
    ),
  );
}
