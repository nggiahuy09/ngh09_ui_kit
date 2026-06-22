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

/// One scenario per [BadgeStatus], rendered for the given [brightness].
List<GoldenTestScenario> _statusScenarios(Brightness brightness) {
  return [
    for (final status in BadgeStatus.values)
      GoldenTestScenario(
        name: status.name,
        child: _themed(
          AppBadge(label: status.name, status: status),
          brightness: brightness,
        ),
      ),
  ];
}

void main() {
  group('AppBadge golden', () {
    goldenTest(
      'statuses — light',
      fileName: 'app_badge_statuses_light',
      builder: () => GoldenTestGroup(
        columns: 3,
        children: _statusScenarios(Brightness.light),
      ),
    );

    goldenTest(
      'statuses — dark',
      fileName: 'app_badge_statuses_dark',
      builder: () => GoldenTestGroup(
        columns: 3,
        children: _statusScenarios(Brightness.dark),
      ),
    );

    goldenTest(
      'shapes',
      fileName: 'app_badge_shapes',
      builder: () => GoldenTestGroup(
        columns: 3,
        children: [
          GoldenTestScenario(
            name: 'label',
            child: _themed(
              const AppBadge(label: 'New', status: BadgeStatus.info),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'count',
            child: _themed(
              AppBadge.count(count: 128, max: 99, status: BadgeStatus.danger),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'dot',
            child: _themed(
              const AppBadge.dot(status: BadgeStatus.success),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'expanded',
      fileName: 'app_badge_expanded',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'fills its parent width',
            child: _themed(
              const SizedBox(
                width: 160,
                child: AppBadge(
                  label: 'Pending',
                  status: BadgeStatus.warning,
                  expanded: true,
                ),
              ),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'sizes',
      fileName: 'app_badge_sizes',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          for (final size in BadgeSize.values)
            GoldenTestScenario(
              name: size.name,
              child: _themed(
                AppBadge(
                  label: '9',
                  size: size,
                  status: BadgeStatus.success,
                ),
                brightness: Brightness.light,
              ),
            ),
        ],
      ),
    );
  });
}
