import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/label_field.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

enum _ButtonState { normal, loading, disabled }

/// A live playground for [GHAppButton]: pick a variant, size, state, and toggle leading/trailing icons, with a spec string reflecting the choice.
class ButtonPlaygroundScreen extends StatefulWidget {
  const ButtonPlaygroundScreen({super.key});

  @override
  State<ButtonPlaygroundScreen> createState() => _ButtonPlaygroundScreenState();
}

class _ButtonPlaygroundScreenState extends State<ButtonPlaygroundScreen> {
  ButtonVariant _variant = ButtonVariant.filled;
  ButtonSize _size = ButtonSize.medium;
  _ButtonState _state = _ButtonState.normal;
  bool _leading = false;
  bool _trailing = false;
  final _labelController = TextEditingController(text: 'Button');

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _variant = ButtonVariant.filled;
      _size = ButtonSize.medium;
      _state = _ButtonState.normal;
      _leading = false;
      _trailing = false;
      _labelController.text = 'Button';
    });
  }

  String get _spec {
    final parts = <String>['variant: ${_variant.name}', 'size: ${_size.name}'];
    if (_leading) parts.add('leading: Icon(Icons.check)');
    if (_trailing) parts.add('trailing: Icon(Icons.arrow_forward)');
    if (_state == _ButtonState.loading) parts.add('isLoading: true');
    if (_state == _ButtonState.disabled) parts.add('onPressed: null');
    return 'GHAppButton(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Buttons',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppButton(
              label: _labelController.text.isEmpty ? 'Button' : _labelController.text,
              variant: _variant,
              size: _size,
              isLoading: _state == _ButtonState.loading,
              onPressed: _state == _ButtonState.disabled ? null : () {},
              leading: _leading ? const Icon(Icons.check) : null,
              trailing: _trailing ? const Icon(Icons.arrow_forward) : null,
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('VARIANT'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<ButtonVariant>(
            pill: true,
            selected: _variant,
            onSelected: (v) => setState(() => _variant = v),
            options: [
              for (final v in ButtonVariant.values) SegmentedPickerOption(value: v, label: v.name),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SIZE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<ButtonSize>(
            selected: _size,
            onSelected: (v) => setState(() => _size = v),
            options: const [
              SegmentedPickerOption(value: ButtonSize.extraSmall, label: 'XS'),
              SegmentedPickerOption(value: ButtonSize.small, label: 'S'),
              SegmentedPickerOption(value: ButtonSize.medium, label: 'M'),
              SegmentedPickerOption(value: ButtonSize.large, label: 'L'),
              SegmentedPickerOption(value: ButtonSize.extraLarge, label: 'XL'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('STATE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<_ButtonState>(
            selected: _state,
            onSelected: (v) => setState(() => _state = v),
            options: const [
              SegmentedPickerOption(value: _ButtonState.normal, label: 'Default'),
              SegmentedPickerOption(value: _ButtonState.loading, label: 'Loading'),
              SegmentedPickerOption(value: _ButtonState.disabled, label: 'Disabled'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('ICONS'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Leading icon',
            subtitle: 'Icons.check before the label',
            value: _leading,
            onChanged: (v) => setState(() => _leading = v),
          ),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Trailing icon',
            subtitle: 'Icons.arrowForward after the label',
            value: _trailing,
            onChanged: (v) => setState(() => _trailing = v),
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
