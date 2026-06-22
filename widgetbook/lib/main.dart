import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_widgetbook/use_cases/app_badge_use_cases.dart';
import 'package:ngh09_ui_kit_widgetbook/use_cases/app_button_use_cases.dart';
import 'package:ngh09_ui_kit_widgetbook/use_cases/app_chip_use_cases.dart';
import 'package:widgetbook/widgetbook.dart';

void main() => runApp(const WidgetbookApp());

/// The Widgetbook catalog — a living styleguide for `ngh09_ui_kit`.
///
/// Components are declared manually (no code generation) under
/// [WidgetbookComponent]/[WidgetbookUseCase], and rendered with the kit's own
/// [GHAppTheme] light/dark themes through the [MaterialThemeAddon] so the catalog
/// always matches what consumers see.
class WidgetbookApp extends StatelessWidget {
  /// Creates the Widgetbook catalog app.
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookCategory(
          name: 'Components',
          children: [
            WidgetbookFolder(
              name: 'Buttons',
              children: [buildAppButtonComponent()],
            ),
            WidgetbookFolder(
              name: 'Display',
              children: [buildAppBadgeComponent(), buildAppChipComponent()],
            ),
          ],
        ),
      ],
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: GHAppTheme.light()),
            WidgetbookTheme(name: 'Dark', data: GHAppTheme.dark()),
          ],
        ),
        TextScaleAddon(),
        AlignmentAddon(),
        ViewportAddon([
          ...IosViewports.phones,
          ...AndroidViewports.phones,
        ]),
      ],
    );
  }
}
