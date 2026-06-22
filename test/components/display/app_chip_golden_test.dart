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
  final theme = brightness == Brightness.light
      ? GHAppTheme.light()
      : GHAppTheme.dark();
  return Theme(
    data: theme,
    child: ColoredBox(
      color: theme.extension<GHAppColors>()!.background,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    ),
  );
}

/// One scenario per [ChipVariant] (selected where applicable), rendered for the
/// given [brightness].
List<GoldenTestScenario> _variantScenarios(Brightness brightness) {
  return [
    GoldenTestScenario(
      name: 'input',
      child: _themed(
        GHAppChip.input(
          label: 'design',
          leading: const Icon(Icons.tag),
          onDeleted: () {},
        ),
        brightness: brightness,
      ),
    ),
    GoldenTestScenario(
      name: 'filter (off)',
      child: _themed(
        GHAppChip.filter(label: 'Unread', selected: false, onSelected: (_) {}),
        brightness: brightness,
      ),
    ),
    GoldenTestScenario(
      name: 'filter (on)',
      child: _themed(
        GHAppChip.filter(label: 'Unread', selected: true, onSelected: (_) {}),
        brightness: brightness,
      ),
    ),
    GoldenTestScenario(
      name: 'choice (off)',
      child: _themed(
        GHAppChip.choice(label: 'Option', selected: false, onSelected: (_) {}),
        brightness: brightness,
      ),
    ),
    GoldenTestScenario(
      name: 'choice (on)',
      child: _themed(
        GHAppChip.choice(label: 'Option', selected: true, onSelected: (_) {}),
        brightness: brightness,
      ),
    ),
  ];
}

void main() {
  group('GHAppChip golden', () {
    goldenTest(
      'variants — light',
      fileName: 'app_chip_variants_light',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: _variantScenarios(Brightness.light),
      ),
    );

    goldenTest(
      'variants — dark',
      fileName: 'app_chip_variants_dark',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: _variantScenarios(Brightness.dark),
      ),
    );

    goldenTest(
      'sizes',
      fileName: 'app_chip_sizes',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          for (final size in ChipSize.values)
            GoldenTestScenario(
              name: size.name,
              child: _themed(
                GHAppChip.filter(
                  label: size.name,
                  selected: true,
                  size: size,
                  onSelected: (_) {},
                ),
                brightness: Brightness.light,
              ),
            ),
        ],
      ),
    );

    goldenTest(
      'expanded',
      fileName: 'app_chip_expanded',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'fills its parent width',
            child: _themed(
              SizedBox(
                width: 220,
                child: GHAppChip.filter(
                  label: 'All',
                  selected: true,
                  expanded: true,
                  onSelected: (_) {},
                ),
              ),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'states',
      fileName: 'app_chip_states',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: 'enabled',
            child: _themed(
              GHAppChip.filter(label: 'On', selected: true, onSelected: (_) {}),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'disabled',
            child: _themed(
              GHAppChip.filter(
                label: 'On',
                selected: true,
                enabled: false,
                onSelected: (_) {},
              ),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );
  });
}
