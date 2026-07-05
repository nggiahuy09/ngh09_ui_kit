// `goldenTest` returns a Future managed internally; ignoring discarded_futures
// matches the convention used across all golden tests in this package.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

const _segments = [
  GHSegmentedControlItem(label: 'Day'),
  GHSegmentedControlItem(label: 'Week'),
  GHSegmentedControlItem(label: 'Month'),
];

const _iconOnlySegments = [
  GHSegmentedControlItem(icon: Icon(Icons.view_list)),
  GHSegmentedControlItem(icon: Icon(Icons.grid_view)),
];

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
  group('GHAppSegmentedControl golden', () {
    goldenTest(
      'corners',
      fileName: 'app_segmented_control_corners',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          for (final corner in SegmentedControlCorner.values)
            GoldenTestScenario(
              name: corner.name,
              child: _themed(
                GHAppSegmentedControl(segments: _segments, selectedIndex: 1, corner: corner, onSelectedIndexChanged: (_) {}),
                brightness: Brightness.light,
              ),
            ),
        ],
      ),
    );

    goldenTest(
      'types',
      fileName: 'app_segmented_control_types',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'only text',
            child: _themed(
              GHAppSegmentedControl(segments: _segments, selectedIndex: 0, onSelectedIndexChanged: (_) {}),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'only icon',
            child: _themed(
              GHAppSegmentedControl(segments: _iconOnlySegments, selectedIndex: 0, onSelectedIndexChanged: (_) {}),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'states',
      fileName: 'app_segmented_control_states',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'enabled',
            child: _themed(
              GHAppSegmentedControl(segments: _segments, selectedIndex: 1, onSelectedIndexChanged: (_) {}),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'disabled unselected leading',
            child: _themed(
              GHAppSegmentedControl(segments: _segments, selectedIndex: 1, onSelectedIndexChanged: null),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );
  });
}
