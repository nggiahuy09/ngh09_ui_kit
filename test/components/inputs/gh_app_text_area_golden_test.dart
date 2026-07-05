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
        child: SizedBox(width: 280, child: child),
      ),
    ),
  );
}

void main() {
  group('GHAppTextArea golden', () {
    goldenTest(
      'feedback statuses',
      fileName: 'app_text_area_feedback',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          for (final status in GHAlertState.values)
            GoldenTestScenario(
              name: status.name,
              child: _themed(
                GHAppTextArea(
                  label: 'Message',
                  placeholder: 'Write something…',
                  status: status,
                  helperText: 'Helper text goes here.',
                ),
                brightness: Brightness.light,
              ),
            ),
        ],
      ),
    );

    goldenTest(
      'states',
      fileName: 'app_text_area_states',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'empty',
            child: _themed(
              const GHAppTextArea(label: 'Message', placeholder: 'Write something…'),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'filled',
            child: _themed(
              GHAppTextArea(
                label: 'Message',
                controller: TextEditingController(text: 'Hi team, checking in on the project status.'),
              ),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'disabled',
            child: _themed(
              const GHAppTextArea(label: 'Message', placeholder: 'Write something…', enabled: false),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'read only',
            child: _themed(
              GHAppTextArea(
                label: 'Message',
                readOnly: true,
                controller: TextEditingController(text: 'Hi team, checking in on the project status.'),
              ),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );
  });
}
