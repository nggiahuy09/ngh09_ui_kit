import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppDropdownList].
WidgetbookComponent buildAppDropdownListComponent() {
  return WidgetbookComponent(
    name: 'GHAppDropdownList',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'Sections', builder: _sectionsUseCase),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;
  final showHeader = knobs.boolean(label: 'Header', initialValue: true);
  final showDivider = knobs.boolean(label: 'Divider');

  return Center(
    child: SizedBox(
      width: 320,
      child: GHAppDropdownList(
        header: showHeader ? 'Account' : null,
        showDivider: showDivider,
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
        ],
      ),
    ),
  );
}

Widget _sectionsUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                label: 'Security',
                leadingType: GHDropdownLeadingType.icon,
                leadingIcon: GHIcons.shieldCheck,
                trailingType: GHDropdownTrailingType.chevron,
                onTap: () {},
              ),
            ],
          ),
          GHAppDropdownList(
            header: 'Help',
            items: [
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
    ),
  );
}
