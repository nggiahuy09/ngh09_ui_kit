import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_app/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/label_field.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/spec_panel.dart';

/// A live playground for [GHAppAlert]: pick a state, toggle smooth corners,
/// the leading icon, and the action button, with a spec string reflecting
/// the choice.
class AlertPlaygroundScreen extends StatefulWidget {
  const AlertPlaygroundScreen({super.key});

  @override
  State<AlertPlaygroundScreen> createState() => _AlertPlaygroundScreenState();
}

class _AlertPlaygroundScreenState extends State<AlertPlaygroundScreen> {
  GHAlertState _state = GHAlertState.active;
  bool _smooth = false;
  bool _showLeadingIcon = true;
  bool _showAction = false;
  final _headlineController = TextEditingController(text: 'Your changes were saved.');
  final _supportingController = TextEditingController();

  @override
  void dispose() {
    _headlineController.dispose();
    _supportingController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _state = GHAlertState.active;
      _smooth = false;
      _showLeadingIcon = true;
      _showAction = false;
      _headlineController.text = 'Your changes were saved.';
      _supportingController.text = '';
    });
  }

  String get _headline => _headlineController.text.isEmpty ? 'Your changes were saved.' : _headlineController.text;
  String? get _supportingText => _supportingController.text.isEmpty ? null : _supportingController.text;

  String get _spec {
    final parts = <String>["headline: '$_headline'"];
    if (_state != GHAlertState.active) parts.add('state: ${_state.name}');
    if (_supportingText != null) parts.add("supportingText: '$_supportingText'");
    if (_showAction) parts.add("actionLabel: 'Learn More', onAction: () {}");
    if (_smooth) parts.add('smooth: true');
    if (!_showLeadingIcon) parts.add('showLeadingIcon: false');
    return 'GHAppAlert(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Alerts',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppAlert(
              headline: _headline,
              state: _state,
              supportingText: _supportingText,
              onAction: _showAction ? () {} : null,
              smooth: _smooth,
              showLeadingIcon: _showLeadingIcon,
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('STATE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<GHAlertState>(
            selected: _state,
            onSelected: (v) => setState(() => _state = v),
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
            title: 'Smooth corners',
            subtitle: '8px corner radius',
            value: _smooth,
            onChanged: (v) => setState(() => _smooth = v),
          ),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Leading icon',
            subtitle: 'Show the state icon',
            value: _showLeadingIcon,
            onChanged: (v) => setState(() => _showLeadingIcon = v),
          ),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Action button',
            subtitle: 'Show the "Learn More" action link',
            value: _showAction,
            onChanged: (v) => setState(() => _showAction = v),
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
