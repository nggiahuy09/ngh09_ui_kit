import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

class _RangePreset {
  const _RangePreset({required this.label, required this.min, required this.max, required this.step});

  final String label;
  final double min;
  final double max;
  final double step;
}

const _presets = [
  _RangePreset(label: '0-100 · step 1', min: 0, max: 100, step: 1),
  _RangePreset(label: '0-10 · step 0.5', min: 0, max: 10, step: 0.5),
  _RangePreset(label: '0-1000 · step 50', min: 0, max: 1000, step: 50),
];

/// A live playground for [GHAppRangeSlider]: drag the real range slider, swap min/max/step presets, and pick the value indicator style, with a spec string reflecting the choice.
class RangeSliderPlaygroundScreen extends StatefulWidget {
  const RangeSliderPlaygroundScreen({super.key});

  @override
  State<RangeSliderPlaygroundScreen> createState() => _RangeSliderPlaygroundScreenState();
}

class _RangeSliderPlaygroundScreenState extends State<RangeSliderPlaygroundScreen> {
  _RangePreset _preset = _presets[0];
  RangeValues _values = const RangeValues(20, 70);
  SliderIndicator _indicator = SliderIndicator.none;

  void _reset() {
    setState(() {
      _preset = _presets[0];
      _values = const RangeValues(20, 70);
      _indicator = SliderIndicator.none;
    });
  }

  String _fmt(double v) => v.toStringAsFixed(_preset.step < 1 ? 1 : 0);

  String get _spec {
    final parts = <String>['values: RangeValues(${_fmt(_values.start)}, ${_fmt(_values.end)})'];
    if (_preset.min != 0) parts.add('min: ${_preset.min}');
    if (_preset.max != 100) parts.add('max: ${_preset.max}');
    if (_preset.step != 1) parts.add('step: ${_preset.step}');
    if (_indicator != SliderIndicator.none) parts.add('indicator: ${_indicator.name}');
    return 'GHAppRangeSlider(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Range Slider',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppRangeSlider(
              values: RangeValues(_values.start.clamp(_preset.min, _preset.max), _values.end.clamp(_preset.min, _preset.max)),
              min: _preset.min,
              max: _preset.max,
              step: _preset.step,
              indicator: _indicator,
              onChanged: (v) => setState(() => _values = v),
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('RANGE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<_RangePreset>(
            pill: true,
            selected: _preset,
            onSelected: (v) => setState(() {
              _preset = v;
              _values = RangeValues(v.min + (v.max - v.min) * 0.2, v.min + (v.max - v.min) * 0.7);
            }),
            options: [
              for (final p in _presets) SegmentedPickerOption(value: p, label: p.label),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('INDICATOR'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<SliderIndicator>(
            selected: _indicator,
            onSelected: (v) => setState(() => _indicator = v),
            options: const [
              SegmentedPickerOption(value: SliderIndicator.none, label: 'None'),
              SegmentedPickerOption(value: SliderIndicator.text, label: 'Text'),
              SegmentedPickerOption(value: SliderIndicator.tooltip, label: 'Tooltip'),
            ],
          ),
        ],
      ),
    );
  }
}
