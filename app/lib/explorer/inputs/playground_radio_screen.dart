import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_app/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/spec_panel.dart';

/// A live playground for [GHAppRadio]: pick a size and toggle
/// checked/disabled, with a spec string reflecting the choice.
class RadioPlaygroundScreen extends StatefulWidget {
  const RadioPlaygroundScreen({super.key});

  @override
  State<RadioPlaygroundScreen> createState() => _RadioPlaygroundScreenState();
}

class _RadioPlaygroundScreenState extends State<RadioPlaygroundScreen> {
  RadioSize _size = RadioSize.small;
  bool _checked = true;
  bool _disabled = false;

  void _reset() {
    setState(() {
      _size = RadioSize.small;
      _checked = true;
      _disabled = false;
    });
  }

  String get _spec {
    final parts = <String>['value: $_checked', 'size: ${_size.name}'];
    if (_disabled) parts.add('onChanged: null');
    return 'GHAppRadio(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Radio',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppRadio(
              value: _checked,
              size: _size,
              onChanged: _disabled ? null : (v) => setState(() => _checked = v),
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SIZE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<RadioSize>(
            selected: _size,
            onSelected: (v) => setState(() => _size = v),
            options: const [
              SegmentedPickerOption(value: RadioSize.small, label: 'Small'),
              SegmentedPickerOption(value: RadioSize.medium, label: 'Medium'),
              SegmentedPickerOption(value: RadioSize.large, label: 'Large'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('STATE'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Checked',
            subtitle: 'Current value passed to the radio',
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
