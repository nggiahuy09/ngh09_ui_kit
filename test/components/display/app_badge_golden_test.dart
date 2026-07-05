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

/// One scenario per [BadgeColor], rendered for the given [brightness].
List<GoldenTestScenario> _colorScenarios(Brightness brightness) {
  return [
    for (final color in BadgeColor.values)
      GoldenTestScenario(
        name: color.name,
        child: _themed(GHAppBadge(label: color.name, color: color), brightness: brightness),
      ),
  ];
}

void main() {
  group('GHAppBadge golden', () {
    goldenTest(
      'colors — light',
      fileName: 'app_badge_colors_light',
      builder: () => GoldenTestGroup(columns: 4, children: _colorScenarios(Brightness.light)),
    );

    goldenTest(
      'colors — dark',
      fileName: 'app_badge_colors_dark',
      builder: () => GoldenTestGroup(columns: 4, children: _colorScenarios(Brightness.dark)),
    );

    goldenTest(
      'types',
      fileName: 'app_badge_types',
      builder: () => GoldenTestGroup(
        columns: 3,
        children: [
          GoldenTestScenario(
            name: 'simple',
            child: _themed(const GHAppBadge(label: 'Simple'), brightness: Brightness.light),
          ),
          GoldenTestScenario(
            name: 'dot',
            child: _themed(
              const GHAppBadge.dot(label: 'Live', color: BadgeColor.success),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'icon',
            child: _themed(
              const GHAppBadge.icon(label: 'Verified', leadingIcon: Icon(Icons.check), color: BadgeColor.warning),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'avatar',
            child: _themed(
              const GHAppBadge.avatar(label: 'Avatar', avatar: FlutterLogo()),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'flag',
            child: _themed(
              const GHAppBadge.flag(label: 'US', country: GHCountry.unitedStates, color: BadgeColor.error),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'count',
            child: _themed(
              GHAppBadge.count(count: 128, max: 99, color: BadgeColor.error),
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
              const SizedBox(width: 160, child: GHAppBadge(label: 'Pending', color: BadgeColor.warning, expanded: true)),
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
        columns: 3,
        children: [
          for (final size in BadgeSize.values)
            GoldenTestScenario(
              name: size.name,
              child: _themed(
                GHAppBadge.dot(label: size.name, size: size, color: BadgeColor.success),
                brightness: Brightness.light,
              ),
            ),
        ],
      ),
    );

    goldenTest(
      'corners',
      fileName: 'app_badge_corners',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          for (final corner in BadgeCorner.values)
            GoldenTestScenario(
              name: corner.name,
              child: _themed(GHAppBadge(label: corner.name, corner: corner), brightness: Brightness.light),
            ),
        ],
      ),
    );
  });
}
