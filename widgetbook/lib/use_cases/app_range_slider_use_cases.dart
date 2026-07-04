import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppRangeSlider].
WidgetbookComponent buildAppRangeSliderComponent() {
  return WidgetbookComponent(
    name: 'GHAppRangeSlider',
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
  final start = knobs.double.slider(label: 'Start', initialValue: 25, min: 0, max: 100);
  final end = knobs.double.slider(label: 'End', initialValue: 75, min: 0, max: 100);
  final indicator = knobs.object.dropdown<SliderIndicator>(
    label: 'Indicator',
    options: SliderIndicator.values,
    initialOption: SliderIndicator.none,
    labelBuilder: (v) => v.name,
  );
  final disabled = knobs.boolean(label: 'Disabled');

  return _SliderPreview(
    width: 320,
    child: GHAppRangeSlider(
      values: RangeValues(start.clamp(0, end), end.clamp(start, 100)),
      indicator: indicator,
      onChanged: disabled ? null : (_) {},
    ),
  );
}

Widget _indicatorsUseCase(BuildContext context) {
  return _SliderPreview(
    width: 320,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 48,
      children: [
        for (final indicator in SliderIndicator.values) GHAppRangeSlider(values: const RangeValues(25, 75), indicator: indicator, onChanged: (_) {}),
      ],
    ),
  );
}

Widget _statesUseCase(BuildContext context) {
  return _SliderPreview(
    width: 320,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 48,
      children: [
        GHAppRangeSlider(values: const RangeValues(25, 75), indicator: SliderIndicator.text, onChanged: (_) {}),
        const GHAppRangeSlider(values: RangeValues(25, 75), indicator: SliderIndicator.text, onChanged: null),
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
