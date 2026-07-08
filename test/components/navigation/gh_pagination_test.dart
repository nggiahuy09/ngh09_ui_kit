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
  group('paginationRange', () {
    test('returns every page when the total fits within the visible window', () {
      expect(
        paginationRange(current: 1, total: 5, siblingCount: 1, boundaryCount: 1),
        [1, 2, 3, 4, 5],
      );
    });

    test('collapses to a single trailing ellipsis near the start', () {
      expect(
        paginationRange(current: 1, total: 10, siblingCount: 1, boundaryCount: 1),
        [1, 2, 3, 4, 5, null, 10],
      );
    });

    test('collapses to both a leading and trailing ellipsis in the middle', () {
      expect(
        paginationRange(current: 5, total: 10, siblingCount: 1, boundaryCount: 1),
        [1, null, 4, 5, 6, null, 10],
      );
    });

    test('collapses to a single leading ellipsis near the end', () {
      expect(
        paginationRange(current: 10, total: 10, siblingCount: 1, boundaryCount: 1),
        [1, null, 6, 7, 8, 9, 10],
      );
    });
  });

  group('GHPagination — rendering', () {
    testWidgets('shows a page-number chip per page when under the collapse threshold', (tester) async {
      await tester.pumpWidget(_wrap(GHPagination(currentPage: 2, totalPages: 4, onPageChanged: (_) {})));
      for (var page = 1; page <= 4; page++) {
        expect(find.text('$page'), findsOneWidget);
      }
      expect(find.text('...'), findsNothing);
    });

    testWidgets('collapses long page ranges with an ellipsis', (tester) async {
      await tester.pumpWidget(_wrap(GHPagination(currentPage: 5, totalPages: 10, onPageChanged: (_) {})));
      expect(find.text('1'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('...'), findsNWidgets(2));
      expect(find.text('3'), findsNothing);
    });

    testWidgets('shows "Page X of Y" instead of chips in simple mode', (tester) async {
      await tester.pumpWidget(_wrap(GHPagination(currentPage: 3, totalPages: 10, onPageChanged: (_) {}, type: PaginationType.simple)));
      expect(find.text('Page 3 of 10'), findsOneWidget);
      expect(find.text('1'), findsNothing);
    });

    testWidgets('shows Previous/Next labels by default', (tester) async {
      await tester.pumpWidget(_wrap(GHPagination(currentPage: 3, totalPages: 10, onPageChanged: (_) {})));
      expect(find.text('Previous'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('hides Previous/Next labels when showNavLabels is false', (tester) async {
      await tester.pumpWidget(_wrap(GHPagination(currentPage: 3, totalPages: 10, onPageChanged: (_) {}, showNavLabels: false)));
      expect(find.text('Previous'), findsNothing);
      expect(find.text('Next'), findsNothing);
    });
  });

  group('GHPagination — interactions', () {
    testWidgets('tapping a page chip reports the tapped page', (tester) async {
      final pages = <int>[];
      await tester.pumpWidget(_wrap(GHPagination(currentPage: 3, totalPages: 5, onPageChanged: pages.add)));
      await tester.tap(find.text('4'));
      expect(pages, [4]);
    });

    testWidgets('the active page chip is not tappable', (tester) async {
      final pages = <int>[];
      await tester.pumpWidget(_wrap(GHPagination(currentPage: 3, totalPages: 5, onPageChanged: pages.add)));
      await tester.tap(find.text('3'));
      expect(pages, isEmpty);
    });

    testWidgets('tapping Previous/Next moves by one page', (tester) async {
      final pages = <int>[];
      await tester.pumpWidget(_wrap(GHPagination(currentPage: 3, totalPages: 5, onPageChanged: pages.add)));
      await tester.tap(find.text('Previous'));
      await tester.tap(find.text('Next'));
      expect(pages, [2, 4]);
    });

    testWidgets('Previous is disabled on the first page', (tester) async {
      final pages = <int>[];
      await tester.pumpWidget(_wrap(GHPagination(currentPage: 1, totalPages: 5, onPageChanged: pages.add)));
      await tester.tap(find.text('Previous'), warnIfMissed: false);
      expect(pages, isEmpty);
    });

    testWidgets('Next is disabled on the last page', (tester) async {
      final pages = <int>[];
      await tester.pumpWidget(_wrap(GHPagination(currentPage: 5, totalPages: 5, onPageChanged: pages.add)));
      await tester.tap(find.text('Next'), warnIfMissed: false);
      expect(pages, isEmpty);
    });
  });
}
