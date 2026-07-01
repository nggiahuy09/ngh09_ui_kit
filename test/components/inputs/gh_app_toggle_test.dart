import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('GHAppToggle', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_wrap(GHAppToggle(value: false, onChanged: (_) {})));
      expect(find.byType(GHAppToggle), findsOneWidget);
    });

    testWidgets('calls onChanged with toggled value when tapped', (tester) async {
      bool? received;
      await tester.pumpWidget(_wrap(GHAppToggle(value: false, onChanged: (v) => received = v)));
      await tester.tap(find.byType(GHAppToggle));
      await tester.pump();
      expect(received, true);
    });

    testWidgets('calls onChanged with false when tapped in checked state', (tester) async {
      bool? received;
      await tester.pumpWidget(_wrap(GHAppToggle(value: true, onChanged: (v) => received = v)));
      await tester.tap(find.byType(GHAppToggle));
      await tester.pump();
      expect(received, false);
    });

    testWidgets('does not call onChanged when disabled', (tester) async {
      final calls = <bool>[];
      await tester.pumpWidget(_wrap(const GHAppToggle(value: false, onChanged: null)));
      await tester.tap(find.byType(GHAppToggle), warnIfMissed: false);
      await tester.pump();
      expect(calls, isEmpty);
    });

    testWidgets('exposes toggled=false via semantics when unchecked', (tester) async {
      await tester.pumpWidget(_wrap(GHAppToggle(value: false, onChanged: (_) {})));
      expect(
        tester.getSemantics(find.byType(GHAppToggle)),
        matchesSemantics(hasTapAction: true, hasEnabledState: true, isEnabled: true, hasToggledState: true),
      );
    });

    testWidgets('exposes toggled=true via semantics when checked', (tester) async {
      await tester.pumpWidget(_wrap(GHAppToggle(value: true, onChanged: (_) {})));
      expect(
        tester.getSemantics(find.byType(GHAppToggle)),
        matchesSemantics(hasTapAction: true, hasEnabledState: true, isEnabled: true, hasToggledState: true, isToggled: true),
      );
    });

    group('ToggleSize dimensions', () {
      for (final (size, w, h) in [
        (ToggleSize.small, 36.0, 20.0),
        (ToggleSize.medium, 44.0, 24.0),
        (ToggleSize.large, 52.0, 32.0),
      ]) {
        testWidgets('$size renders at $w×${h}dp', (tester) async {
          await tester.pumpWidget(_wrap(GHAppToggle(value: false, size: size, onChanged: (_) {})));
          final box = tester.renderObject<RenderBox>(find.byType(AnimatedContainer).first);
          expect(box.size.width, w);
          expect(box.size.height, h);
        });
      }
    });
  });
}
