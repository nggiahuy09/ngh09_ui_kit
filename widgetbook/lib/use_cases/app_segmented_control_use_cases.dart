import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppSegmentedControl].
WidgetbookComponent buildAppSegmentedControlComponent() {
  return WidgetbookComponent(
    name: 'GHAppSegmentedControl',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'Corners', builder: _cornersUseCase),
      WidgetbookUseCase(name: 'Types', builder: _typesUseCase),
      WidgetbookUseCase(name: 'States', builder: _statesUseCase),
    ],
  );
}

const _textSegments = [
  GHSegmentedControlItem(label: 'Day'),
  GHSegmentedControlItem(label: 'Week'),
  GHSegmentedControlItem(label: 'Month'),
];

const _iconTextSegments = [
  GHSegmentedControlItem(label: 'Day', icon: Icon(Icons.check_circle_outline)),
  GHSegmentedControlItem(label: 'Week', icon: Icon(Icons.check_circle_outline)),
  GHSegmentedControlItem(label: 'Month', icon: Icon(Icons.check_circle_outline)),
];

const _iconOnlySegments = [
  GHSegmentedControlItem(icon: Icon(Icons.view_list)),
  GHSegmentedControlItem(icon: Icon(Icons.grid_view)),
];

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;
  final corner = knobs.object.dropdown<SegmentedControlCorner>(
    label: 'Corner',
    options: SegmentedControlCorner.values,
    initialOption: SegmentedControlCorner.sharp,
    labelBuilder: (v) => v.name,
  );
  final disabled = knobs.boolean(label: 'Disabled');
  final selected = knobs.int.slider(label: 'Selected', initialValue: 0, min: 0, max: 2);

  return _SegmentedControlPreview(
    segments: _textSegments,
    selectedIndex: selected,
    corner: corner,
    disabled: disabled,
  );
}

Widget _cornersUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        for (final corner in SegmentedControlCorner.values) _SegmentedControlPreview(segments: _textSegments, selectedIndex: 0, corner: corner),
      ],
    ),
  );
}

Widget _typesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        _SegmentedControlPreview(segments: _textSegments, selectedIndex: 0),
        _SegmentedControlPreview(segments: _iconTextSegments, selectedIndex: 0),
        _SegmentedControlPreview(segments: _iconOnlySegments, selectedIndex: 0),
      ],
    ),
  );
}

Widget _statesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        _SegmentedControlPreview(segments: _textSegments, selectedIndex: 0),
        _SegmentedControlPreview(segments: _textSegments, selectedIndex: 1),
        _SegmentedControlPreview(segments: _textSegments, selectedIndex: 0, disabled: true),
        _SegmentedControlPreview(segments: _textSegments, selectedIndex: 1, disabled: true),
      ],
    ),
  );
}

/// A stateful wrapper so Widgetbook use cases can reflect taps immediately.
class _SegmentedControlPreview extends StatefulWidget {
  const _SegmentedControlPreview({
    required this.segments,
    required this.selectedIndex,
    this.corner = SegmentedControlCorner.sharp,
    this.disabled = false,
  });

  final List<GHSegmentedControlItem> segments;
  final int selectedIndex;
  final SegmentedControlCorner corner;
  final bool disabled;

  @override
  State<_SegmentedControlPreview> createState() => _SegmentedControlPreviewState();
}

class _SegmentedControlPreviewState extends State<_SegmentedControlPreview> {
  late int _selectedIndex = widget.selectedIndex;

  @override
  void didUpdateWidget(_SegmentedControlPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return GHAppSegmentedControl(
      segments: widget.segments,
      selectedIndex: _selectedIndex,
      corner: widget.corner,
      onSelectedIndexChanged: widget.disabled ? null : (i) => setState(() => _selectedIndex = i),
    );
  }
}
