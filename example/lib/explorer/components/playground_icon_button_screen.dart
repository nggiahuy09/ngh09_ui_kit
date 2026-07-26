import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

/// A live playground for [GHAppIconButton]: pick a size, corner shape, and
/// enabled state, with a spec string reflecting the choice.
class IconButtonPlaygroundScreen extends StatefulWidget {
  const IconButtonPlaygroundScreen({super.key});

  @override
  State<IconButtonPlaygroundScreen> createState() => _IconButtonPlaygroundScreenState();
}

class _IconButtonPlaygroundScreenState extends State<IconButtonPlaygroundScreen> {
  IconButtonSize _size = IconButtonSize.medium;
  IconButtonCorner _corner = IconButtonCorner.sharp;
  bool _enabled = true;

  void _reset() {
    setState(() {
      _size = IconButtonSize.medium;
      _corner = IconButtonCorner.sharp;
      _enabled = true;
    });
  }

  String get _spec {
    final parts = <String>['size: ${_size.name}', 'corner: ${_corner.name}'];
    if (!_enabled) parts.add('onPressed: null');
    return 'GHAppIconButton(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Icon Buttons',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppIconButton(
              icon: const Icon(Icons.favorite),
              size: _size,
              corner: _corner,
              onPressed: _enabled ? () {} : null,
              semanticLabel: 'Favorite',
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SIZE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<IconButtonSize>(
            pill: true,
            selected: _size,
            onSelected: (v) => setState(() => _size = v),
            options: const [
              SegmentedPickerOption(value: IconButtonSize.extraExtraSmall, label: '2XS'),
              SegmentedPickerOption(value: IconButtonSize.extraSmall, label: 'XS'),
              SegmentedPickerOption(value: IconButtonSize.small, label: 'S'),
              SegmentedPickerOption(value: IconButtonSize.medium, label: 'M'),
              SegmentedPickerOption(value: IconButtonSize.large, label: 'L'),
              SegmentedPickerOption(value: IconButtonSize.extraLarge, label: 'XL'),
              SegmentedPickerOption(value: IconButtonSize.extraExtraLarge, label: '2XL'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('CORNER'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<IconButtonCorner>(
            selected: _corner,
            onSelected: (v) => setState(() => _corner = v),
            options: const [
              SegmentedPickerOption(value: IconButtonCorner.sharp, label: 'Sharp'),
              SegmentedPickerOption(value: IconButtonCorner.smooth, label: 'Smooth'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('STATE'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Enabled',
            subtitle: 'Whether onPressed is wired up',
            value: _enabled,
            onChanged: (v) => setState(() => _enabled = v),
          ),
        ],
      ),
    );
  }
}
