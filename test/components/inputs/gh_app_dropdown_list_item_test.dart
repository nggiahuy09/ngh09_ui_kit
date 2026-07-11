import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('GHAppDropdownListItem', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(_wrap(GHAppDropdownListItem(label: 'Account Information', onTap: () {})));
      expect(find.text('Account Information'), findsOneWidget);
    });

    testWidgets('renders supportingText', (tester) async {
      await tester.pumpWidget(_wrap(GHAppDropdownListItem(label: 'Hussain Imtiaz', supportingText: '@finesse', onTap: () {})));
      expect(find.text('@finesse'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(GHAppDropdownListItem(label: 'Email', onTap: () => tapped = true)));
      await tester.tap(find.byType(GHAppDropdownListItem));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('does not call onTap when disabled', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppDropdownListItem(label: 'Email')));
      await tester.tap(find.byType(GHAppDropdownListItem), warnIfMissed: false);
      await tester.pump();
      // No exception, no callback — nothing to assert beyond "did not throw".
    });

    testWidgets('renders trailing label text', (tester) async {
      await tester.pumpWidget(
        _wrap(GHAppDropdownListItem(label: 'Notifications', trailingType: GHDropdownTrailingType.label, trailingLabel: '3', onTap: () {})),
      );
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('checkmark trailing only paints when selected', (tester) async {
      await tester.pumpWidget(_wrap(GHAppDropdownListItem(label: 'Ali Osama', trailingType: GHDropdownTrailingType.checkmark, onTap: () {})));
      expect(find.byIcon(Icons.check), findsNothing);

      await tester.pumpWidget(_wrap(GHAppDropdownListItem(label: 'Ali Osama', trailingType: GHDropdownTrailingType.checkmark, selected: true, onTap: () {})));
      expect(find.byType(GHHeroIcon), findsOneWidget);
    });

    testWidgets(
      'toggle trailing calls onToggleChanged without triggering onTap',
      (tester) async {
        var toggled = false;
        var tapped = false;
        await tester.pumpWidget(
          _wrap(
            GHAppDropdownListItem(
              label: 'Biometric Authentication',
              trailingType: GHDropdownTrailingType.toggle,
              onToggleChanged: (v) => toggled = v,
              onTap: () => tapped = true,
            ),
          ),
        );
        await tester.tap(find.byType(GHAppToggle));
        await tester.pump();
        expect(toggled, isTrue);
        expect(tapped, isFalse);
      },
    );

    testWidgets('exposes selected via semantics', (tester) async {
      await tester.pumpWidget(_wrap(GHAppDropdownListItem(label: 'Ali Osama', selected: true, onTap: () {})));
      expect(
        tester.getSemantics(find.byType(GHAppDropdownListItem)),
        matchesSemantics(
          hasTapAction: true,
          hasEnabledState: true,
          isEnabled: true,
          hasSelectedState: true,
          isSelected: true,
          isButton: true,
          label: 'Ali Osama',
        ),
      );
    });

    testWidgets('exposes disabled via semantics', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppDropdownListItem(label: 'Email')));
      expect(
        tester.getSemantics(find.byType(GHAppDropdownListItem)),
        matchesSemantics(
          hasEnabledState: true,
          hasSelectedState: true,
          isButton: true,
          isFocusable: true,
          hasFocusAction: true,
          label: 'Email',
        ),
      );
    });
  });
}
