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

List<GHAppDropdownListItem> _accountItems() => [
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
];

void main() {
  group('GHAppDropdownList golden', () {
    goldenTest(
      'header and divider combinations',
      fileName: 'app_dropdown_list_header_divider',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'no header, no divider',
            child: _themed(GHAppDropdownList(items: _accountItems()), brightness: Brightness.light),
          ),
          GoldenTestScenario(
            name: 'header only',
            child: _themed(
              GHAppDropdownList(header: 'Account', items: _accountItems()),
              brightness: Brightness.light,
            ),
          ),
          GoldenTestScenario(
            name: 'header and divider',
            child: _themed(
              GHAppDropdownList(header: 'Account', showDivider: true, items: _accountItems()),
              brightness: Brightness.light,
            ),
          ),
        ],
      ),
    );
  });
}
