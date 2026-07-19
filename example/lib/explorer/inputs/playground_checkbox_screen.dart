import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

/// A live playground for [GHAppCheckbox]: pick a size and toggle
/// checked/disabled, with a spec string reflecting the choice.
class CheckboxPlaygroundScreen extends StatefulWidget {
  const CheckboxPlaygroundScreen({super.key});

  @override
  State<CheckboxPlaygroundScreen> createState() => _CheckboxPlaygroundScreenState();
}

class _CheckboxPlaygroundScreenState extends State<CheckboxPlaygroundScreen> {
  CheckboxSize _size = CheckboxSize.small;
  bool _checked = true;
  bool _disabled = false;

  void _reset() {
    setState(() {
      _size = CheckboxSize.small;
      _checked = true;
      _disabled = false;
    });
  }

  String get _spec {
    final parts = <String>['value: $_checked', 'size: ${_size.name}'];
    if (_disabled) parts.add('onChanged: null');
    return 'GHAppCheckbox(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Checkbox',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppCheckbox(
              value: _checked,
              size: _size,
              onChanged: _disabled ? null : (v) => setState(() => _checked = v),
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SIZE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<CheckboxSize>(
            selected: _size,
            onSelected: (v) => setState(() => _size = v),
            options: const [
              SegmentedPickerOption(value: CheckboxSize.small, label: 'Small'),
              SegmentedPickerOption(value: CheckboxSize.medium, label: 'Medium'),
              SegmentedPickerOption(value: CheckboxSize.large, label: 'Large'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('STATE'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Checked',
            subtitle: 'Current value passed to the checkbox',
            value: _checked,
            onChanged: (v) => setState(() => _checked = v),
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
