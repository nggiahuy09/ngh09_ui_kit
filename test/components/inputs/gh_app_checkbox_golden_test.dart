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
      child: Padding(padding: const EdgeInsets.all(12), child: child),
    ),
  );
}

void main() {
  group('GHAppCheckbox golden', () {
    goldenTest(
      'sizes — unchecked and checked',
      fileName: 'app_checkbox_sizes',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          for (final size in CheckboxSize.values) ...[
            GoldenTestScenario(
              name: '${size.name} off',
              child: _themed(
                GHAppCheckbox(value: false, size: size, onChanged: (_) {}),
                brightness: Brightness.light,
              ),
            ),
            GoldenTestScenario(
              name: '${size.name} on',
              child: _themed(
                GHAppCheckbox(value: true, size: size, onChanged: (_) {}),
                brightness: Brightness.light,
              ),
            ),
          ],
        ],
      ),
    );

    goldenTest(
      'states',
      fileName: 'app_checkbox_states',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: 'enabled off',
            child: _themed(GHAppCheckbox(value: false, onChanged: (_) {}), brightness: Brightness.light),
          ),
          GoldenTestScenario(
            name: 'enabled on',
            child: _themed(GHAppCheckbox(value: true, onChanged: (_) {}), brightness: Brightness.light),
          ),
          GoldenTestScenario(
            name: 'disabled off',
            child: _themed(const GHAppCheckbox(value: false, onChanged: null), brightness: Brightness.light),
          ),
          GoldenTestScenario(
            name: 'disabled on',
            child: _themed(const GHAppCheckbox(value: true, onChanged: null), brightness: Brightness.light),
          ),
        ],
      ),
    );
  });
}
