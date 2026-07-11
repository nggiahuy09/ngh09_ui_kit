import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHPagination].
WidgetbookComponent buildPaginationComponent() {
  return WidgetbookComponent(
    name: 'GHPagination',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'Types', builder: _typesUseCase),
      WidgetbookUseCase(name: 'Collapsing', builder: _collapsingUseCase),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;

  final type = knobs.object.dropdown<PaginationType>(
    label: 'Type',
    options: PaginationType.values,
    labelBuilder: (t) => t.name,
  );
  final showNavLabels = knobs.boolean(label: 'Show nav labels', initialValue: true);
  final totalPages = knobs.int.slider(label: 'Total pages', initialValue: 10, min: 1);
  final currentPage = knobs.int.slider(label: 'Current page', initialValue: 3, min: 1, max: totalPages);

  return Center(
    child: GHPagination(
      currentPage: currentPage.clamp(1, totalPages),
      totalPages: totalPages,
      onPageChanged: (_) {},
      type: type,
      showNavLabels: showNavLabels,
    ),
  );
}

Widget _typesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        for (final type in PaginationType.values)
          for (final showNavLabels in [true, false])
            GHPagination(currentPage: 3, totalPages: 10, onPageChanged: (_) {}, type: type, showNavLabels: showNavLabels),
      ],
    ),
  );
}

Widget _collapsingUseCase(BuildContext context) {
  const scenarios = [(current: 1, total: 10), (current: 3, total: 10), (current: 5, total: 10), (current: 8, total: 10), (current: 10, total: 10)];

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        for (final s in scenarios) GHPagination(currentPage: s.current, totalPages: s.total, onPageChanged: (_) {}),
      ],
    ),
  );
}
