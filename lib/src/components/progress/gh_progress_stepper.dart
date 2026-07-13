import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/components/icons/heroicon_style.dart';
import 'package:ngh09_ui_kit/src/components/progress/gh_progress_step.dart';
import 'package:ngh09_ui_kit/src/components/progress/progress_step_indicator.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A horizontal row of pre-defined steps showing which are completed, which
/// is current, and which are still pending — per the Finesse UI Kit spec.
///
/// Steps before [currentStep] render as completed, the step at [currentStep]
/// renders as current, and the rest render as pending.
///
/// ```dart
/// GHProgressStepper(
///   steps: const [
///     GHProgressStep(label: 'Home'),
///     GHProgressStep(label: 'Settings'),
///     GHProgressStep(label: 'Account'),
///   ],
///   currentStep: 2,
/// );
/// ```
class GHProgressStepper extends StatelessWidget {
  /// Creates a stepper for [steps], currently on [currentStep] (1-indexed).
  ///
  /// Not `const` — [currentStep] and per-step field presence are validated
  /// against [steps] at construction time, which Dart's const evaluator
  /// cannot check for a `List`.
  GHProgressStepper({
    required this.steps,
    required this.currentStep,
    this.indicator = GHProgressStepIndicator.number,
    this.showLabels = false,
    super.key,
  }) : assert(steps.isNotEmpty, 'GHProgressStepper needs at least one step.'),
       assert(currentStep >= 1 && currentStep <= steps.length, 'currentStep must be within [1, steps.length].'),
       assert(
         indicator != GHProgressStepIndicator.icon || steps.every((s) => s.icon != null),
         'Every step needs an icon when indicator is GHProgressStepIndicator.icon.',
       ),
       assert(!showLabels || steps.every((s) => s.label != null), 'Every step needs a label when showLabels is true.'),
       assert(indicator != GHProgressStepIndicator.chip || !showLabels, 'Chip indicators do not support labels.');

  /// The steps to display, in order.
  final List<GHProgressStep> steps;

  /// The active step, 1-indexed.
  final int currentStep;

  /// The visual content of each step node.
  final GHProgressStepIndicator indicator;

  /// Whether each step's label is shown beside its node.
  ///
  /// Ignored (and must be `false`) when [indicator] is
  /// [GHProgressStepIndicator.chip].
  final bool showLabels;

  _StepState _stateOf(int index) {
    final stepNumber = index + 1;
    if (stepNumber < currentStep) return _StepState.completed;
    if (stepNumber == currentStep) return _StepState.current;
    return _StepState.pending;
  }

  @override
  Widget build(BuildContext context) {
    if (indicator == GHProgressStepIndicator.chip) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: context.spacing.sm,
          children: [for (var i = 0; i < steps.length; i++) _StepChip(state: _stateOf(i))],
        ),
      );
    }

    final children = <Widget>[];
    for (var i = 0; i < steps.length; i++) {
      final state = _stateOf(i);
      children.add(_StepNode(step: steps[i], index: i, state: state, indicator: indicator));
      if (showLabels) children.addAll([SizedBox(width: context.spacing.xs), Text(steps[i].label!, style: _labelStyle(context, state))]);
      if (i != steps.length - 1) {
        children.add(showLabels ? SizedBox(width: context.spacing.lg, child: _connector(context)) : Expanded(child: _connector(context)));
      }
    }

    // Labeled steppers size to their content and can exceed the available
    // width; let them scroll horizontally. Unlabeled steppers use Expanded
    // connectors to fill the width, so they never overflow.
    if (showLabels) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(mainAxisSize: MainAxisSize.min, children: children),
      );
    }

    return Row(children: children);
  }

  Widget _connector(BuildContext context) => Container(height: 2, color: context.colors.surfaceVariant);

  TextStyle _labelStyle(BuildContext context, _StepState state) {
    final color = state == _StepState.pending ? context.colors.onSurfaceVariant : context.colors.onSurface;
    return context.textStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700, color: color);
  }
}

enum _StepState { pending, current, completed }

/// A circular step node showing a number or icon glyph.
class _StepNode extends StatelessWidget {
  const _StepNode({required this.step, required this.index, required this.state, required this.indicator});

  final GHProgressStep step;
  final int index;
  final _StepState state;
  final GHProgressStepIndicator indicator;

  static const double _size = 32;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final Color fill;
    final Color content;
    final Border? border;
    switch (state) {
      case _StepState.pending:
        fill = colors.surfaceVariant;
        content = colors.onSurfaceVariant;
        border = null;
      case _StepState.current:
        fill = colors.surface;
        content = colors.onSurface;
        border = Border.all(color: colors.onSurface, width: 1.5);
      case _StepState.completed:
        fill = colors.onSurface;
        content = colors.surface;
        border = null;
    }

    final Widget glyph = indicator == GHProgressStepIndicator.icon
        ? GHHeroIcon(state == _StepState.completed ? GHIcons.check : step.icon!, style: HeroIconStyle.mini, size: 16, color: content)
        : Text(
            '${index + 1}',
            style: context.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w700, color: content),
          );

    return Semantics(
      label: step.label ?? 'Step ${index + 1}',
      selected: state == _StepState.current,
      child: AnimatedContainer(
        duration: DurationTokens.fast,
        width: _size,
        height: _size,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: fill, shape: BoxShape.circle, border: border),
        child: ExcludeSemantics(child: glyph),
      ),
    );
  }
}

/// A pill-shaped step node, used when no step labels are shown.
class _StepChip extends StatelessWidget {
  const _StepChip({required this.state});

  final _StepState state;

  static const double _width = 40;
  static const double _height = 6;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final Color fill;
    final Border? border;
    switch (state) {
      case _StepState.pending:
        fill = colors.surfaceVariant;
        border = null;
      case _StepState.current:
        fill = colors.surface;
        border = Border.all(color: colors.outline, width: 1.5);
      case _StepState.completed:
        fill = colors.onSurface;
        border = null;
    }

    return AnimatedContainer(
      duration: DurationTokens.fast,
      width: _width,
      height: _height,
      decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(_height / 2), border: border),
    );
  }
}
