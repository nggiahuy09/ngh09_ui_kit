import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppSlider].
WidgetbookComponent buildAppSliderComponent() {
  return WidgetbookComponent(
    name: 'GHAppSlider',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: _playgroundUseCase,
      ),
      WidgetbookUseCase(
        name: 'Indicators',
        builder: _indicatorsUseCase,
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
  final value = knobs.double.slider(label: 'Value', initialValue: 30, max: 100);
  final showValueLabel = knobs.boolean(label: 'Show value label');
  final disabled = knobs.boolean(label: 'Disabled');

  return _SliderPreview(
    width: 320,
    child: GHAppSlider(value: value, showValueLabel: showValueLabel, onChanged: disabled ? null : (_) {}),
  );
}

Widget _indicatorsUseCase(BuildContext context) {
  return _SliderPreview(
    width: 320,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 32,
      children: [
        GHAppSlider(value: 0, onChanged: (_) {}),
        GHAppSlider(value: 30, onChanged: (_) {}),
        GHAppSlider(value: 100, onChanged: (_) {}),
        GHAppSlider(value: 30, showValueLabel: true, onChanged: (_) {}),
      ],
    ),
  );
}

Widget _statesUseCase(BuildContext context) {
  return _SliderPreview(
    width: 320,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 32,
      children: [
        GHAppSlider(value: 30, showValueLabel: true, onChanged: (_) {}),
        const GHAppSlider(value: 30, showValueLabel: true, onChanged: null),
      ],
    ),
  );
}

class _SliderPreview extends StatelessWidget {
  const _SliderPreview({required this.width, required this.child});

  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(width: width, child: child),
    );
  }
}
