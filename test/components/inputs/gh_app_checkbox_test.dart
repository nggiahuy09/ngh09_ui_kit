import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('GHAppCheckbox', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_wrap(GHAppCheckbox(value: false, onChanged: (_) {})));
      expect(find.byType(GHAppCheckbox), findsOneWidget);
    });

    testWidgets('calls onChanged with true when tapped while unchecked', (tester) async {
      bool? received;
      await tester.pumpWidget(_wrap(GHAppCheckbox(value: false, onChanged: (v) => received = v)));
      await tester.tap(find.byType(GHAppCheckbox));
      await tester.pump();
      expect(received, true);
    });

    testWidgets('calls onChanged with false when tapped while checked', (tester) async {
      bool? received;
      await tester.pumpWidget(_wrap(GHAppCheckbox(value: true, onChanged: (v) => received = v)));
      await tester.tap(find.byType(GHAppCheckbox));
      await tester.pump();
      expect(received, false);
    });

    testWidgets('does not call onChanged when disabled', (tester) async {
      final calls = <bool>[];
      await tester.pumpWidget(_wrap(const GHAppCheckbox(value: false, onChanged: null)));
      await tester.tap(find.byType(GHAppCheckbox), warnIfMissed: false);
      await tester.pump();
      expect(calls, isEmpty);
    });

    testWidgets('shows a check glyph when checked', (tester) async {
      await tester.pumpWidget(_wrap(GHAppCheckbox(value: true, onChanged: (_) {})));
      expect(find.byType(GHHeroIcon), findsOneWidget);
    });

    testWidgets('shows no check glyph when unchecked', (tester) async {
      await tester.pumpWidget(_wrap(GHAppCheckbox(value: false, onChanged: (_) {})));
      expect(find.byType(GHHeroIcon), findsNothing);
    });

    testWidgets('exposes checked=false via semantics when unchecked', (tester) async {
      await tester.pumpWidget(_wrap(GHAppCheckbox(value: false, onChanged: (_) {})));
      expect(
        tester.getSemantics(find.byType(GHAppCheckbox)),
        matchesSemantics(hasTapAction: true, hasEnabledState: true, isEnabled: true, hasCheckedState: true),
      );
    });

    testWidgets('exposes checked=true via semantics when checked', (tester) async {
      await tester.pumpWidget(_wrap(GHAppCheckbox(value: true, onChanged: (_) {})));
      expect(
        tester.getSemantics(find.byType(GHAppCheckbox)),
        matchesSemantics(hasTapAction: true, hasEnabledState: true, isEnabled: true, hasCheckedState: true, isChecked: true),
      );
    });

    group('CheckboxSize dimensions', () {
      for (final (size, dimension) in [
        (CheckboxSize.small, 16.0),
        (CheckboxSize.medium, 20.0),
        (CheckboxSize.large, 24.0),
      ]) {
        testWidgets('$size renders at $dimension×${dimension}dp', (tester) async {
          await tester.pumpWidget(_wrap(GHAppCheckbox(value: false, size: size, onChanged: (_) {})));
          final box = tester.renderObject<RenderBox>(find.byType(AnimatedContainer).first);
          expect(box.size.width, dimension);
          expect(box.size.height, dimension);
        });
      }
    });
  });
}
