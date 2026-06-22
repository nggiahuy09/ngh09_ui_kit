import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Wraps [child] in a [MaterialApp] using the kit's theme so the component can
/// resolve `context.colors` / `context.radii` etc.
Widget _wrap(Widget child, {Brightness brightness = Brightness.light}) {
  return MaterialApp(
    theme: brightness == Brightness.light ? AppTheme.light() : AppTheme.dark(),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('AppBadge', () {
    testWidgets('renders its label', (tester) async {
      await tester.pumpWidget(_wrap(const AppBadge(label: 'New')));
      expect(find.text('New'), findsOneWidget);
    });

    testWidgets('count badge renders the number', (tester) async {
      await tester.pumpWidget(_wrap(AppBadge.count(count: 7)));
      expect(find.text('7'), findsOneWidget);
    });

    testWidgets('count badge clamps values above max to "max+"', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(AppBadge.count(count: 128, max: 99)));
      expect(find.text('99+'), findsOneWidget);
      expect(find.text('128'), findsNothing);
    });

    testWidgets('count badge keeps values at or below max unchanged', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(AppBadge.count(count: 99, max: 99)));
      expect(find.text('99'), findsOneWidget);
    });

    testWidgets('dot badge renders no text', (tester) async {
      await tester.pumpWidget(_wrap(const AppBadge.dot()));
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('exposes the label to accessibility', (tester) async {
      await tester.pumpWidget(_wrap(const AppBadge(label: 'Online')));
      expect(
        tester.getSemantics(find.text('Online')),
        matchesSemantics(label: 'Online'),
      );
    });

    group('count factory maps inputs to the right label', () {
      test('no max keeps the raw count', () {
        final badge = AppBadge.count(count: 5);
        expect(badge.label, '5');
      });
      test('count over max clamps', () {
        final badge = AppBadge.count(count: 200, max: 99);
        expect(badge.label, '99+');
      });
    });

    testWidgets('expanded badge is wider than a non-expanded one', (
      tester,
    ) async {
      // Measure the decorated Container the badge renders, under the loose
      // constraints of a Center: a normal badge hugs its label, while an
      // expanded one grows to the available width.
      final pill = find.descendant(
        of: find.byType(AppBadge),
        matching: find.byType(Container),
      );

      await tester.pumpWidget(_wrap(const AppBadge(label: 'X')));
      final narrow = tester.getSize(pill).width;

      await tester.pumpWidget(
        _wrap(const AppBadge(label: 'X', expanded: true)),
      );
      final wide = tester.getSize(pill).width;

      expect(wide, greaterThan(narrow));
    });

    testWidgets('status is configurable without throwing', (tester) async {
      for (final status in BadgeStatus.values) {
        await tester.pumpWidget(
          _wrap(AppBadge(label: status.name, status: status)),
        );
        expect(find.text(status.name), findsOneWidget);
      }
    });
  });
}
