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
  group('GHCrumb — rendering', () {
    testWidgets('shows label text', (tester) async {
      await tester.pumpWidget(_wrap(const GHCrumb(label: 'Home')));
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('shows icon when provided', (tester) async {
      await tester.pumpWidget(_wrap(const GHCrumb(icon: Icon(Icons.home))));
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('shows trailing icon when provided', (tester) async {
      await tester.pumpWidget(_wrap(const GHCrumb(label: 'Home', trailingIcon: Icon(Icons.arrow_forward))));
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('renders prominent bold text when active', (tester) async {
      await tester.pumpWidget(_wrap(const GHCrumb(label: 'Home', active: true)));
      final text = tester.widget<Text>(find.text('Home'));
      expect(text.style!.color, const GHAppColors.light().onSurface);
      expect(text.style!.fontWeight, FontWeight.w600);
    });

    testWidgets('renders muted text when inactive', (tester) async {
      await tester.pumpWidget(_wrap(const GHCrumb(label: 'Home')));
      final text = tester.widget<Text>(find.text('Home'));
      expect(text.style!.color, const GHAppColors.light().onSurfaceVariant);
    });
  });

  group('GHCrumb — interactions', () {
    testWidgets('onTap fires when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(GHCrumb(label: 'Home', onTap: () => tapped = true)));
      await tester.tap(find.byType(GHCrumb));
      expect(tapped, isTrue);
    });

    testWidgets('is not tappable when onTap is null', (tester) async {
      await tester.pumpWidget(_wrap(const GHCrumb(label: 'Home')));
      expect(
        tester.getSemantics(find.byType(GHCrumb)),
        matchesSemantics(label: 'Home', hasEnabledState: true),
      );
    });
  });
}
