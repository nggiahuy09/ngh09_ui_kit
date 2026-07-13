import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

/// A live playground for [GHAppToggle]: pick a size and toggle
/// on/off and disabled, with a spec string reflecting the choice.
class TogglePlaygroundScreen extends StatefulWidget {
  const TogglePlaygroundScreen({super.key});

  @override
  State<TogglePlaygroundScreen> createState() => _TogglePlaygroundScreenState();
}

class _TogglePlaygroundScreenState extends State<TogglePlaygroundScreen> {
  ToggleSize _size = ToggleSize.small;
  bool _on = true;
  bool _disabled = false;

  void _reset() {
    setState(() {
      _size = ToggleSize.small;
      _on = true;
      _disabled = false;
    });
  }

  String get _spec {
    final parts = <String>['value: $_on', 'size: ${_size.name}'];
    if (_disabled) parts.add('onChanged: null');
    return 'GHAppToggle(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Toggle',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppToggle(
              value: _on,
              size: _size,
              onChanged: _disabled ? null : (v) => setState(() => _on = v),
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SIZE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<ToggleSize>(
            selected: _size,
            onSelected: (v) => setState(() => _size = v),
            options: const [
              SegmentedPickerOption(value: ToggleSize.small, label: 'Small'),
              SegmentedPickerOption(value: ToggleSize.medium, label: 'Medium'),
              SegmentedPickerOption(value: ToggleSize.large, label: 'Large'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('STATE'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'On',
            subtitle: 'Current value passed to the toggle',
            value: _on,
            onChanged: (v) => setState(() => _on = v),
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
