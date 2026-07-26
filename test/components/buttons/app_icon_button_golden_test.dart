// `goldenTest` returns a Future it manages internally; calling it bare (as the
// alchemist API intends) trips `discarded_futures`, so we opt out file-wide.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Renders [child] inside the kit's [ThemeData] for the given [brightness] so
/// golden snapshots reflect the real themed appearance. A [Padding] gives the
/// snapshot a little breathing room.
Widget _themed(Widget child, {required Brightness brightness}) {
  final theme = brightness == Brightness.light ? GHAppTheme.light() : GHAppTheme.dark();
  return Theme(
    data: theme,
    child: ColoredBox(
      color: theme.extension<GHAppColors>()!.background,
      child: Padding(padding: const EdgeInsets.all(8), child: child),
    ),
  );
}

void main() {
  group('GHAppIconButton golden', () {
    goldenTest(
      'sizes — sharp and smooth',
      fileName: 'app_icon_button_sizes',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          for (final size in IconButtonSize.values) ...[
            GoldenTestScenario(
              name: '${size.name} sharp',
              child: _themed(
                GHAppIconButton(icon: const Icon(Icons.add), size: size, onPressed: () {}),
                brightness: Brightness.light,
              ),
            ),
            GoldenTestScenario(
              name: '${size.name} smooth',
              child: _themed(
                GHAppIconButton(icon: const Icon(Icons.add), size: size, corner: IconButtonCorner.smooth, onPressed: () {}),
                brightness: Brightness.light,
              ),
            ),
          ],
        ],
      ),
    );

    goldenTest(
      'states',
      fileName: 'app_icon_button_states',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: 'enabled',
            child: _themed(
              GHAppIconButton(icon: const Icon(Icons.add), onPressed: () {}),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'disabled',
            child: _themed(const GHAppIconButton(icon: Icon(Icons.add)), brightness: Brightness.light),
          ),
        ],
      ),
    );
  });
}
