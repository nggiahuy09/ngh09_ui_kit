import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/label_field.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

/// A live playground for [GHAppChip]: pick a kind (input/filter/choice) and toggle selected/leading/dismissible/expanded/size/enabled, with a spec string reflecting the choice.
class ChipPlaygroundScreen extends StatefulWidget {
  const ChipPlaygroundScreen({super.key});

  @override
  State<ChipPlaygroundScreen> createState() => _ChipPlaygroundScreenState();
}

class _ChipPlaygroundScreenState extends State<ChipPlaygroundScreen> {
  ChipVariant _kind = ChipVariant.input;
  ChipSize _size = ChipSize.medium;
  bool _selected = true;
  bool _leading = true;
  bool _dismissible = true;
  bool _expanded = false;
  bool _enabled = true;
  final _labelController = TextEditingController(text: 'flutter');

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _kind = ChipVariant.input;
      _size = ChipSize.medium;
      _selected = true;
      _leading = true;
      _dismissible = true;
      _expanded = false;
      _enabled = true;
      _labelController.text = 'flutter';
    });
  }

  bool get _isInput => _kind == ChipVariant.input;
  String get _label => _labelController.text.isEmpty ? 'flutter' : _labelController.text;

  String get _spec {
    final parts = <String>['kind: ${_kind.name}', 'size: ${_size.name}'];
    if (!_isInput) parts.add('selected: $_selected');
    if (_leading) parts.add('leading: Icon(Icons.tag)');
    if (_isInput && _dismissible) parts.add('onDeleted: () {}');
    if (_expanded) parts.add('expanded: true');
    if (!_enabled) parts.add('enabled: false');
    return 'GHAppChip(${parts.join(', ')})';
  }

  Widget get _chip {
    final leading = _leading ? const Icon(Icons.tag) : null;
    switch (_kind) {
      case ChipVariant.filter:
        return GHAppChip.filter(
          label: _label,
          selected: _selected,
          size: _size,
          enabled: _enabled,
          leading: leading,
          expanded: _expanded,
          onSelected: (v) => setState(() => _selected = v),
        );
      case ChipVariant.choice:
        return GHAppChip.choice(
          label: _label,
          selected: _selected,
          size: _size,
          enabled: _enabled,
          leading: leading,
          expanded: _expanded,
          onSelected: (v) => setState(() => _selected = v),
        );
      case ChipVariant.input:
        return GHAppChip.input(
          label: _label,
          size: _size,
          enabled: _enabled,
          leading: leading,
          expanded: _expanded,
          onDeleted: _dismissible ? () {} : null,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Chips',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(child: _chip),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('KIND'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<ChipVariant>(
            selected: _kind,
            onSelected: (v) => setState(() => _kind = v),
            options: const [
              SegmentedPickerOption(value: ChipVariant.input, label: 'Input'),
              SegmentedPickerOption(value: ChipVariant.filter, label: 'Filter'),
              SegmentedPickerOption(value: ChipVariant.choice, label: 'Choice'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SIZE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<ChipSize>(
            selected: _size,
            onSelected: (v) => setState(() => _size = v),
            options: const [
              SegmentedPickerOption(value: ChipSize.small, label: 'Small'),
              SegmentedPickerOption(value: ChipSize.medium, label: 'Medium'),
            ],
          ),
          SizedBox(height: spacing.lg),
          if (!_isInput) ...[
            OptionToggleRow(
              title: 'Selected',
              subtitle: '${_kind == ChipVariant.filter ? 'Filter' : 'Choice'} chip active state',
              value: _selected,
              onChanged: (v) => setState(() => _selected = v),
            ),
            SizedBox(height: spacing.sm),
          ],
          OptionToggleRow(
            title: 'Leading icon',
            subtitle: 'Icons.tag before the label',
            value: _leading,
            onChanged: (v) => setState(() => _leading = v),
          ),
          if (_isInput) ...[
            SizedBox(height: spacing.sm),
            OptionToggleRow(
              title: 'Dismissible',
              subtitle: 'Show trailing close ✕',
              value: _dismissible,
              onChanged: (v) => setState(() => _dismissible = v),
            ),
          ],
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Expanded',
            subtitle: 'Stretch to full width',
            value: _expanded,
            onChanged: (v) => setState(() => _expanded = v),
          ),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Enabled',
            subtitle: 'Whether the chip reacts to input',
            value: _enabled,
            onChanged: (v) => setState(() => _enabled = v),
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('LABEL'),
          SizedBox(height: spacing.sm),
          LabelField(controller: _labelController, onChanged: () => setState(() {})),
        ],
      ),
    );
  }
}
