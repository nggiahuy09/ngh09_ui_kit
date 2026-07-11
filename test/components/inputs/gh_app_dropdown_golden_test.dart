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
      child: Padding(padding: const EdgeInsets.all(24), child: child),
    ),
  );
}

Widget _checklist() => GHAppDropdown(
  width: 240,
  sections: [
    GHAppDropdownList(
      items: [
        for (final (i, name) in [
          'Hussain Imtiaz',
          'Abdul Rehman',
          'Ali Osama',
        ].indexed)
          GHAppDropdownListItem(
            label: name,
            supportingText: '@finesse',
            leadingType: GHDropdownLeadingType.checkbox,
            selected: i == 2,
            onTap: () {},
          ),
      ],
    ),
  ],
);

Widget _personnel() => GHAppDropdown(
  width: 240,
  sections: [
    GHAppDropdownList(
      items: [
        for (final (i, name) in [
          'Hussain Imtiaz',
          'Abdul Rehman',
          'Ali Osama',
        ].indexed)
          GHAppDropdownListItem(
            label: name,
            supportingText: '@finesse',
            leadingType: GHDropdownLeadingType.avatar,
            leading: GHUserAvatar.initials(name.substring(0, 2).toUpperCase(), size: GHAvatarSize.sm),
            trailingType: GHDropdownTrailingType.checkmark,
            selected: i == 2,
            onTap: () {},
          ),
      ],
    ),
  ],
);

Widget _menu() => GHAppDropdown(
  width: 240,
  sections: [
    GHAppDropdownList(
      header: 'Account',
      showDivider: true,
      items: [
        GHAppDropdownListItem(
          label: 'Account Information',
          leadingType: GHDropdownLeadingType.icon,
          leadingIcon: GHIcons.userCircle,
          trailingType: GHDropdownTrailingType.chevron,
          onTap: () {},
        ),
        GHAppDropdownListItem(
          label: 'Biometric Authentication',
          leadingType: GHDropdownLeadingType.icon,
          leadingIcon: GHIcons.fingerPrint,
          trailingType: GHDropdownTrailingType.toggle,
          toggleValue: true,
          onToggleChanged: (_) {},
        ),
      ],
    ),
    GHAppDropdownList(
      header: 'Help',
      items: [
        GHAppDropdownListItem(
          label: 'Contact Us',
          leadingType: GHDropdownLeadingType.icon,
          leadingIcon: GHIcons.chatBubbleLeftRight,
          onTap: () {},
        ),
      ],
    ),
  ],
);

void main() {
  group('GHAppDropdown golden', () {
    goldenTest(
      'sample dropdowns',
      fileName: 'app_dropdown_samples',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'checklist',
            child: _themed(_checklist(), brightness: Brightness.light),
          ),
          GoldenTestScenario(
            name: 'personnel',
            child: _themed(_personnel(), brightness: Brightness.light),
          ),
          GoldenTestScenario(
            name: 'menu',
            child: _themed(_menu(), brightness: Brightness.light),
          ),
        ],
      ),
    );
  });
}
