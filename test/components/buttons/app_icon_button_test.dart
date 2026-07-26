import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Wraps [child] in a [MaterialApp] using the kit's theme so the component can
/// resolve `context.colors` / `context.spacing` etc.
Widget _wrap(Widget child, {Brightness brightness = Brightness.light}) {
  return MaterialApp(
    theme: brightness == Brightness.light ? GHAppTheme.light() : GHAppTheme.dark(),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('GHAppIconButton', () {
    testWidgets('renders its icon', (tester) async {
      await tester.pumpWidget(_wrap(GHAppIconButton(icon: const Icon(Icons.add), onPressed: () {})));
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var taps = 0;
      await tester.pumpWidget(_wrap(GHAppIconButton(icon: const Icon(Icons.add), onPressed: () => taps++)));
      await tester.tap(find.byType(GHAppIconButton));
      await tester.pump();
      expect(taps, 1);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      final calls = <int>[];
      await tester.pumpWidget(_wrap(const GHAppIconButton(icon: Icon(Icons.add))));
      await tester.tap(find.byType(GHAppIconButton), warnIfMissed: false);
      await tester.pump();
      expect(calls, isEmpty);
    });

    testWidgets('shows the semantic label as a tooltip message', (tester) async {
      await tester.pumpWidget(_wrap(GHAppIconButton(icon: const Icon(Icons.add), semanticLabel: 'Add', onPressed: () {})));
      expect(tester.widget<Tooltip>(find.byType(Tooltip)).message, 'Add');
    });

    testWidgets('renders no tooltip when semanticLabel is omitted', (tester) async {
      await tester.pumpWidget(_wrap(GHAppIconButton(icon: const Icon(Icons.add), onPressed: () {})));
      expect(find.byType(Tooltip), findsNothing);
    });

    testWidgets('exposes button + enabled semantics for accessibility', (tester) async {
      await tester.pumpWidget(_wrap(GHAppIconButton(icon: const Icon(Icons.add), onPressed: () {})));
      expect(
        tester.getSemantics(find.byType(FilledButton)),
        matchesSemantics(
          isButton: true,
          hasEnabledState: true,
          isEnabled: true,
          isFocusable: true,
          hasTapAction: true,
          hasFocusAction: true,
        ),
      );
    });

    testWidgets('reports disabled state via semantics when onPressed is null', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppIconButton(icon: Icon(Icons.add))));
      expect(
        tester.getSemantics(find.byType(FilledButton)),
        matchesSemantics(isButton: true, hasEnabledState: true),
      );
    });

    group('IconButtonSize dimensions', () {
      for (final (size, dimension) in [
        (IconButtonSize.extraExtraSmall, 32.0),
        (IconButtonSize.extraSmall, 40.0),
        (IconButtonSize.small, 48.0),
        (IconButtonSize.medium, 56.0),
        (IconButtonSize.large, 64.0),
        (IconButtonSize.extraLarge, 72.0),
        (IconButtonSize.extraExtraLarge, 80.0),
      ]) {
        testWidgets('$size renders at $dimension×${dimension}dp', (tester) async {
          await tester.pumpWidget(_wrap(GHAppIconButton(icon: const Icon(Icons.add), size: size, onPressed: () {})));
          final box = tester.getSize(find.byType(GHAppIconButton));
          expect(box.width, dimension);
          expect(box.height, dimension);
        });
      }
    });
  });
}
