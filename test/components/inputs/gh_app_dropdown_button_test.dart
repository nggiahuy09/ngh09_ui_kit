import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: child)),
);

const List<GHDropdownMenuItem<String>> _items = [
  GHDropdownMenuItem(value: 'us', label: 'United States'),
  GHDropdownMenuItem(value: 'uk', label: 'United Kingdom'),
];

void main() {
  group('GHAppDropdownButton', () {
    testWidgets('renders placeholder when value is null', (tester) async {
      await tester.pumpWidget(_wrap(GHAppDropdownButton<String>(items: _items, placeholder: 'Select a country', onChanged: (_) {})));
      expect(find.text('Select a country'), findsOneWidget);
    });

    testWidgets('renders the selected item label', (tester) async {
      await tester.pumpWidget(_wrap(GHAppDropdownButton<String>(items: _items, value: 'uk', onChanged: (_) {})));
      expect(find.text('United Kingdom'), findsOneWidget);
    });

    testWidgets('opens the menu on tap and lists the items', (tester) async {
      await tester.pumpWidget(_wrap(GHAppDropdownButton<String>(items: _items, onChanged: (_) {})));
      expect(find.text('United States'), findsNothing);

      await tester.tap(find.byType(GHAppDropdownButton<String>));
      await tester.pumpAndSettle();

      expect(find.text('United States'), findsOneWidget);
      expect(find.text('United Kingdom'), findsOneWidget);
    });

    testWidgets('selecting an item calls onChanged and closes the menu', (tester) async {
      String? selected;
      await tester.pumpWidget(_wrap(GHAppDropdownButton<String>(items: _items, onChanged: (v) => selected = v)));

      await tester.tap(find.byType(GHAppDropdownButton<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('United Kingdom'));
      await tester.pumpAndSettle();

      expect(selected, 'uk');
      expect(find.text('United States'), findsNothing);
    });

    testWidgets('tapping outside the menu closes it', (tester) async {
      await tester.pumpWidget(
        _wrap(
          Column(
            children: [
              GHAppDropdownButton<String>(items: _items, onChanged: (_) {}),
              const SizedBox(height: 200, width: 200, child: Text('outside')),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(GHAppDropdownButton<String>));
      await tester.pumpAndSettle();
      expect(find.text('United States'), findsOneWidget);

      await tester.tapAt(tester.getCenter(find.text('outside')));
      await tester.pumpAndSettle();
      expect(find.text('United States'), findsNothing);
    });

    testWidgets('does not open when disabled', (tester) async {
      await tester.pumpWidget(_wrap(GHAppDropdownButton<String>(items: _items, onChanged: null)));
      await tester.tap(find.byType(GHAppDropdownButton<String>));
      await tester.pumpAndSettle();
      expect(find.text('United States'), findsNothing);
    });
  });
}
