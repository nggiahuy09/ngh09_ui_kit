import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/label_field.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

/// A live playground for [GHAppTextField]: pick a status, toggle obscureText/leadingIcon/enabled/readOnly, and edit the label, placeholder, and helper text, with a spec string reflecting the choice.
class TextFieldPlaygroundScreen extends StatefulWidget {
  const TextFieldPlaygroundScreen({super.key});

  @override
  State<TextFieldPlaygroundScreen> createState() => _TextFieldPlaygroundScreenState();
}

class _TextFieldPlaygroundScreenState extends State<TextFieldPlaygroundScreen> {
  GHAlertState _status = GHAlertState.active;
  bool _obscureText = false;
  bool _leadingIcon = false;
  bool _enabled = true;
  bool _readOnly = false;
  final _labelController = TextEditingController(text: 'Email');
  final _placeholderController = TextEditingController(text: 'you@example.com');
  final _helperTextController = TextEditingController(text: "We'll never share your email.");

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
      _obscureText = false;
      _leadingIcon = false;
      _enabled = true;
      _readOnly = false;
      _labelController.text = 'Email';
      _placeholderController.text = 'you@example.com';
      _helperTextController.text = "We'll never share your email.";
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
    if (_leadingIcon) parts.add('leadingIcon: Icon(Icons.search)');
    if (_status != GHAlertState.active) parts.add('status: ${_status.name}');
    if (_obscureText) parts.add('obscureText: true');
    if (!_enabled) parts.add('enabled: false');
    if (_readOnly) parts.add('readOnly: true');
    return 'GHAppTextField(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Text Field',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppTextField(
              label: _label.isEmpty ? null : _label,
              placeholder: _placeholder.isEmpty ? null : _placeholder,
              helperText: _helperText.isEmpty ? null : _helperText,
              leadingIcon: _leadingIcon ? const Icon(Icons.search) : null,
              status: _status,
              obscureText: _obscureText,
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
          const ExplorerEyebrow('OPTIONS'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Obscure text',
            subtitle: 'Hide input, e.g. for a password field',
            value: _obscureText,
            onChanged: (v) => setState(() => _obscureText = v),
          ),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Leading icon',
            subtitle: 'Icons.search before the input',
            value: _leadingIcon,
            onChanged: (v) => setState(() => _leadingIcon = v),
          ),
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
