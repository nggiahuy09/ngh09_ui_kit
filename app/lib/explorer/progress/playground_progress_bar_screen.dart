import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_app/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/label_field.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/spec_panel.dart';

/// A live playground for [GHProgressBar]: drag a slider to drive the value,
/// pick an indicator style, and edit the status label, with a spec string
/// reflecting the choice.
class ProgressBarPlaygroundScreen extends StatefulWidget {
  const ProgressBarPlaygroundScreen({super.key});

  @override
  State<ProgressBarPlaygroundScreen> createState() => _ProgressBarPlaygroundScreenState();
}

class _ProgressBarPlaygroundScreenState extends State<ProgressBarPlaygroundScreen> {
  double _value = 60;
  GHProgressBarIndicator _indicator = GHProgressBarIndicator.none;
  final _labelController = TextEditingController();

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _value = 60;
      _indicator = GHProgressBarIndicator.none;
      _labelController.text = '';
    });
  }

  String? get _label => _labelController.text.isEmpty ? null : _labelController.text;

  String get _spec {
    final parts = <String>['value: ${_value.toStringAsFixed(0)}'];
    if (_indicator != GHProgressBarIndicator.none) parts.add('indicator: ${_indicator.name}');
    if (_label != null) parts.add("label: '$_label'");
    return 'GHProgressBar(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Progress Bar',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHProgressBar(
              value: _value,
              indicator: _indicator,
              label: _label,
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('VALUE'),
          SizedBox(height: spacing.sm),
          Slider(
            value: _value,
            max: 100,
            divisions: 100,
            label: _value.toStringAsFixed(0),
            onChanged: (v) => setState(() => _value = v),
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('INDICATOR'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<GHProgressBarIndicator>(
            selected: _indicator,
            onSelected: (v) => setState(() => _indicator = v),
            options: const [
              SegmentedPickerOption(value: GHProgressBarIndicator.none, label: 'None'),
              SegmentedPickerOption(value: GHProgressBarIndicator.labelAndValue, label: 'Label + Value'),
              SegmentedPickerOption(value: GHProgressBarIndicator.valueOnly, label: 'Value Only'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('LABEL'),
          SizedBox(height: spacing.sm),
          LabelField(
            controller: _labelController,
            onChanged: () => setState(() {}),
          ),
        ],
      ),
    );
  }
}
