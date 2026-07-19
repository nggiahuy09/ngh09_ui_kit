import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
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
  _RangePreset(label: '0–100 · step 1', min: 0, max: 100, step: 1),
  _RangePreset(label: '0–10 · step 0.5', min: 0, max: 10, step: 0.5),
  _RangePreset(label: '0–1000 · step 50', min: 0, max: 1000, step: 50),
];

/// A live playground for [GHAppSlider]: drag the real slider, swap
/// min/max/step presets, and toggle the value label and disabled state, with
/// a spec string reflecting the choice.
class SliderPlaygroundScreen extends StatefulWidget {
  const SliderPlaygroundScreen({super.key});

  @override
  State<SliderPlaygroundScreen> createState() => _SliderPlaygroundScreenState();
}

class _SliderPlaygroundScreenState extends State<SliderPlaygroundScreen> {
  _RangePreset _preset = _presets[0];
  double _value = 30;
  bool _showValueLabel = false;
  bool _disabled = false;

  void _reset() {
    setState(() {
      _preset = _presets[0];
      _value = 30;
      _showValueLabel = false;
      _disabled = false;
    });
  }

  String get _spec {
    final parts = <String>['value: ${_value.toStringAsFixed(_preset.step < 1 ? 1 : 0)}'];
    if (_preset.min != 0) parts.add('min: ${_preset.min}');
    if (_preset.max != 100) parts.add('max: ${_preset.max}');
    if (_preset.step != 1) parts.add('step: ${_preset.step}');
    if (_showValueLabel) parts.add('showValueLabel: true');
    if (_disabled) parts.add('onChanged: null');
    return 'GHAppSlider(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Slider',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppSlider(
              value: _value.clamp(_preset.min, _preset.max),
              min: _preset.min,
              max: _preset.max,
              step: _preset.step,
              showValueLabel: _showValueLabel,
              onChanged: _disabled ? null : (v) => setState(() => _value = v),
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
              _value = v.min + (v.max - v.min) / 2;
            }),
            options: [
              for (final p in _presets) SegmentedPickerOption(value: p, label: p.label),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('OPTIONS'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Show value label',
            subtitle: 'Display the current value above the thumb',
            value: _showValueLabel,
            onChanged: (v) => setState(() => _showValueLabel = v),
          ),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Disabled',
            subtitle: 'onChanged: null',
            value: _disabled,
            onChanged: (v) => setState(() => _disabled = v),
          ),
        ],
      ),
    );
  }
}
