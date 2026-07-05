import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: GHAppTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );
}

List<GHBreadcrumbItem> _items(int count, {void Function(int index)? onTap}) {
  return [
    for (var i = 0; i < count; i++) GHBreadcrumbItem(label: 'Item $i', icon: const Icon(Icons.circle), onTap: onTap == null ? null : () => onTap(i)),
  ];
}

void main() {
  group('GHBreadcrumbs — rendering', () {
    testWidgets('shows every crumb when at or under the collapse threshold', (tester) async {
      await tester.pumpWidget(_wrap(GHBreadcrumbs(items: _items(5))));
      for (var i = 0; i < 5; i++) {
        expect(find.text('Item $i'), findsOneWidget);
      }
      expect(find.text('...'), findsNothing);
    });

    testWidgets('collapses long trails to first, ellipsis, and last three items', (tester) async {
      await tester.pumpWidget(_wrap(GHBreadcrumbs(items: _items(6))));
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('...'), findsOneWidget);
      expect(find.text('Item 1'), findsNothing);
      expect(find.text('Item 2'), findsNothing);
      expect(find.text('Item 3'), findsOneWidget);
      expect(find.text('Item 4'), findsOneWidget);
      expect(find.text('Item 5'), findsOneWidget);
    });

    testWidgets('expands to the full trail after tapping the ellipsis', (tester) async {
      await tester.pumpWidget(_wrap(GHBreadcrumbs(items: _items(6))));
      await tester.tap(find.text('...'));
      await tester.pump();

      for (var i = 0; i < 6; i++) {
        expect(find.text('Item $i'), findsOneWidget);
      }
      expect(find.text('...'), findsNothing);
    });

    testWidgets('hides icons when type is onlyText', (tester) async {
      await tester.pumpWidget(_wrap(GHBreadcrumbs(items: _items(2), type: BreadcrumbType.onlyText)));
      expect(find.byIcon(Icons.circle), findsNothing);
      expect(find.text('Item 0'), findsOneWidget);
    });

    testWidgets('hides labels when type is onlyIcon', (tester) async {
      await tester.pumpWidget(_wrap(GHBreadcrumbs(items: _items(2), type: BreadcrumbType.onlyIcon)));
      expect(find.byIcon(Icons.circle), findsNWidgets(2));
      expect(find.text('Item 0'), findsNothing);
    });
  });

  group('GHBreadcrumbs — interactions', () {
    testWidgets('tapping an earlier crumb calls its onTap', (tester) async {
      final tapped = <int>[];
      await tester.pumpWidget(_wrap(GHBreadcrumbs(items: _items(3, onTap: tapped.add))));
      await tester.tap(find.text('Item 0'));
      expect(tapped, [0]);
    });

    testWidgets('the last (active) crumb is never tappable', (tester) async {
      final tapped = <int>[];
      await tester.pumpWidget(_wrap(GHBreadcrumbs(items: _items(3, onTap: tapped.add))));
      expect(
        tester.getSemantics(find.byType(GHCrumb).at(2)),
        matchesSemantics(label: 'Item 2', hasEnabledState: true),
      );
    });
  });
}
