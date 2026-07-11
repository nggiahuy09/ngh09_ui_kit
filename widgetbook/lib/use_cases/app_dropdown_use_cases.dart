import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppDropdown].
///
/// Mirrors the Finesse "Checklist", "Personnel" and "Menu" sample dropdowns —
/// each built purely from `GHAppDropdownList` / `GHAppDropdownListItem`.
WidgetbookComponent buildAppDropdownComponent() {
  return WidgetbookComponent(
    name: 'GHAppDropdown',
    useCases: [
      WidgetbookUseCase(name: 'Checklist', builder: _checklistUseCase),
      WidgetbookUseCase(name: 'Personnel', builder: _personnelUseCase),
      WidgetbookUseCase(name: 'Menu', builder: _menuUseCase),
    ],
  );
}

Widget _checklistUseCase(BuildContext context) {
  const names = [
    'Hussain Imtiaz',
    'Abdul Rehman',
    'Ali Osama',
    'Peter Parker',
    'Clark Kent',
    'Bruce Wayne',
  ];
  return Center(
    child: GHAppDropdown(
      width: 280,
      sections: [
        GHAppDropdownList(
          items: [
            for (final (i, name) in names.indexed)
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
    ),
  );
}

Widget _personnelUseCase(BuildContext context) {
  const names = [
    'Hussain Imtiaz',
    'Abdul Rehman',
    'Ali Osama',
    'Peter Parker',
    'Clark Kent',
  ];
  return Center(
    child: GHAppDropdown(
      width: 280,
      sections: [
        GHAppDropdownList(
          items: [
            for (final (i, name) in names.indexed)
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
    ),
  );
}

Widget _menuUseCase(BuildContext context) {
  return Center(
    child: GHAppDropdown(
      width: 280,
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
              label: 'Email',
              leadingType: GHDropdownLeadingType.icon,
              leadingIcon: GHIcons.envelope,
              trailingType: GHDropdownTrailingType.chevron,
              onTap: () {},
            ),
            GHAppDropdownListItem(
              label: 'Address',
              leadingType: GHDropdownLeadingType.icon,
              leadingIcon: GHIcons.mapPin,
              trailingType: GHDropdownTrailingType.chevron,
              onTap: () {},
            ),
            GHAppDropdownListItem(
              label: 'Security',
              leadingType: GHDropdownLeadingType.icon,
              leadingIcon: GHIcons.shieldCheck,
              trailingType: GHDropdownTrailingType.chevron,
              onTap: () {},
            ),
            GHAppDropdownListItem(
              label: 'Phone Authentication',
              leadingType: GHDropdownLeadingType.icon,
              leadingIcon: GHIcons.phone,
              trailingType: GHDropdownTrailingType.toggle,
              onToggleChanged: (_) {},
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
              label: 'APIs',
              leadingType: GHDropdownLeadingType.icon,
              leadingIcon: GHIcons.key,
              trailingType: GHDropdownTrailingType.chevron,
              onTap: () {},
            ),
            GHAppDropdownListItem(
              label: 'FAQs',
              leadingType: GHDropdownLeadingType.icon,
              leadingIcon: GHIcons.questionMarkCircle,
              trailingType: GHDropdownTrailingType.chevron,
              onTap: () {},
            ),
            GHAppDropdownListItem(
              label: 'Contact Us',
              leadingType: GHDropdownLeadingType.icon,
              leadingIcon: GHIcons.chatBubbleLeftRight,
              onTap: () {},
            ),
          ],
        ),
      ],
    ),
  );
}
