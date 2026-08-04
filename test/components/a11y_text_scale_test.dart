import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

import '../helpers/a11y_harness.dart';

/// Text-scale and narrow-constraint accessibility coverage.
///
/// `UI_KIT_RULES.md` §8.4 requires every component to render at
/// `TextScaler.linear(2.0)`, and the "Done" checklist (§14) requires it to
/// survive a 320px-wide constraint. Those two cases were previously asserted
/// nowhere in the suite, so this file covers the text-bearing components
/// centrally rather than duplicating the checks across 43 per-component files.
///
/// Each component is exercised three ways:
///  1. text scale 2.0 at the default width,
///  2. a 320px-wide constraint at the default text scale,
///  3. both at once — the worst case.
void main() {
  // Every entry is a text-bearing component: the ones that can actually
  // overflow when the glyphs double in size.
  final cases = <String, Widget Function()>{
    'GHAppButton': () => GHAppButton(label: 'Save changes', onPressed: () {}),
    'GHAppButton.expanded': () => GHAppButton(label: 'Save changes now', expanded: true, onPressed: () {}),
    'GHAppButton with icons': () => GHAppButton(
      label: 'Continue to checkout',
      leading: const Icon(Icons.star),
      trailing: const Icon(Icons.arrow_forward),
      onPressed: () {},
    ),
    'GHAppButton loading': () => GHAppButton(label: 'Submitting order', isLoading: true, onPressed: () {}),
    'GHAppBadge': () => const GHAppBadge(label: 'In progress'),
    'GHAppChip': () => GHAppChip(label: 'Filter by category', onPressed: () {}),
    'GHAppAlert': () => const GHAppAlert(
      headline: 'Your subscription is expiring soon',
      supportingText: 'Renew before the end of the month to keep access to every feature.',
    ),
    'GHBreadcrumbs': () => GHBreadcrumbs(
      items: const [
        GHBreadcrumbItem(label: 'Dashboard'),
        GHBreadcrumbItem(label: 'Settings'),
        GHBreadcrumbItem(label: 'Billing history'),
      ],
    ),
    'GHAppSegmentedControl': () => GHAppSegmentedControl(
      segments: const [
        GHSegmentedControlItem(label: 'Overview'),
        GHSegmentedControlItem(label: 'Details'),
      ],
      selectedIndex: 0,
      onSelectedIndexChanged: (_) {},
    ),
    'GHProgressStepper': () => GHProgressStepper(
      steps: const [
        GHProgressStep(label: 'Cart'),
        GHProgressStep(label: 'Shipping address'),
        GHProgressStep(label: 'Payment'),
      ],
      currentStep: 2,
      showLabels: true,
    ),
  };

  group('renders at text scale ${kMaxTextScale}x without overflowing', () {
    cases.forEach((name, build) {
      testWidgets(name, (tester) async {
        await tester.pumpWidget(a11yHarness(build(), textScale: kMaxTextScale));
        expectNoOverflow(tester, reason: '$name overflowed at text scale $kMaxTextScale');
      });
    });
  });

  group('renders in a ${kNarrowWidth.toInt()}px-wide constraint', () {
    cases.forEach((name, build) {
      testWidgets(name, (tester) async {
        await tester.pumpWidget(a11yHarness(build(), maxWidth: kNarrowWidth));
        expectNoOverflow(tester, reason: '$name overflowed at ${kNarrowWidth.toInt()}px wide');
      });
    });
  });

  group('renders at text scale ${kMaxTextScale}x AND ${kNarrowWidth.toInt()}px wide', () {
    cases.forEach((name, build) {
      testWidgets(name, (tester) async {
        await tester.pumpWidget(
          a11yHarness(build(), maxWidth: kNarrowWidth, textScale: kMaxTextScale),
        );
        expectNoOverflow(
          tester,
          reason: '$name overflowed at text scale $kMaxTextScale in ${kNarrowWidth.toInt()}px',
        );
      });
    });
  });

  group('dark mode holds up under the same pressure', () {
    cases.forEach((name, build) {
      testWidgets(name, (tester) async {
        await tester.pumpWidget(
          a11yHarness(
            build(),
            brightness: Brightness.dark,
            maxWidth: kNarrowWidth,
            textScale: kMaxTextScale,
          ),
        );
        expectNoOverflow(tester, reason: '$name overflowed in dark mode under pressure');
      });
    });
  });

  group('text actually scales', () {
    testWidgets('GHAppButton label grows with the scaler', (tester) async {
      await tester.pumpWidget(a11yHarness(GHAppButton(label: 'Save', onPressed: () {})));
      final baseline = tester.getSize(find.text('Save')).height;

      await tester.pumpWidget(
        a11yHarness(GHAppButton(label: 'Save', onPressed: () {}), textScale: kMaxTextScale),
      );
      final scaled = tester.getSize(find.text('Save')).height;

      // Guards against the harness silently not applying the scaler at all,
      // which would make every overflow assertion above vacuous.
      expect(scaled, greaterThan(baseline));
    });
  });
}
