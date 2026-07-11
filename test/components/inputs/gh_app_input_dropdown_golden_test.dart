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
        padding: const EdgeInsets.all(12),
        child: SizedBox(width: 260, child: child),
      ),
    ),
  );
}

const List<GHDropdownMenuItem<String>> _items = [
  GHDropdownMenuItem(value: 'healthcare', label: 'Healthcare'),
  GHDropdownMenuItem(value: 'fintech', label: 'Fintech'),
];

void main() {
  group('GHAppInputDropdown golden', () {
    goldenTest(
      'closed states',
      fileName: 'app_input_dropdown_closed_states',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'placeholder',
            child: _themed(
              GHAppInputDropdown<String>(items: _items, placeholder: 'Select Work Area', onChanged: (_) {}),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'disabled',
            child: _themed(GHAppInputDropdown<String>(items: _items, onChanged: null), brightness: Brightness.light),
          ),
        ],
      ),
    );
  });
}
