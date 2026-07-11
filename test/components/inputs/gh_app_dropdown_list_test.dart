import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('GHAppDropdownList', () {
    testWidgets('renders all items', (tester) async {
      await tester.pumpWidget(
        _wrap(
          GHAppDropdownList(
            items: [
              GHAppDropdownListItem(label: 'Email', onTap: () {}),
              GHAppDropdownListItem(label: 'Address', onTap: () {}),
            ],
          ),
        ),
      );
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Address'), findsOneWidget);
    });

    testWidgets('renders header when provided', (tester) async {
      await tester.pumpWidget(
        _wrap(
          GHAppDropdownList(
            header: 'Account',
            items: [GHAppDropdownListItem(label: 'Email', onTap: () {})],
          ),
        ),
      );
      expect(find.text('Account'), findsOneWidget);
    });

    testWidgets('omits header when not provided', (tester) async {
      await tester.pumpWidget(
        _wrap(
          GHAppDropdownList(
            items: [GHAppDropdownListItem(label: 'Email', onTap: () {})],
          ),
        ),
      );
      expect(find.text('Account'), findsNothing);
    });

    testWidgets('renders a divider only when showDivider is true', (tester) async {
      await tester.pumpWidget(
        _wrap(
          GHAppDropdownList(
            items: [GHAppDropdownListItem(label: 'Email', onTap: () {})],
          ),
        ),
      );
      expect(find.byType(Divider), findsNothing);

      await tester.pumpWidget(
        _wrap(
          GHAppDropdownList(
            showDivider: true,
            items: [GHAppDropdownListItem(label: 'Email', onTap: () {})],
          ),
        ),
      );
      expect(find.byType(Divider), findsOneWidget);
    });
  });
}
