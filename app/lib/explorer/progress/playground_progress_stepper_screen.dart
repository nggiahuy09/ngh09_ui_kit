import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

/// A live playground for [GHProgressStepper]: pick a step count, walk the
/// current step forward/back, choose an indicator style, and toggle labels,
/// with a spec string reflecting the choice.
///
/// Every generated step carries both a [GHProgressStep.label] and a
/// [GHProgressStep.icon] so the sample data satisfies
/// [GHProgressStepper]'s assertions no matter which indicator is picked
/// (icon indicator requires every step to have an icon; showing labels
/// requires every step to have one). `showLabels` is forced off whenever the
/// indicator is [GHProgressStepIndicator.chip], since chip indicators don't
/// support labels.
class ProgressStepperPlaygroundScreen extends StatefulWidget {
  const ProgressStepperPlaygroundScreen({super.key});

  @override
  State<ProgressStepperPlaygroundScreen> createState() => _ProgressStepperPlaygroundScreenState();
}

class _ProgressStepperPlaygroundScreenState extends State<ProgressStepperPlaygroundScreen> {
  static const _labels = ['Home', 'Settings', 'Account', 'Billing', 'Review'];
  static const List<GHIconData> _icons = [GHIcons.home, GHIcons.cog6Tooth, GHIcons.user, GHIcons.creditCard, GHIcons.checkCircle];

  int _stepCount = 3;
  int _currentStep = 1;
  GHProgressStepIndicator _indicator = GHProgressStepIndicator.number;
  bool _showLabels = false;

  void _reset() {
    setState(() {
      _stepCount = 3;
      _currentStep = 1;
      _indicator = GHProgressStepIndicator.number;
      _showLabels = false;
    });
  }

  List<GHProgressStep> get _steps => [
    for (var i = 0; i < _stepCount; i++) GHProgressStep(label: _labels[i], icon: _icons[i]),
  ];

  bool get _labelsAllowed => _indicator != GHProgressStepIndicator.chip;

  String get _spec {
    final parts = <String>['steps: [...$_stepCount steps]', 'currentStep: $_currentStep'];
    if (_indicator != GHProgressStepIndicator.number) parts.add('indicator: ${_indicator.name}');
    if (_showLabels && _labelsAllowed) parts.add('showLabels: true');
    return 'GHProgressStepper(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Progress Stepper',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHProgressStepper(
              steps: _steps,
              currentStep: _currentStep,
              indicator: _indicator,
              showLabels: _showLabels && _labelsAllowed,
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('STEP COUNT'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<int>(
            selected: _stepCount,
            onSelected: (v) => setState(() {
              _stepCount = v;
              if (_currentStep > _stepCount) _currentStep = _stepCount;
            }),
            options: const [
              SegmentedPickerOption(value: 3, label: '3'),
              SegmentedPickerOption(value: 4, label: '4'),
              SegmentedPickerOption(value: 5, label: '5'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('CURRENT STEP'),
          SizedBox(height: spacing.sm),
          Row(
            children: [
              IconButton(
                onPressed: _currentStep > 1 ? () => setState(() => _currentStep--) : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Text(
                  'Step $_currentStep of $_stepCount',
                  textAlign: TextAlign.center,
                  style: context.textStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: context.colors.onSurface),
                ),
              ),
              IconButton(
                onPressed: _currentStep < _stepCount ? () => setState(() => _currentStep++) : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('INDICATOR'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<GHProgressStepIndicator>(
            selected: _indicator,
            onSelected: (v) => setState(() => _indicator = v),
            options: const [
              SegmentedPickerOption(value: GHProgressStepIndicator.chip, label: 'Chip'),
              SegmentedPickerOption(value: GHProgressStepIndicator.number, label: 'Number'),
              SegmentedPickerOption(value: GHProgressStepIndicator.icon, label: 'Icon'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('LABELS'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Show labels',
            subtitle: _labelsAllowed ? "Show each step's label beside its node" : 'Not supported with the chip indicator',
            value: _showLabels && _labelsAllowed,
            onChanged: _labelsAllowed ? (v) => setState(() => _showLabels = v) : (_) {},
          ),
        ],
      ),
    );
  }
}
