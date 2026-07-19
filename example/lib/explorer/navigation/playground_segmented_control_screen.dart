import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

enum _SegmentMode { label, icon, both }

const _labels = ['Day', 'Week', 'Month', 'Year'];
const List<IconData> _icons = [Icons.today, Icons.view_week, Icons.calendar_view_month, Icons.calendar_today];

/// A live playground for [GHAppSegmentedControl]: pick a segment count, a
/// label/icon/both mode, and a corner shape, with a genuinely interactive
/// selection and a spec string reflecting the choice.
class SegmentedControlPlaygroundScreen extends StatefulWidget {
  const SegmentedControlPlaygroundScreen({super.key});

  @override
  State<SegmentedControlPlaygroundScreen> createState() => _SegmentedControlPlaygroundScreenState();
}

class _SegmentedControlPlaygroundScreenState extends State<SegmentedControlPlaygroundScreen> {
  int _segmentCount = 3;
  _SegmentMode _mode = _SegmentMode.label;
  SegmentedControlCorner _corner = SegmentedControlCorner.sharp;
  int _selectedIndex = 0;

  void _reset() {
    setState(() {
      _segmentCount = 3;
      _mode = _SegmentMode.label;
      _corner = SegmentedControlCorner.sharp;
      _selectedIndex = 0;
    });
  }

  List<GHSegmentedControlItem> get _segments {
    return [
      for (var i = 0; i < _segmentCount; i++)
        GHSegmentedControlItem(
          label: _mode == _SegmentMode.icon ? null : _labels[i],
          icon: _mode == _SegmentMode.label ? null : Icon(_icons[i]),
        ),
    ];
  }

  String get _spec {
    final parts = <String>['segments: <$_segmentCount items>', 'selectedIndex: $_selectedIndex', 'onSelectedIndexChanged: (i) {}'];
    if (_corner != SegmentedControlCorner.sharp) parts.add('corner: ${_corner.name}');
    return 'GHAppSegmentedControl(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Segmented Controls',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppSegmentedControl(
              segments: _segments,
              selectedIndex: _selectedIndex,
              onSelectedIndexChanged: (i) => setState(() => _selectedIndex = i),
              corner: _corner,
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SEGMENT COUNT'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<int>(
            selected: _segmentCount,
            onSelected: (v) => setState(() {
              _segmentCount = v;
              if (_selectedIndex >= _segmentCount) _selectedIndex = 0;
            }),
            options: const [
              SegmentedPickerOption(value: 2, label: '2'),
              SegmentedPickerOption(value: 3, label: '3'),
              SegmentedPickerOption(value: 4, label: '4'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('MODE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<_SegmentMode>(
            selected: _mode,
            onSelected: (v) => setState(() => _mode = v),
            options: const [
              SegmentedPickerOption(value: _SegmentMode.label, label: 'Label'),
              SegmentedPickerOption(value: _SegmentMode.icon, label: 'Icon'),
              SegmentedPickerOption(value: _SegmentMode.both, label: 'Both'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('CORNER'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<SegmentedControlCorner>(
            selected: _corner,
            onSelected: (v) => setState(() => _corner = v),
            options: const [
              SegmentedPickerOption(value: SegmentedControlCorner.sharp, label: 'Sharp'),
              SegmentedPickerOption(value: SegmentedControlCorner.smooth, label: 'Smooth'),
            ],
          ),
        ],
      ),
    );
  }
}
