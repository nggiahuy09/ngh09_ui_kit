import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: child)),
);

const List<GHDropdownMenuItem<String>> _items = [
  GHDropdownMenuItem(value: 'healthcare', label: 'Healthcare'),
  GHDropdownMenuItem(value: 'fintech', label: 'Fintech'),
  GHDropdownMenuItem(value: 'agriculture', label: 'Agriculture'),
];

void main() {
  group('GHAppInputDropdown', () {
    testWidgets('renders placeholder', (tester) async {
      await tester.pumpWidget(_wrap(GHAppInputDropdown<String>(items: _items, placeholder: 'Select Work Area', onChanged: (_) {})));
      expect(find.text('Select Work Area'), findsOneWidget);
    });

    testWidgets('focusing opens the menu with every item', (tester) async {
      await tester.pumpWidget(_wrap(GHAppInputDropdown<String>(items: _items, onChanged: (_) {})));
      expect(find.text('Healthcare'), findsNothing);

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.text('Healthcare'), findsOneWidget);
      expect(find.text('Fintech'), findsOneWidget);
      expect(find.text('Agriculture'), findsOneWidget);
    });

    testWidgets('typing filters the items by label', (tester) async {
      await tester.pumpWidget(_wrap(GHAppInputDropdown<String>(items: _items, onChanged: (_) {})));

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'fin');
      await tester.pumpAndSettle();

      expect(find.text('Fintech'), findsOneWidget);
      expect(find.text('Healthcare'), findsNothing);
    });

    testWidgets('shows "No results" when nothing matches', (tester) async {
      await tester.pumpWidget(_wrap(GHAppInputDropdown<String>(items: _items, onChanged: (_) {})));

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'zzz');
      await tester.pumpAndSettle();

      expect(find.text('No results'), findsOneWidget);
    });

    testWidgets('selecting an item calls onChanged and fills the field', (tester) async {
      String? selected;
      await tester.pumpWidget(_wrap(GHAppInputDropdown<String>(items: _items, onChanged: (v) => selected = v)));

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Fintech'));
      await tester.pumpAndSettle();

      expect(selected, 'fintech');
      expect(find.text('Fintech'), findsOneWidget);
      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.controller!.text, 'Fintech');
    });

    testWidgets('non-searchable field does not filter on typing', (tester) async {
      await tester.pumpWidget(_wrap(GHAppInputDropdown<String>(items: _items, searchable: false, onChanged: (_) {})));

      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.readOnly, isTrue);
    });

    testWidgets('is disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(_wrap(GHAppInputDropdown<String>(items: _items, onChanged: null)));
      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.enabled, isFalse);
    });
  });
}
