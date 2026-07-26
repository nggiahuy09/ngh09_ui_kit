import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: GHAppTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('GHAlertState', () {
    test('each state returns a distinct background color', () {
      final backgrounds = GHAlertState.values.map((s) => s.backgroundColor).toSet();
      expect(backgrounds.length, GHAlertState.values.length);
    });

    test('each state returns a distinct headline color', () {
      final colors = GHAlertState.values.map((s) => s.headlineColor).toSet();
      expect(colors.length, GHAlertState.values.length);
    });

    test('each state returns a distinct body color', () {
      final colors = GHAlertState.values.map((s) => s.bodyColor).toSet();
      expect(colors.length, GHAlertState.values.length);
    });
  });

  group('GHAppAlert — rendering', () {
    testWidgets('shows headline text', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppAlert(headline: 'Something went wrong')));
      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('shows supporting text when provided', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const GHAppAlert(headline: 'Heads up', supportingText: 'Please check your input.'),
        ),
      );
      expect(find.text('Please check your input.'), findsOneWidget);
    });

    testWidgets('hides supporting text when not provided', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppAlert(headline: 'Heads up')));
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('shows action link when onAction is provided', (tester) async {
      await tester.pumpWidget(_wrap(GHAppAlert(headline: 'Info', onAction: () {})));
      expect(find.text('Learn More'), findsOneWidget);
    });

    testWidgets('hides action link when onAction is null', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppAlert(headline: 'Info')));
      expect(find.text('Learn More'), findsNothing);
    });

    testWidgets('shows custom action label', (tester) async {
      await tester.pumpWidget(
        _wrap(
          GHAppAlert(
            headline: 'Info',
            actionLabel: 'Retry',
            onAction: () {},
          ),
        ),
      );
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('shows dismiss button when onDismiss is provided', (tester) async {
      await tester.pumpWidget(_wrap(GHAppAlert(headline: 'Info', onDismiss: () {})));
      // The dismiss GestureDetector wraps an xMark icon; verify it exists.
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('hides dismiss button when onDismiss is null', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppAlert(headline: 'Info')));
      expect(find.byType(GestureDetector), findsNothing);
    });

    testWidgets('shows leading icon by default', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppAlert(headline: 'Info')));
      expect(find.byType(GHHeroIcon), findsOneWidget);
    });

    testWidgets('hides leading icon when showLeadingIcon is false', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppAlert(headline: 'Info', showLeadingIcon: false)));
      expect(find.byType(GHHeroIcon), findsNothing);
    });
  });

  group('GHAppAlert — corners', () {
    testWidgets('has no border radius when smooth is false', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppAlert(headline: 'Sharp')));
      final box = tester.widget<DecoratedBox>(find.byType(DecoratedBox).first);
      final decoration = box.decoration as BoxDecoration;
      expect(decoration.borderRadius, isNull);
    });

    testWidgets('has a border radius when smooth is true', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppAlert(headline: 'Smooth', smooth: true)));
      final box = tester.widget<DecoratedBox>(find.byType(DecoratedBox).first);
      final decoration = box.decoration as BoxDecoration;
      expect(decoration.borderRadius, isNotNull);
    });
  });

  group('GHAppAlert — interactions', () {
    testWidgets('action callback fires on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(GHAppAlert(headline: 'Info', onAction: () => tapped = true)));
      await tester.tap(find.text('Learn More'));
      expect(tapped, isTrue);
    });

    testWidgets('dismiss callback fires on tap', (tester) async {
      var dismissed = false;
      await tester.pumpWidget(_wrap(GHAppAlert(headline: 'Info', onDismiss: () => dismissed = true)));
      await tester.tap(find.byType(GestureDetector));
      expect(dismissed, isTrue);
    });
  });

  group('GHAppAlert — semantics', () {
    testWidgets('has a semantic container label with state and headline', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppAlert(headline: 'Your session expired', state: GHAlertState.error)));

      final semantics = tester.getSemantics(find.byType(GHAppAlert));
      expect(semantics.label, contains('error'));
      expect(semantics.label, contains('Your session expired'));
    });
  });
}
