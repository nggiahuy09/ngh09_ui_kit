import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/label_field.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

class _LinesPreset {
  const _LinesPreset({required this.label, required this.minLines, this.maxLines});

  final String label;
  final int minLines;
  final int? maxLines;
}

const _presets = [
  _LinesPreset(label: '3 lines', minLines: 3, maxLines: 3),
  _LinesPreset(label: '5 lines', minLines: 5, maxLines: 5),
  _LinesPreset(label: '3–8 lines', minLines: 3, maxLines: 8),
];

/// A live playground for [GHAppTextArea]: pick a status, a minLines/maxLines
/// preset, toggle enabled/readOnly, and edit the label, placeholder, and
/// helper text, with a spec string reflecting the choice.
class TextAreaPlaygroundScreen extends StatefulWidget {
  const TextAreaPlaygroundScreen({super.key});

  @override
  State<TextAreaPlaygroundScreen> createState() => _TextAreaPlaygroundScreenState();
}

class _TextAreaPlaygroundScreenState extends State<TextAreaPlaygroundScreen> {
  GHAlertState _status = GHAlertState.active;
  _LinesPreset _preset = _presets[0];
  bool _enabled = true;
  bool _readOnly = false;
  final _labelController = TextEditingController(text: 'Bio');
  final _placeholderController = TextEditingController(text: 'Tell us about yourself');
  final _helperTextController = TextEditingController(text: 'Max 280 characters.');

  @override
  void dispose() {
    _labelController.dispose();
    _placeholderController.dispose();
    _helperTextController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _status = GHAlertState.active;
      _preset = _presets[0];
      _enabled = true;
      _readOnly = false;
      _labelController.text = 'Bio';
      _placeholderController.text = 'Tell us about yourself';
      _helperTextController.text = 'Max 280 characters.';
    });
  }

  String get _label => _labelController.text;
  String get _placeholder => _placeholderController.text;
  String get _helperText => _helperTextController.text;

  String get _spec {
    final parts = <String>[];
    if (_label.isNotEmpty) parts.add("label: '$_label'");
    if (_placeholder.isNotEmpty) parts.add("placeholder: '$_placeholder'");
    if (_helperText.isNotEmpty) parts.add("helperText: '$_helperText'");
    if (_status != GHAlertState.active) parts.add('status: ${_status.name}');
    if (_preset.minLines != 3) parts.add('minLines: ${_preset.minLines}');
    if (_preset.maxLines != null) parts.add('maxLines: ${_preset.maxLines}');
    if (!_enabled) parts.add('enabled: false');
    if (_readOnly) parts.add('readOnly: true');
    return 'GHAppTextArea(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Text Area',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppTextArea(
              label: _label.isEmpty ? null : _label,
              placeholder: _placeholder.isEmpty ? null : _placeholder,
              helperText: _helperText.isEmpty ? null : _helperText,
              status: _status,
              minLines: _preset.minLines,
              maxLines: _preset.maxLines,
              enabled: _enabled,
              readOnly: _readOnly,
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('STATUS'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<GHAlertState>(
            selected: _status,
            onSelected: (v) => setState(() => _status = v),
            options: const [
              SegmentedPickerOption(value: GHAlertState.active, label: 'Active'),
              SegmentedPickerOption(value: GHAlertState.error, label: 'Error'),
              SegmentedPickerOption(value: GHAlertState.warning, label: 'Warning'),
              SegmentedPickerOption(value: GHAlertState.success, label: 'Success'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('LINES'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<_LinesPreset>(
            pill: true,
            selected: _preset,
            onSelected: (v) => setState(() => _preset = v),
            options: [
              for (final p in _presets) SegmentedPickerOption(value: p, label: p.label),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('OPTIONS'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Enabled',
            subtitle: 'Whether the field accepts input',
            value: _enabled,
            onChanged: (v) => setState(() => _enabled = v),
          ),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Read-only',
            subtitle: 'Field displays but blocks editing',
            value: _readOnly,
            onChanged: (v) => setState(() => _readOnly = v),
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('LABEL'),
          SizedBox(height: spacing.sm),
          LabelField(
            controller: _labelController,
            onChanged: () => setState(() {}),
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('PLACEHOLDER'),
          SizedBox(height: spacing.sm),
          LabelField(
            controller: _placeholderController,
            onChanged: () => setState(() {}),
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('HELPER TEXT'),
          SizedBox(height: spacing.sm),
          LabelField(
            controller: _helperTextController,
            onChanged: () => setState(() {}),
          ),
        ],
      ),
    );
  }
}
