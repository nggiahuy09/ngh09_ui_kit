import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: GHAppTheme.light(),
  home: Scaffold(body: Center(child: SizedBox(width: 300, child: child))),
);

// With a 300dp track and the 20dp handle, a handle's center sits at
// `fraction * (300 - 20) + 10` from the track's left edge.
const double _startHandleX = 0.25 * 280 + 10; // 80
const double _endHandleX = 0.75 * 280 + 10; // 220

void main() {
  group('GHAppRangeSlider', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_wrap(GHAppRangeSlider(values: const RangeValues(25, 75), onChanged: (_) {})));
      expect(find.byType(GHAppRangeSlider), findsOneWidget);
    });

    testWidgets('dragging the start handle moves it without crossing the end handle', (tester) async {
      RangeValues? received;
      await tester.pumpWidget(
        _wrap(GHAppRangeSlider(values: const RangeValues(25, 75), onChanged: (v) => received = v)),
      );

      final topLeft = tester.getTopLeft(find.byType(GHAppRangeSlider));
      await tester.dragFrom(topLeft + const Offset(_startHandleX, 10), const Offset(400, 0));
      await tester.pump();

      expect(received, isNotNull);
      expect(received!.start, closeTo(received!.end, 0.5));
    });

    testWidgets('dragging the end handle moves it without crossing the start handle', (tester) async {
      RangeValues? received;
      await tester.pumpWidget(
        _wrap(GHAppRangeSlider(values: const RangeValues(25, 75), onChanged: (v) => received = v)),
      );

      final topLeft = tester.getTopLeft(find.byType(GHAppRangeSlider));
      await tester.dragFrom(topLeft + const Offset(_endHandleX, 10), const Offset(-400, 0));
      await tester.pump();

      expect(received, isNotNull);
      expect(received!.end, closeTo(received!.start, 0.5));
    });

    testWidgets('does not call onChanged when disabled', (tester) async {
      await tester.pumpWidget(_wrap(const GHAppRangeSlider(values: RangeValues(25, 75), onChanged: null)));
      final topLeft = tester.getTopLeft(find.byType(GHAppRangeSlider));
      await tester.dragFrom(topLeft + const Offset(_startHandleX, 10), const Offset(50, 0));
      await tester.pump();
      expect(find.byType(GHAppRangeSlider), findsOneWidget);
    });

    testWidgets('arrow keys step the focused handle', (tester) async {
      var values = const RangeValues(25, 75);
      await tester.pumpWidget(
        _wrap(
          StatefulBuilder(
            builder: (context, setState) {
              return GHAppRangeSlider(values: values, onChanged: (v) => setState(() => values = v));
            },
          ),
        ),
      );

      final topLeft = tester.getTopLeft(find.byType(GHAppRangeSlider));
      await tester.tapAt(topLeft + const Offset(_startHandleX, 10));
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(values.start, greaterThan(25));
    });

    testWidgets('renders a text label above each handle when indicator is text', (tester) async {
      await tester.pumpWidget(
        _wrap(GHAppRangeSlider(values: const RangeValues(25, 75), indicator: SliderIndicator.text, onChanged: (_) {})),
      );
      expect(find.text('25%'), findsOneWidget);
      expect(find.text('75%'), findsOneWidget);
    });

    testWidgets('exposes slider semantics for both handles', (tester) async {
      await tester.pumpWidget(_wrap(GHAppRangeSlider(values: const RangeValues(25, 75), onChanged: (_) {})));
      final sliderSemantics = tester
          .widgetList<Semantics>(find.byType(Semantics))
          .where((widget) => widget.properties.slider ?? false);
      expect(sliderSemantics, hasLength(2));
    });
  });
}
