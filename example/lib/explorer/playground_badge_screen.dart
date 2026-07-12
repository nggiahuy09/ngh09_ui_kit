import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/label_field.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

enum _BadgeLeading { none, dot, icon }

/// A live playground for [GHAppBadge]: pick a color, leading visual, and
/// corner shape, with a spec string reflecting the choice.
class BadgePlaygroundScreen extends StatefulWidget {
  const BadgePlaygroundScreen({super.key});

  @override
  State<BadgePlaygroundScreen> createState() => _BadgePlaygroundScreenState();
}

class _BadgePlaygroundScreenState extends State<BadgePlaygroundScreen> {
  BadgeColor _color = BadgeColor.success;
  _BadgeLeading _leading = _BadgeLeading.dot;
  BadgeCorner _corner = BadgeCorner.smooth;
  bool _expanded = false;
  final _labelController = TextEditingController(text: 'Live');

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _color = BadgeColor.success;
      _leading = _BadgeLeading.dot;
      _corner = BadgeCorner.smooth;
      _expanded = false;
      _labelController.text = 'Live';
    });
  }

  String get _label => _labelController.text.isEmpty ? 'Live' : _labelController.text;

  String get _spec {
    final parts = <String>['color: ${_color.name}', 'corner: ${_corner.name}'];
    if (_leading != _BadgeLeading.none) parts.add('leading: ${_leading.name}');
    if (_expanded) parts.add('expanded: true');
    return 'GHAppBadge(${parts.join(', ')})';
  }

  Widget get _badge {
    return switch (_leading) {
      _BadgeLeading.none => GHAppBadge(label: _label, color: _color, corner: _corner, expanded: _expanded),
      _BadgeLeading.dot => GHAppBadge.dot(label: _label, color: _color, corner: _corner, expanded: _expanded),
      _BadgeLeading.icon => GHAppBadge.icon(label: _label, leadingIcon: const Icon(Icons.check), color: _color, corner: _corner, expanded: _expanded),
    };
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Badges',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(child: _badge),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('COLOR'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<BadgeColor>(
            pill: true,
            selected: _color,
            onSelected: (v) => setState(() => _color = v),
            options: [
              for (final c in BadgeColor.values) SegmentedPickerOption(value: c, label: c.name),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('LEADING'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<_BadgeLeading>(
            selected: _leading,
            onSelected: (v) => setState(() => _leading = v),
            options: const [
              SegmentedPickerOption(value: _BadgeLeading.none, label: 'None'),
              SegmentedPickerOption(value: _BadgeLeading.dot, label: 'Dot'),
              SegmentedPickerOption(value: _BadgeLeading.icon, label: 'Icon'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SHAPE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<BadgeCorner>(
            selected: _corner,
            onSelected: (v) => setState(() => _corner = v),
            options: const [
              SegmentedPickerOption(value: BadgeCorner.sharp, label: 'Sharp'),
              SegmentedPickerOption(value: BadgeCorner.smooth, label: 'Smooth'),
            ],
          ),
          SizedBox(height: spacing.lg),
          OptionToggleRow(
            title: 'Expanded',
            subtitle: 'Stretch to full width',
            value: _expanded,
            onChanged: (v) => setState(() => _expanded = v),
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
