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
      ? AppTheme.light()
      : AppTheme.dark();
  return Theme(
    data: theme,
    child: ColoredBox(
      color: theme.extension<AppColors>()!.background,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    ),
  );
}

/// One scenario per [ButtonVariant], rendered for the given [brightness].
List<GoldenTestScenario> _variantScenarios(Brightness brightness) {
  return [
    for (final variant in ButtonVariant.values)
      GoldenTestScenario(
        name: variant.name,
        child: _themed(
          AppButton(label: 'Button', variant: variant, onPressed: () {}),
          brightness: brightness,
        ),
      ),
  ];
}

void main() {
  group('AppButton golden', () {
    goldenTest(
      'variants — light',
      fileName: 'app_button_variants_light',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: _variantScenarios(Brightness.light),
      ),
    );

    goldenTest(
      'variants — dark',
      fileName: 'app_button_variants_dark',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: _variantScenarios(Brightness.dark),
      ),
    );

    goldenTest(
      'sizes',
      fileName: 'app_button_sizes',
      builder: () => GoldenTestGroup(
        columns: 3,
        children: [
          for (final size in ButtonSize.values)
            GoldenTestScenario(
              name: size.name,
              child: _themed(
                AppButton(label: 'Button', size: size, onPressed: () {}),
                brightness: Brightness.light,
              ),
            ),
        ],
      ),
    );

    goldenTest(
      'states',
      fileName: 'app_button_states',
      // The loading scenario shows an indefinite CircularProgressIndicator, so
      // pumpAndSettle would never finish. Pump a single frame for a stable
      // snapshot instead.
      pumpBeforeTest: pumpOnce,
      builder: () => GoldenTestGroup(
        columns: 3,
        children: [
          GoldenTestScenario(
            name: 'enabled with icons',
            child: _themed(
              AppButton(
                label: 'Save',
                leading: const Icon(Icons.check),
                trailing: const Icon(Icons.arrow_forward),
                onPressed: () {},
              ),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'disabled',
            child: _themed(
              const AppButton(label: 'Disabled'),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'loading',
            child: _themed(
              AppButton(label: 'Loading', isLoading: true, onPressed: () {}),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );
  });
}
