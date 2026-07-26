import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: SizedBox(width: 300, child: child))),
);

void main() {
  group('GHAppSlider', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_wrap(GHAppSlider(value: 30, onChanged: (_) {})));
      expect(find.byType(GHAppSlider), findsOneWidget);
    });

    testWidgets('tapping near the start sets value close to min', (tester) async {
      double? received;
      await tester.pumpWidget(_wrap(GHAppSlider(value: 50, onChanged: (v) => received = v)));
      await tester.tapAt(tester.getTopLeft(find.byType(GHAppSlider)) + const Offset(1, 10));
      await tester.pump();
      expect(received, lessThan(5));
    });

    testWidgets('tapping near the end sets value close to max', (tester) async {
      double? received;
      await tester.pumpWidget(_wrap(GHAppSlider(value: 50, onChanged: (v) => received = v)));
      await tester.tapAt(tester.getTopRight(find.byType(GHAppSlider)) - const Offset(1, -10));
      await tester.pump();
      expect(received, greaterThan(95));
    });

    testWidgets('tapping the middle sets value to roughly half the range', (tester) async {
      double? received;
      await tester.pumpWidget(_wrap(GHAppSlider(value: 0, max: 200, onChanged: (v) => received = v)));
      await tester.tapAt(tester.getCenter(find.byType(GHAppSlider)));
      await tester.pump();
      expect(received, closeTo(100, 5));
    });

    testWidgets('does not call onChanged when disabled', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppSlider(value: 30, onChanged: null)));
      await tester.tapAt(tester.getCenter(find.byType(GHAppSlider)));
      await tester.pump();
      expect(find.byType(GHAppSlider), findsOneWidget);
    });

    testWidgets('arrow keys step the value while focused', (tester) async {
      double value = 30;
      await tester.pumpWidget(
        _wrap(
          StatefulBuilder(
            builder: (context, setState) {
              return GHAppSlider(value: value, onChanged: (v) => setState(() => value = v));
            },
          ),
        ),
      );
      await tester.tapAt(tester.getCenter(find.byType(GHAppSlider)));
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(value, greaterThan(30));

      final afterIncrease = value;
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump();
      expect(value, lessThan(afterIncrease));
    });

    testWidgets('shows the value label when showValueLabel is true', (tester) async {
      await tester.pumpWidget(_wrap(GHAppSlider(value: 42, showValueLabel: true, onChanged: (_) {})));
      expect(find.text('42%'), findsOneWidget);
    });

    testWidgets('formats the value label with a custom labelBuilder', (tester) async {
      await tester.pumpWidget(
        _wrap(GHAppSlider(value: 42, showValueLabel: true, labelBuilder: (v) => '\$${v.round()}', onChanged: (_) {})),
      );
      expect(find.text(r'$42'), findsOneWidget);
    });

    testWidgets('exposes slider semantics', (tester) async {
      await tester.pumpWidget(_wrap(GHAppSlider(value: 30, onChanged: (_) {})));
      expect(
        tester.getSemantics(find.byType(GHAppSlider)),
        matchesSemantics(
          isSlider: true,
          hasEnabledState: true,
          isEnabled: true,
          isFocusable: true,
          hasFocusAction: true,
          hasIncreaseAction: true,
          hasDecreaseAction: true,
          value: '30%',
        ),
      );
    });
  });
}
