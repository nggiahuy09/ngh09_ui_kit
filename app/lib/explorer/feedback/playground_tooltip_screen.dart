import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_app/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/label_field.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/spec_panel.dart';

/// A live playground for [GHTooltip]: pick an arrow direction, size, and
/// corner shape, and toggle the close button, with a spec string reflecting
/// the choice.
class TooltipPlaygroundScreen extends StatefulWidget {
  const TooltipPlaygroundScreen({super.key});

  @override
  State<TooltipPlaygroundScreen> createState() => _TooltipPlaygroundScreenState();
}

class _TooltipPlaygroundScreenState extends State<TooltipPlaygroundScreen> {
  TooltipArrow _arrow = TooltipArrow.none;
  TooltipSize _size = TooltipSize.small;
  TooltipCorner _corner = TooltipCorner.sharp;
  bool _showCloseButton = true;
  final _headlineController = TextEditingController(text: 'Here is a tooltip');
  final _supportingController = TextEditingController();

  @override
  void dispose() {
    _headlineController.dispose();
    _supportingController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _arrow = TooltipArrow.none;
      _size = TooltipSize.small;
      _corner = TooltipCorner.sharp;
      _showCloseButton = true;
      _headlineController.text = 'Here is a tooltip';
      _supportingController.text = '';
    });
  }

  String get _headline => _headlineController.text.isEmpty ? 'Here is a tooltip' : _headlineController.text;
  String? get _supportingText => _supportingController.text.isEmpty ? null : _supportingController.text;

  String get _spec {
    final parts = <String>["headline: '$_headline'"];
    if (_supportingText != null) parts.add("supportingText: '$_supportingText'");
    if (_arrow != TooltipArrow.none) parts.add('arrow: ${_arrow.name}');
    if (_size != TooltipSize.small) parts.add('size: ${_size.name}');
    if (_corner != TooltipCorner.sharp) parts.add('corner: ${_corner.name}');
    if (!_showCloseButton) parts.add('showCloseButton: false');
    return 'GHTooltip(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Tooltips',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHTooltip(
              headline: _headline,
              supportingText: _supportingText,
              arrow: _arrow,
              size: _size,
              corner: _corner,
              showCloseButton: _showCloseButton,
              onDismiss: () {},
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('ARROW'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<TooltipArrow>(
            pill: true,
            selected: _arrow,
            onSelected: (v) => setState(() => _arrow = v),
            options: [
              for (final a in TooltipArrow.values) SegmentedPickerOption(value: a, label: a.name),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SIZE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<TooltipSize>(
            selected: _size,
            onSelected: (v) => setState(() => _size = v),
            options: const [
              SegmentedPickerOption(value: TooltipSize.small, label: 'Small'),
              SegmentedPickerOption(value: TooltipSize.medium, label: 'Medium'),
              SegmentedPickerOption(value: TooltipSize.large, label: 'Large'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('CORNER'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<TooltipCorner>(
            selected: _corner,
            onSelected: (v) => setState(() => _corner = v),
            options: const [
              SegmentedPickerOption(value: TooltipCorner.sharp, label: 'Sharp'),
              SegmentedPickerOption(value: TooltipCorner.smooth, label: 'Smooth'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('OPTIONS'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Close button',
            subtitle: 'Show the close ✕ affordance',
            value: _showCloseButton,
            onChanged: (v) => setState(() => _showCloseButton = v),
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('HEADLINE'),
          SizedBox(height: spacing.sm),
          LabelField(
            controller: _headlineController,
            onChanged: () => setState(() {}),
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SUPPORTING TEXT'),
          SizedBox(height: spacing.sm),
          LabelField(
            controller: _supportingController,
            onChanged: () => setState(() {}),
          ),
        ],
      ),
    );
  }
}
