import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('GHAppDropdown', () {
    testWidgets('renders every section', (tester) async {
      await tester.pumpWidget(
        _wrap(
          GHAppDropdown(
            sections: [
              GHAppDropdownList(
                header: 'Account',
                items: [GHAppDropdownListItem(label: 'Email', onTap: () {})],
              ),
              GHAppDropdownList(
                header: 'Help',
                items: [GHAppDropdownListItem(label: 'FAQs', onTap: () {})],
              ),
            ],
          ),
        ),
      );
      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Help'), findsOneWidget);
      expect(find.text('FAQs'), findsOneWidget);
    });

    testWidgets('asserts on empty sections', (tester) async {
      expect(() => GHAppDropdown(sections: const []), throwsAssertionError);
    });
  });
}
