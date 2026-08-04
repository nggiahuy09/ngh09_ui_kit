import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// The largest text scale the kit is required to support without overflowing.
///
/// Mirrors the accessibility rule in `UI_KIT_RULES.md` §8.4: every component
/// must stay renderable at `TextScaler.linear(2.0)`.
const double kMaxTextScale = 2;

/// The narrowest viewport width the kit is required to support.
///
/// Mirrors the "Done" checklist item in `CLAUDE.md` / `UI_KIT_RULES.md` §14:
/// components must survive a 320px-wide constraint (the smallest common phone).
const double kNarrowWidth = 320;

/// Wraps [child] in a themed [MaterialApp], optionally scaling text and/or
/// constraining the available width.
///1
/// This is the shared accessibility harness — individual test files keep their
/// own local `_wrap` for ordinary render/interaction tests, but text-scale and
/// narrow-constraint checks go through this helper so every component is
/// exercised the same way.
///
/// ```dart
/// await tester.pumpWidget(a11yHarness(const GHAppButton(label: 'Save'), textScale: kMaxTextScale));
/// expectNoOverflow(tester);
/// ```
Widget a11yHarness(
  Widget child, {
  Brightness brightness = Brightness.light,
  double? maxWidth,
  double textScale = 1.0,
}) {
  return MaterialApp(
    theme: brightness == Brightness.light ? GHAppTheme.light() : GHAppTheme.dark(),
    home: MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
      child: Scaffold(
        // The vertical axis scrolls so a component that legitimately grows
        // taller than the 800x600 test surface at 2x text is not reported as an
        // overflow — real apps put tall content in a scroll view. Width stays
        // bounded by [maxWidth], so horizontal overflow (the failure mode that
        // actually breaks a layout) is still caught.
        body: SingleChildScrollView(
          child: Align(
            child: maxWidth == null ? child : SizedBox(width: maxWidth, child: child),
          ),
        ),
      ),
    ),
  );
}

/// Fails if the last pump produced a layout overflow (or any other exception).
///
/// Flutter reports a `RenderFlex`/`RenderBox` overflow as a thrown
/// `FlutterError` during paint, which [WidgetTester.takeException] surfaces.
/// Call this immediately after the `pumpWidget` under test.
void expectNoOverflow(WidgetTester tester, {String? reason}) {
  expect(tester.takeException(), isNull, reason: reason);
}
