import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_app/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/label_field.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_app/explorer/widgets/spec_panel.dart';

/// A live playground for [GHSnackbar]: pick a state, toggle smooth corners,
/// the leading icon, and the CTA button, with a spec string reflecting the
/// choice. Includes a "Show snackbar" button that fires the configured
/// widget through a real [ScaffoldMessenger] overlay.
class SnackbarPlaygroundScreen extends StatefulWidget {
  const SnackbarPlaygroundScreen({super.key});

  @override
  State<SnackbarPlaygroundScreen> createState() => _SnackbarPlaygroundScreenState();
}

class _SnackbarPlaygroundScreenState extends State<SnackbarPlaygroundScreen> {
  GHSnackbarState _state = GHSnackbarState.active;
  bool _smooth = false;
  bool _showLeadingIcon = true;
  bool _ctaButton = false;
  final _ctaLabelController = TextEditingController(text: 'Dismiss');
  final _messageController = TextEditingController(text: 'Assist text for the user');

  @override
  void dispose() {
    _ctaLabelController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _state = GHSnackbarState.active;
      _smooth = false;
      _showLeadingIcon = true;
      _ctaButton = false;
      _ctaLabelController.text = 'Dismiss';
      _messageController.text = 'Assist text for the user';
    });
  }

  String get _message => _messageController.text.isEmpty ? 'Assist text for the user' : _messageController.text;
  String get _ctaLabel => _ctaLabelController.text.isEmpty ? 'Dismiss' : _ctaLabelController.text;

  String get _spec {
    final parts = <String>["message: '$_message'"];
    if (_state != GHSnackbarState.active) parts.add('state: ${_state.name}');
    if (_smooth) parts.add('smooth: true');
    if (!_showLeadingIcon) parts.add('showLeadingIcon: false');
    if (_ctaButton) parts.add("ctaButton: true, ctaLabel: '$_ctaLabel'");
    parts.add('onDismiss: () {}');
    return 'GHSnackbar(${parts.join(', ')})';
  }

  Widget get _snackbar {
    return GHSnackbar(
      message: _message,
      state: _state,
      smooth: _smooth,
      showLeadingIcon: _showLeadingIcon,
      ctaButton: _ctaButton,
      ctaLabel: _ctaLabel,
      onDismiss: () {},
    );
  }

  void _showRealSnackbar() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: _snackbar,
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.zero,
          duration: const Duration(seconds: 3),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Snackbars',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(child: _snackbar),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.sm),
          FilledButton(onPressed: _showRealSnackbar, child: const Text('Show snackbar')),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('STATE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<GHSnackbarState>(
            selected: _state,
            onSelected: (v) => setState(() => _state = v),
            options: const [
              SegmentedPickerOption(value: GHSnackbarState.active, label: 'Active'),
              SegmentedPickerOption(value: GHSnackbarState.error, label: 'Error'),
              SegmentedPickerOption(value: GHSnackbarState.warning, label: 'Warning'),
              SegmentedPickerOption(value: GHSnackbarState.success, label: 'Success'),
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
            title: 'CTA button',
            subtitle: '"Dismiss" text button instead of a close ✕',
            value: _ctaButton,
            onChanged: (v) => setState(() => _ctaButton = v),
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('MESSAGE'),
          SizedBox(height: spacing.sm),
          LabelField(
            controller: _messageController,
            onChanged: () => setState(() {}),
          ),
          if (_ctaButton) ...[
            SizedBox(height: spacing.lg),
            const ExplorerEyebrow('CTA LABEL'),
            SizedBox(height: spacing.sm),
            LabelField(
              controller: _ctaLabelController,
              onChanged: () => setState(() {}),
            ),
          ],
        ],
      ),
    );
  }
}
