import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: GHAppTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );
}

const _labeledSteps = [
  GHProgressStep(label: 'Home', icon: GHIcons.home),
  GHProgressStep(label: 'Settings', icon: GHIcons.cog6Tooth),
  GHProgressStep(label: 'Account', icon: GHIcons.userCircle),
];

void main() {
  group('GHProgressStepper — construction', () {
    testWidgets('throws when currentStep is out of range', (tester) async {
      expect(() => GHProgressStepper(steps: _labeledSteps, currentStep: 0), throwsAssertionError);
      expect(() => GHProgressStepper(steps: _labeledSteps, currentStep: 4), throwsAssertionError);
    });

    testWidgets('throws when icon indicator is used without per-step icons', (tester) async {
      expect(
        () => GHProgressStepper(
          steps: const [
            GHProgressStep(label: 'A'),
            GHProgressStep(label: 'B'),
          ],
          currentStep: 1,
          indicator: GHProgressStepIndicator.icon,
        ),
        throwsAssertionError,
      );
    });

    testWidgets('throws when showLabels is used without per-step labels', (tester) async {
      expect(
        () => GHProgressStepper(steps: const [GHProgressStep(icon: GHIcons.home)], currentStep: 1, showLabels: true),
        throwsAssertionError,
      );
    });

    testWidgets('throws when chip indicator is combined with showLabels', (tester) async {
      expect(
        () => GHProgressStepper(steps: _labeledSteps, currentStep: 1, indicator: GHProgressStepIndicator.chip, showLabels: true),
        throwsAssertionError,
      );
    });
  });

  group('GHProgressStepper — rendering', () {
    testWidgets('shows a number per step for the number indicator', (tester) async {
      await tester.pumpWidget(_wrap(GHProgressStepper(steps: _labeledSteps, currentStep: 2)));
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('shows labels beside each node when showLabels is true', (tester) async {
      await tester.pumpWidget(_wrap(GHProgressStepper(steps: _labeledSteps, currentStep: 2, showLabels: true)));
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Account'), findsOneWidget);
    });

    testWidgets('renders no numbers for the chip indicator', (tester) async {
      await tester.pumpWidget(_wrap(GHProgressStepper(steps: _labeledSteps, currentStep: 2, indicator: GHProgressStepIndicator.chip)));
      expect(find.text('1'), findsNothing);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('marks only the current step node as selected in semantics', (tester) async {
      await tester.pumpWidget(_wrap(GHProgressStepper(steps: _labeledSteps, currentStep: 2, showLabels: true)));
      final nodeSemantics = tester.widgetList<Semantics>(find.byType(Semantics)).where((s) => s.properties.label == 'Settings');
      expect(nodeSemantics.single.properties.selected, isTrue);

      final homeSemantics = tester.widgetList<Semantics>(find.byType(Semantics)).where((s) => s.properties.label == 'Home');
      expect(homeSemantics.single.properties.selected, isFalse);
    });
  });
}
