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
  group('GHSnackbarState', () {
    test('each state returns a distinct background color', () {
      final backgrounds = GHSnackbarState.values.map((s) => s.backgroundColor).toSet();
      expect(backgrounds.length, GHSnackbarState.values.length);
    });

    test('each state returns a distinct content color', () {
      final colors = GHSnackbarState.values.map((s) => s.contentColor).toSet();
      expect(colors.length, GHSnackbarState.values.length);
    });

    test('dismiss label color is black for active, content color otherwise', () {
      expect(GHSnackbarState.active.dismissLabelColor, const Color(0xFF000000));
      for (final state in [GHSnackbarState.error, GHSnackbarState.warning, GHSnackbarState.success]) {
        expect(state.dismissLabelColor, state.contentColor);
      }
    });
  });

  group('GHSnackbar — rendering', () {
    testWidgets('shows message text', (tester) async {
      await tester.pumpWidget(_wrap(const GHSnackbar(message: 'Assist text for the user')));
      expect(find.text('Assist text for the user'), findsOneWidget);
    });

    testWidgets('shows leading icon by default', (tester) async {
      await tester.pumpWidget(_wrap(const GHSnackbar(message: 'Info')));
      expect(find.byType(GHHeroIcon), findsOneWidget);
    });

    testWidgets('hides leading icon when showLeadingIcon is false', (tester) async {
      await tester.pumpWidget(_wrap(const GHSnackbar(message: 'Info', showLeadingIcon: false)));
      expect(find.byType(GHHeroIcon), findsNothing);
    });

    testWidgets('shows close icon trailing affordance when onDismiss is provided', (tester) async {
      await tester.pumpWidget(_wrap(GHSnackbar(message: 'Info', onDismiss: () {})));
      expect(find.byType(GHHeroIcon), findsNWidgets(2));
      expect(find.text('Dismiss'), findsNothing);
    });

    testWidgets('hides trailing affordance when onDismiss is null', (tester) async {
      await tester.pumpWidget(_wrap(const GHSnackbar(message: 'Info')));
      expect(find.byType(GestureDetector), findsNothing);
    });

    testWidgets('shows CTA label instead of close icon when ctaButton is true', (tester) async {
      await tester.pumpWidget(_wrap(GHSnackbar(message: 'Info', ctaButton: true, onDismiss: () {})));
      expect(find.text('Dismiss'), findsOneWidget);
      expect(find.byType(GHHeroIcon), findsOneWidget);
    });

    testWidgets('shows custom CTA label', (tester) async {
      await tester.pumpWidget(_wrap(GHSnackbar(message: 'Info', ctaButton: true, ctaLabel: 'Retry', onDismiss: () {})));
      expect(find.text('Retry'), findsOneWidget);
    });
  });

  group('GHSnackbar — corners', () {
    testWidgets('has no border radius when smooth is false', (tester) async {
      await tester.pumpWidget(_wrap(const GHSnackbar(message: 'Sharp')));
      final box = tester.widget<DecoratedBox>(find.byType(DecoratedBox).first);
      final decoration = box.decoration as BoxDecoration;
      expect(decoration.borderRadius, isNull);
    });

    testWidgets('has a border radius when smooth is true', (tester) async {
      await tester.pumpWidget(_wrap(const GHSnackbar(message: 'Smooth', smooth: true)));
      final box = tester.widget<DecoratedBox>(find.byType(DecoratedBox).first);
      final decoration = box.decoration as BoxDecoration;
      expect(decoration.borderRadius, isNotNull);
    });
  });

  group('GHSnackbar — interactions', () {
    testWidgets('dismiss callback fires when close icon is tapped', (tester) async {
      var dismissed = false;
      await tester.pumpWidget(_wrap(GHSnackbar(message: 'Info', onDismiss: () => dismissed = true)));
      await tester.tap(find.byType(GestureDetector));
      expect(dismissed, isTrue);
    });

    testWidgets('dismiss callback fires when CTA button is tapped', (tester) async {
      var dismissed = false;
      await tester.pumpWidget(_wrap(GHSnackbar(message: 'Info', ctaButton: true, onDismiss: () => dismissed = true)));
      await tester.tap(find.text('Dismiss'));
      expect(dismissed, isTrue);
    });
  });

  group('GHSnackbar — semantics', () {
    testWidgets('has a semantic container label with state and message', (tester) async {
      await tester.pumpWidget(_wrap(const GHSnackbar(message: 'Something went wrong', state: GHSnackbarState.error)));

      final semantics = tester.getSemantics(find.byType(GHSnackbar));
      expect(semantics.label, contains('error'));
      expect(semantics.label, contains('Something went wrong'));
    });
  });
}
