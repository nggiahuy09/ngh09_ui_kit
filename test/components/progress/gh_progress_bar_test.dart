import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: GHAppTheme.light(),
    home: Scaffold(body: Center(child: SizedBox(width: 300, child: child))),
  );
}

void main() {
  group('GHProgressBar — rendering', () {
    testWidgets('shows no text when indicator is none', (tester) async {
      await tester.pumpWidget(_wrap(const GHProgressBar(value: 40)));
      expect(find.text('40%'), findsNothing);
      expect(find.text('In Progress'), findsNothing);
    });

    testWidgets('shows a percentage beside the bar when indicator is valueOnly', (tester) async {
      await tester.pumpWidget(_wrap(const GHProgressBar(value: 40, indicator: GHProgressBarIndicator.valueOnly)));
      expect(find.text('40%'), findsOneWidget);
      expect(find.text('In Progress'), findsNothing);
    });

    testWidgets('shows a status label and percentage when indicator is labelAndValue', (tester) async {
      await tester.pumpWidget(_wrap(const GHProgressBar(value: 40, indicator: GHProgressBarIndicator.labelAndValue)));
      expect(find.text('40%'), findsOneWidget);
      expect(find.text('In Progress'), findsOneWidget);
    });

    testWidgets('derives "Starting" at 0 and "Completed" at max', (tester) async {
      await tester.pumpWidget(_wrap(const GHProgressBar(value: 0, indicator: GHProgressBarIndicator.labelAndValue)));
      expect(find.text('Starting'), findsOneWidget);

      await tester.pumpWidget(_wrap(const GHProgressBar(value: 100, indicator: GHProgressBarIndicator.labelAndValue)));
      expect(find.text('Completed'), findsOneWidget);
    });

    testWidgets('a custom label overrides the derived status label', (tester) async {
      await tester.pumpWidget(_wrap(const GHProgressBar(value: 40, indicator: GHProgressBarIndicator.labelAndValue, label: 'Uploading')));
      expect(find.text('Uploading'), findsOneWidget);
      expect(find.text('In Progress'), findsNothing);
    });

    testWidgets('computes the percentage against a custom max', (tester) async {
      await tester.pumpWidget(_wrap(const GHProgressBar(value: 30, max: 60, indicator: GHProgressBarIndicator.valueOnly)));
      expect(find.text('50%'), findsOneWidget);
    });

    testWidgets('exposes progress via semantics', (tester) async {
      await tester.pumpWidget(_wrap(const GHProgressBar(value: 40, indicator: GHProgressBarIndicator.labelAndValue)));
      final semantics = tester.getSemantics(find.byType(GHProgressBar));
      expect(semantics.label, 'In Progress');
      expect(semantics.value, '40%');
    });
  });
}
