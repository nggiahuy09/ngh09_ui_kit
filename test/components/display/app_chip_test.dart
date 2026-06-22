import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Wraps [child] in a [MaterialApp] using the kit's theme so the component can
/// resolve `context.colors` / `context.radii` etc.
Widget _wrap(Widget child, {Brightness brightness = Brightness.light}) {
  return MaterialApp(
    theme:
        brightness == Brightness.light ? GHAppTheme.light() : GHAppTheme.dark(),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('GHAppChip', () {
    testWidgets('renders its label', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppChip(label: 'design')));
      expect(find.text('design'), findsOneWidget);
    });

    testWidgets('renders a leading icon when provided', (tester) async {
      await tester.pumpWidget(
        _wrap(const GHAppChip(label: 'design', leading: Icon(Icons.tag))),
      );
      expect(find.byIcon(Icons.tag), findsOneWidget);
    });

    testWidgets('input chip fires onPressed when tapped', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(
        _wrap(GHAppChip.input(label: 'tag', onPressed: () => tapped++)),
      );
      await tester.tap(find.text('tag'));
      expect(tapped, 1);
    });

    testWidgets('input chip shows delete affordance only with onDeleted', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(const GHAppChip.input(label: 'tag')));
      expect(find.byIcon(Icons.close), findsNothing);

      await tester.pumpWidget(
        _wrap(GHAppChip.input(label: 'tag', onDeleted: () {})),
      );
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('input chip fires onDeleted when delete icon is tapped', (
      tester,
    ) async {
      var deleted = 0;
      await tester.pumpWidget(
        _wrap(GHAppChip.input(label: 'tag', onDeleted: () => deleted++)),
      );
      await tester.tap(find.byIcon(Icons.close));
      expect(deleted, 1);
    });

    testWidgets('filter chip reports the toggled state on tap', (tester) async {
      bool? reported;
      await tester.pumpWidget(
        _wrap(
          GHAppChip.filter(
            label: 'Unread',
            selected: false,
            onSelected: (value) => reported = value,
          ),
        ),
      );
      await tester.tap(find.text('Unread'));
      expect(reported, isTrue);
    });

    testWidgets('filter chip reports false when already selected', (
      tester,
    ) async {
      bool? reported;
      await tester.pumpWidget(
        _wrap(
          GHAppChip.filter(
            label: 'Unread',
            selected: true,
            onSelected: (value) => reported = value,
          ),
        ),
      );
      await tester.tap(find.text('Unread'));
      expect(reported, isFalse);
    });

    testWidgets('choice chip reports the toggled state on tap', (tester) async {
      bool? reported;
      await tester.pumpWidget(
        _wrap(
          GHAppChip.choice(
            label: 'A',
            selected: false,
            onSelected: (value) => reported = value,
          ),
        ),
      );
      await tester.tap(find.text('A'));
      expect(reported, isTrue);
    });

    testWidgets('disabled chip ignores taps', (tester) async {
      var reported = false;
      await tester.pumpWidget(
        _wrap(
          GHAppChip.filter(
            label: 'Unread',
            selected: false,
            enabled: false,
            onSelected: (_) => reported = true,
          ),
        ),
      );
      await tester.tap(find.text('Unread'), warnIfMissed: false);
      expect(reported, isFalse);
    });

    testWidgets('disabled input chip does not fire onDeleted', (tester) async {
      var deleted = false;
      await tester.pumpWidget(
        _wrap(
          GHAppChip.input(
            label: 'tag',
            enabled: false,
            onDeleted: () => deleted = true,
          ),
        ),
      );
      // Delete affordance is hidden when the chip is disabled.
      expect(find.byIcon(Icons.close), findsNothing);
      expect(deleted, isFalse);
    });

    testWidgets('filter chip exposes its selected state to accessibility', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GHAppChip.filter(label: 'Unread', selected: true, onSelected: (_) {}),
        ),
      );
      expect(
        tester.getSemantics(find.byType(InkWell)),
        matchesSemantics(
          isButton: true,
          isSelected: true,
          hasSelectedState: true,
          isFocusable: true,
          hasTapAction: true,
          hasFocusAction: true,
        ),
      );
    });

    testWidgets('expanded chip is wider than a non-expanded one', (
      tester,
    ) async {
      // Measure the decorated Container the chip renders, under the loose
      // constraints of a Center: a normal chip hugs its label, while an
      // expanded one grows to the available width.
      final body = find.descendant(
        of: find.byType(GHAppChip),
        matching: find.byType(Container),
      );

      await tester.pumpWidget(_wrap(const GHAppChip(label: 'X')));
      final narrow = tester.getSize(body).width;

      await tester.pumpWidget(
        _wrap(const GHAppChip(label: 'X', expanded: true)),
      );
      final wide = tester.getSize(body).width;

      expect(wide, greaterThan(narrow));
    });

    testWidgets('variant is configurable without throwing', (tester) async {
      for (final variant in ChipVariant.values) {
        await tester.pumpWidget(
          _wrap(GHAppChip(label: variant.name, variant: variant)),
        );
        expect(find.text(variant.name), findsOneWidget);
      }
    });
  });
}
