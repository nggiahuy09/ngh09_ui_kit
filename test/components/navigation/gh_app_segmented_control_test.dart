import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: child)),
);

const _segments = [
  GHSegmentedControlItem(label: 'Day'),
  GHSegmentedControlItem(label: 'Week'),
  GHSegmentedControlItem(label: 'Month'),
];

void main() {
  group('GHAppSegmentedControl', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_wrap(GHAppSegmentedControl(segments: _segments, selectedIndex: 0, onSelectedIndexChanged: (_) {})));
      expect(find.byType(GHAppSegmentedControl), findsOneWidget);
      expect(find.text('Day'), findsOneWidget);
      expect(find.text('Week'), findsOneWidget);
      expect(find.text('Month'), findsOneWidget);
    });

    testWidgets('calls onSelectedIndexChanged with tapped index', (tester) async {
      int? received;
      await tester.pumpWidget(_wrap(GHAppSegmentedControl(segments: _segments, selectedIndex: 0, onSelectedIndexChanged: (i) => received = i)));
      await tester.tap(find.text('Week'));
      await tester.pump();
      expect(received, 1);
    });

    testWidgets('calls onSelectedIndexChanged even when tapping the already-selected segment', (tester) async {
      int? received;
      await tester.pumpWidget(_wrap(GHAppSegmentedControl(segments: _segments, selectedIndex: 0, onSelectedIndexChanged: (i) => received = i)));
      await tester.tap(find.text('Day'));
      await tester.pump();
      expect(received, 0);
    });

    testWidgets('does not call onSelectedIndexChanged when disabled', (tester) async {
      final calls = <int>[];
      await tester.pumpWidget(_wrap(GHAppSegmentedControl(segments: _segments, selectedIndex: 0, onSelectedIndexChanged: null)));
      await tester.tap(find.text('Week'), warnIfMissed: false);
      await tester.pump();
      expect(calls, isEmpty);
    });

    testWidgets('exposes selected=false via semantics for an unselected segment', (tester) async {
      await tester.pumpWidget(_wrap(GHAppSegmentedControl(segments: _segments, selectedIndex: 0, onSelectedIndexChanged: (_) {})));
      final segment = find.byKey(const ValueKey(1));
      expect(
        tester.getSemantics(segment),
        matchesSemantics(hasTapAction: true, isButton: true, hasEnabledState: true, isEnabled: true, hasSelectedState: true),
      );
    });

    testWidgets('exposes selected=true via semantics for the selected segment', (tester) async {
      await tester.pumpWidget(_wrap(GHAppSegmentedControl(segments: _segments, selectedIndex: 0, onSelectedIndexChanged: (_) {})));
      final segment = find.byKey(const ValueKey(0));
      expect(
        tester.getSemantics(segment),
        matchesSemantics(
          hasTapAction: true,
          isButton: true,
          hasEnabledState: true,
          isEnabled: true,
          hasSelectedState: true,
          isSelected: true,
        ),
      );
    });

    testWidgets('renders an icon-only segment without a label', (tester) async {
      await tester.pumpWidget(
        _wrap(
          GHAppSegmentedControl(
            segments: const [
              GHSegmentedControlItem(icon: Icon(Icons.list)),
              GHSegmentedControlItem(icon: Icon(Icons.grid_view)),
            ],
            selectedIndex: 0,
            onSelectedIndexChanged: (_) {},
          ),
        ),
      );
      expect(find.byIcon(Icons.list), findsOneWidget);
      expect(find.byIcon(Icons.grid_view), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    test('throws when constructed with fewer than two segments', () {
      expect(
        () => GHAppSegmentedControl(
          segments: const [GHSegmentedControlItem(label: 'Only')],
          selectedIndex: 0,
          onSelectedIndexChanged: (_) {},
        ),
        throwsAssertionError,
      );
    });

    test('throws when selectedIndex is out of range', () {
      expect(
        () => GHAppSegmentedControl(segments: _segments, selectedIndex: 3, onSelectedIndexChanged: (_) {}),
        throwsAssertionError,
      );
    });
  });
}
