import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Wraps [child] in a [MaterialApp] using the kit's theme so the component can
/// resolve `context.colors` / `context.spacing` etc.
Widget _wrap(Widget child, {Brightness brightness = Brightness.light}) {
  return MaterialApp(
    theme: brightness == Brightness.light ? AppTheme.light() : AppTheme.dark(),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('AppButton', () {
    testWidgets('renders its label', (tester) async {
      await tester.pumpWidget(_wrap(const AppButton(label: 'Save')));
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _wrap(AppButton(label: 'Tap', onPressed: () => taps++)),
      );

      await tester.tap(find.byType(AppButton));
      await tester.pump();

      expect(taps, 1);
    });

    testWidgets('reports disabled state via semantics when onPressed is null', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(const AppButton(label: 'Disabled')));
      expect(
        tester.getSemantics(find.byType(AppButton)),
        matchesSemantics(
          label: 'Disabled',
          isButton: true,
          hasEnabledState: true,
        ),
      );
    });

    testWidgets('does not call onPressed while loading', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _wrap(
          AppButton(label: 'Loading', isLoading: true, onPressed: () => taps++),
        ),
      );

      await tester.tap(find.byType(AppButton), warnIfMissed: false);
      await tester.pump();

      expect(taps, 0);
    });

    testWidgets('shows a progress indicator while loading', (tester) async {
      await tester.pumpWidget(
        _wrap(AppButton(label: 'Loading', isLoading: true, onPressed: () {})),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Label is preserved so the footprint does not jump.
      expect(find.text('Loading'), findsOneWidget);
    });

    testWidgets('hides leading icon while loading', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppButton(
            label: 'Loading',
            isLoading: true,
            leading: const Icon(Icons.star),
            onPressed: () {},
          ),
        ),
      );
      expect(find.byIcon(Icons.star), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders leading and trailing icons when not loading', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          AppButton(
            label: 'Icons',
            leading: const Icon(Icons.star),
            trailing: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ),
      );
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('exposes button + enabled semantics for accessibility', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(AppButton(label: 'Accessible', onPressed: () {})),
      );
      expect(
        tester.getSemantics(find.byType(AppButton)),
        matchesSemantics(
          label: 'Accessible',
          isButton: true,
          hasEnabledState: true,
          isEnabled: true,
          isFocusable: true,
          hasTapAction: true,
          hasFocusAction: true,
        ),
      );
    });

    group('named constructors map to the right variant', () {
      test('filled', () {
        expect(
          const AppButton.filled(label: 'x').variant,
          ButtonVariant.filled,
        );
      });
      test('tonal', () {
        expect(const AppButton.tonal(label: 'x').variant, ButtonVariant.tonal);
      });
      test('outlined', () {
        expect(
          const AppButton.outlined(label: 'x').variant,
          ButtonVariant.outlined,
        );
      });
      test('text', () {
        expect(const AppButton.text(label: 'x').variant, ButtonVariant.text);
      });
    });

    testWidgets('outlined variant renders an OutlinedButton', (tester) async {
      await tester.pumpWidget(
        _wrap(AppButton.outlined(label: 'Outlined', onPressed: () {})),
      );
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('expanded button is wider than a non-expanded one', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(AppButton(label: 'Narrow', onPressed: () {})),
      );
      final narrow = tester.getSize(find.byType(FilledButton)).width;

      await tester.pumpWidget(
        _wrap(AppButton(label: 'Narrow', expanded: true, onPressed: () {})),
      );
      final wide = tester.getSize(find.byType(FilledButton)).width;

      expect(wide, greaterThan(narrow));
    });
  });
}
