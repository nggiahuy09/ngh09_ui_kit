import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('GHAppRadio', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_wrap(GHAppRadio(value: false, onChanged: (_) {})));
      expect(find.byType(GHAppRadio), findsOneWidget);
    });

    testWidgets('calls onChanged with true when tapped while unselected', (tester) async {
      bool? received;
      await tester.pumpWidget(_wrap(GHAppRadio(value: false, onChanged: (v) => received = v)));
      await tester.tap(find.byType(GHAppRadio));
      await tester.pump();
      expect(received, true);
    });

    testWidgets('calls onChanged with false when tapped while selected', (tester) async {
      bool? received;
      await tester.pumpWidget(_wrap(GHAppRadio(value: true, onChanged: (v) => received = v)));
      await tester.tap(find.byType(GHAppRadio));
      await tester.pump();
      expect(received, false);
    });

    testWidgets('does not call onChanged when disabled', (tester) async {
      final calls = <bool>[];
      await tester.pumpWidget(_wrap(const GHAppRadio(value: false, onChanged: null)));
      await tester.tap(find.byType(GHAppRadio), warnIfMissed: false);
      await tester.pump();
      expect(calls, isEmpty);
    });

    testWidgets('exposes checked=false via semantics when unselected', (tester) async {
      await tester.pumpWidget(_wrap(GHAppRadio(value: false, onChanged: (_) {})));
      expect(
        tester.getSemantics(find.byType(GHAppRadio)),
        matchesSemantics(hasTapAction: true, hasEnabledState: true, isEnabled: true, hasCheckedState: true),
      );
    });

    testWidgets('exposes checked=true via semantics when selected', (tester) async {
      await tester.pumpWidget(_wrap(GHAppRadio(value: true, onChanged: (_) {})));
      expect(
        tester.getSemantics(find.byType(GHAppRadio)),
        matchesSemantics(hasTapAction: true, hasEnabledState: true, isEnabled: true, hasCheckedState: true, isChecked: true),
      );
    });

    group('RadioSize dimensions', () {
      for (final (size, dimension) in [
        (RadioSize.small, 16.0),
        (RadioSize.medium, 20.0),
        (RadioSize.large, 24.0),
      ]) {
        testWidgets('$size renders at $dimension×${dimension}dp', (tester) async {
          await tester.pumpWidget(_wrap(GHAppRadio(value: false, size: size, onChanged: (_) {})));
          final box = tester.renderObject<RenderBox>(find.byType(AnimatedContainer).first);
          expect(box.size.width, dimension);
          expect(box.size.height, dimension);
        });
      }
    });
  });
}
