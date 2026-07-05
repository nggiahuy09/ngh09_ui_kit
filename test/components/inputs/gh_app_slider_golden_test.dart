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
      child: Padding(padding: const EdgeInsets.all(16), child: SizedBox(width: 240, height: 24, child: child)),
    ),
  );
}

void main() {
  group('GHAppSlider golden', () {
    goldenTest(
      'progress',
      fileName: 'app_slider_progress',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          for (final value in [0.0, 30.0, 100.0])
            GoldenTestScenario(
              name: '$value%',
              child: _themed(GHAppSlider(value: value, onChanged: (_) {}), brightness: Brightness.light),
            ),
        ],
      ),
    );

    goldenTest(
      'states',
      fileName: 'app_slider_states',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'enabled',
            child: _themed(GHAppSlider(value: 30, onChanged: (_) {}), brightness: Brightness.light),
          ),
          GoldenTestScenario(
            name: 'disabled',
            child: _themed(const GHAppSlider(value: 30, onChanged: null), brightness: Brightness.light),
          ),
          GoldenTestScenario(
            name: 'with value label',
            child: _themed(GHAppSlider(value: 30, showValueLabel: true, onChanged: (_) {}), brightness: Brightness.light),
          ),
        ],
      ),
    );
  });
}
