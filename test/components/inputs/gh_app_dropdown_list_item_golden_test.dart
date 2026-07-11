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

void main() {
  group('GHAppDropdownListItem golden', () {
    goldenTest(
      'leading types',
      fileName: 'app_dropdown_list_item_leading_types',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'none',
            child: _themed(
              GHAppDropdownListItem(label: 'No leading', onTap: () {}),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'icon',
            child: _themed(
              GHAppDropdownListItem(
                label: 'Icon leading',
                leadingType: GHDropdownLeadingType.icon,
                leadingIcon: GHIcons.userCircle,
                onTap: () {},
              ),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'avatar',
            child: _themed(
              GHAppDropdownListItem(
                label: 'Hussain Imtiaz',
                supportingText: '@finesse',
                leadingType: GHDropdownLeadingType.avatar,
                leading: const GHUserAvatar.initials('HI', size: GHAvatarSize.sm),
                onTap: () {},
              ),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'flag',
            child: _themed(
              GHAppDropdownListItem(
                label: 'United States',
                leadingType: GHDropdownLeadingType.flag,
                leading: const GHCountryFlag(GHCountry.unitedStates, size: 20),
                onTap: () {},
              ),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'checkbox unchecked',
            child: _themed(
              GHAppDropdownListItem(label: 'Checklist item', leadingType: GHDropdownLeadingType.checkbox, onTap: () {}),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'checkbox checked',
            child: _themed(
              GHAppDropdownListItem(label: 'Checklist item', leadingType: GHDropdownLeadingType.checkbox, selected: true, onTap: () {}),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'trailing types',
      fileName: 'app_dropdown_list_item_trailing_types',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'none',
            child: _themed(
              GHAppDropdownListItem(label: 'No trailing', onTap: () {}),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'chevron',
            child: _themed(
              GHAppDropdownListItem(
                label: 'Address',
                trailingType: GHDropdownTrailingType.chevron,
                onTap: () {},
              ),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'checkmark selected',
            child: _themed(
              GHAppDropdownListItem(
                label: 'Ali Osama',
                trailingType: GHDropdownTrailingType.checkmark,
                selected: true,
                onTap: () {},
              ),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'toggle',
            child: _themed(
              GHAppDropdownListItem(
                label: 'Biometric Authentication',
                trailingType: GHDropdownTrailingType.toggle,
                toggleValue: true,
                onToggleChanged: (_) {},
              ),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'label',
            child: _themed(
              GHAppDropdownListItem(
                label: 'Notifications',
                trailingType: GHDropdownTrailingType.label,
                trailingLabel: '1',
                onTap: () {},
              ),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'states',
      fileName: 'app_dropdown_list_item_states',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'active',
            child: _themed(
              GHAppDropdownListItem(label: 'Active', onTap: () {}),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'selected',
            child: _themed(
              GHAppDropdownListItem(label: 'Selected', selected: true, onTap: () {}),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'disabled',
            child: _themed(
              const GHAppDropdownListItem(label: 'Disabled'),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );
  });
}
