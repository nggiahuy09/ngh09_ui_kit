import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

import 'package:ngh09_ui_kit_example/main.dart';

void main() {
  testWidgets('example renders the kit and toggles the theme', (tester) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    // The hero card and a few kit widgets are on screen.
    expect(find.text('Material 3 Design System'), findsOneWidget);
    expect(find.byType(GHAppButton), findsWidgets);
    expect(find.byType(GHAppBadge), findsWidgets);

    // The alert is further down the list; scroll it into view. Target the
    // outer ListView (the text field also contributes a Scrollable).
    await tester.scrollUntilVisible(
      find.byType(GHAppAlert),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byType(GHAppAlert), findsOneWidget);

    // Tapping the app-bar icon button flips the theme without throwing.
    await tester.tap(find.byType(GHAppIconButton).first);
    await tester.pumpAndSettle();
    expect(find.text('ngh09 UI Kit'), findsOneWidget);
  });
}
