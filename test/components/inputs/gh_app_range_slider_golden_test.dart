// `goldenTest` returns a Future managed internally; ignoring discarded_futures
// matches the convention used across all golden tests in this package.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _themed(Widget child, {required Brightness brightness}) {
  final theme = brightness == Brightness.light ? GHAppTheme.light() : GHAppTheme.dark();
  return Theme(
    data: theme,
    child: ColoredBox(
      color: theme.extension<GHAppColors>()!.background,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(width: 240, height: 64, child: child),
      ),
    ),
  );
}

void main() {
  group('GHAppRangeSlider golden', () {
    goldenTest(
      'indicators',
      fileName: 'app_range_slider_indicators',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          for (final indicator in SliderIndicator.values)
            GoldenTestScenario(
              name: indicator.name,
              child: _themed(
                GHAppRangeSlider(values: const RangeValues(25, 75), indicator: indicator, onChanged: (_) {}),
                brightness: Brightness.light,
              ),
            ),
        ],
      ),
    );

    goldenTest(
      'states',
      fileName: 'app_range_slider_states',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'enabled',
            child: _themed(
              GHAppRangeSlider(values: const RangeValues(25, 75), indicator: SliderIndicator.text, onChanged: (_) {}),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'disabled',
            child: _themed(
              const GHAppRangeSlider(values: RangeValues(25, 75), indicator: SliderIndicator.text, onChanged: null),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );
  });
}
