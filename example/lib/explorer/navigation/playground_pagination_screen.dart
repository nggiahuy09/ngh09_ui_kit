import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

/// A live playground for [GHPagination]: pick a type, total page count,
/// sibling/boundary collapsing window, and toggle nav labels, with a
/// genuinely interactive current page and a spec string reflecting the
/// choice.
class PaginationPlaygroundScreen extends StatefulWidget {
  const PaginationPlaygroundScreen({super.key});

  @override
  State<PaginationPlaygroundScreen> createState() => _PaginationPlaygroundScreenState();
}

class _PaginationPlaygroundScreenState extends State<PaginationPlaygroundScreen> {
  PaginationType _type = PaginationType.numbered;
  bool _showNavLabels = true;
  int _totalPages = 10;
  int _currentPage = 3;
  int _siblingCount = 1;
  int _boundaryCount = 1;

  void _reset() {
    setState(() {
      _type = PaginationType.numbered;
      _showNavLabels = true;
      _totalPages = 10;
      _currentPage = 3;
      _siblingCount = 1;
      _boundaryCount = 1;
    });
  }

  String get _spec {
    final parts = <String>['currentPage: $_currentPage', 'totalPages: $_totalPages', 'onPageChanged: (p) {}'];
    if (_type != PaginationType.numbered) parts.add('type: ${_type.name}');
    if (!_showNavLabels) parts.add('showNavLabels: false');
    if (_siblingCount != 1) parts.add('siblingCount: $_siblingCount');
    if (_boundaryCount != 1) parts.add('boundaryCount: $_boundaryCount');
    return 'GHPagination(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final currentPage = _currentPage.clamp(1, _totalPages);

    return ExplorerScaffold(
      title: 'Pagination',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHPagination(
              currentPage: currentPage,
              totalPages: _totalPages,
              onPageChanged: (p) => setState(() => _currentPage = p),
              type: _type,
              showNavLabels: _showNavLabels,
              siblingCount: _siblingCount,
              boundaryCount: _boundaryCount,
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('TYPE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<PaginationType>(
            selected: _type,
            onSelected: (v) => setState(() => _type = v),
            options: const [
              SegmentedPickerOption(value: PaginationType.numbered, label: 'Numbered'),
              SegmentedPickerOption(value: PaginationType.simple, label: 'Simple'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('TOTAL PAGES'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<int>(
            selected: _totalPages,
            onSelected: (v) => setState(() {
              _totalPages = v;
              if (_currentPage > _totalPages) _currentPage = _totalPages;
            }),
            options: const [
              SegmentedPickerOption(value: 5, label: '5'),
              SegmentedPickerOption(value: 10, label: '10'),
              SegmentedPickerOption(value: 20, label: '20'),
              SegmentedPickerOption(value: 50, label: '50'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SIBLING COUNT'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<int>(
            selected: _siblingCount,
            onSelected: (v) => setState(() => _siblingCount = v),
            options: const [
              SegmentedPickerOption(value: 0, label: '0'),
              SegmentedPickerOption(value: 1, label: '1'),
              SegmentedPickerOption(value: 2, label: '2'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('BOUNDARY COUNT'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<int>(
            selected: _boundaryCount,
            onSelected: (v) => setState(() => _boundaryCount = v),
            options: const [
              SegmentedPickerOption(value: 0, label: '0'),
              SegmentedPickerOption(value: 1, label: '1'),
              SegmentedPickerOption(value: 2, label: '2'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('OPTIONS'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Show nav labels',
            subtitle: '"Previous"/"Next" text vs bare arrow icons',
            value: _showNavLabels,
            onChanged: (v) => setState(() => _showNavLabels = v),
          ),
        ],
      ),
    );
  }
}
