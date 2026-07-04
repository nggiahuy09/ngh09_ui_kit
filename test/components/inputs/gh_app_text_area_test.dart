import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(theme: GHAppTheme.light(), home: Scaffold(body: Center(child: child)));

void main() {
  group('GHAppTextArea', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppTextArea()));
      expect(find.byType(GHAppTextArea), findsOneWidget);
    });

    testWidgets('shows the label and placeholder', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppTextArea(label: 'Message', placeholder: 'Write something…')));
      expect(find.text('Message'), findsOneWidget);
      expect(find.text('Write something…'), findsOneWidget);
    });

    testWidgets('calls onChanged as the user types', (tester) async {
      String? received;
      await tester.pumpWidget(_wrap(GHAppTextArea(onChanged: (v) => received = v)));
      await tester.enterText(find.byType(TextField), 'hello\nworld');
      expect(received, 'hello\nworld');
    });

    testWidgets('does not accept input when disabled', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(_wrap(GHAppTextArea(controller: controller, enabled: false)));
      await tester.enterText(find.byType(TextField), 'hello');
      expect(controller.text, isEmpty);
    });

    testWidgets('shows existing text but blocks editing when read-only', (tester) async {
      final controller = TextEditingController(text: 'locked value');
      await tester.pumpWidget(_wrap(GHAppTextArea(controller: controller, readOnly: true)));
      expect(find.text('locked value'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'hello');
      expect(controller.text, 'locked value');
    });

    testWidgets('shows helper text', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppTextArea(helperText: 'This field is required.')));
      expect(find.text('This field is required.'), findsOneWidget);
    });

    testWidgets('respects minLines and maxLines', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppTextArea(minLines: 4, maxLines: 6)));
      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.minLines, 4);
      expect(field.maxLines, 6);
    });

    test('throws when maxLines is less than minLines', () {
      expect(() => GHAppTextArea(minLines: 5, maxLines: 2), throwsAssertionError);
    });
  });
}
