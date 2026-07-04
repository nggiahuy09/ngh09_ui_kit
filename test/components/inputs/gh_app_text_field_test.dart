import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('GHAppTextField', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppTextField()));
      expect(find.byType(GHAppTextField), findsOneWidget);
    });

    testWidgets('shows the label and placeholder', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppTextField(label: 'Email', placeholder: 'you@example.com')));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('you@example.com'), findsOneWidget);
    });

    testWidgets('calls onChanged as the user types', (tester) async {
      String? received;
      await tester.pumpWidget(_wrap(GHAppTextField(onChanged: (v) => received = v)));
      await tester.enterText(find.byType(TextField), 'hello');
      expect(received, 'hello');
    });

    testWidgets('does not accept input when disabled', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(_wrap(GHAppTextField(controller: controller, enabled: false)));
      await tester.enterText(find.byType(TextField), 'hello');
      expect(controller.text, isEmpty);
    });

    testWidgets('shows existing text but blocks editing when read-only', (tester) async {
      final controller = TextEditingController(text: 'locked value');
      await tester.pumpWidget(_wrap(GHAppTextField(controller: controller, readOnly: true)));
      expect(find.text('locked value'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'hello');
      expect(controller.text, 'locked value');
    });

    testWidgets('obscures text when obscureText is true', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppTextField(obscureText: true)));
      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.obscureText, isTrue);
    });

    testWidgets('shows helper text', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppTextField(helperText: 'Enter a valid email address.')));
      expect(find.text('Enter a valid email address.'), findsOneWidget);
    });

    testWidgets('hides helper row when helperText is null', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppTextField()));
      expect(find.byType(GHHeroIcon), findsNothing);
    });

    testWidgets('shows a leading icon when provided', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppTextField(leadingIcon: Icon(Icons.email_outlined))));
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    });
  });
}
