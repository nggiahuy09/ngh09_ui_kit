import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/progress/progress_bar_indicator.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A linear progress track that fills from left to right as [value] approaches [max] — per the Finesse UI Kit spec.
///
/// The fill never fully disappears: even at `value == 0` it renders as a small rounded dot, so the bar's starting point stays visible.
///
/// Requires a bounded-width ancestor (e.g. a [SizedBox] or an [Expanded] inside a [Row]), the same constraint [LinearProgressIndicator] has.
///
/// ```dart
/// GHProgressBar(value: 60);
///
/// GHProgressBar(
///   value: 60,
///   indicator: GHProgressBarIndicator.labelAndValue,
/// );
/// ```
class GHProgressBar extends StatelessWidget {
  /// Creates a progress bar showing [value] out of [max].
  const GHProgressBar({required this.value, this.max = 100, this.indicator = GHProgressBarIndicator.none, this.label, super.key})
    : assert(max > 0, 'GHProgressBar needs a positive max.'),
      assert(value >= 0 && value <= max, 'value must be within [0, max].');

  /// The current progress, within `[0, max]`.
  final double value;

  /// The value that represents full progress. Defaults to `100`.
  final double max;

  /// How the current value is annotated alongside the bar.
  final GHProgressBarIndicator indicator;

  /// A custom status label shown when [indicator] is [GHProgressBarIndicator.labelAndValue]. When `null`, a label is derived from [value] ("Starting", "In Progress" or "Completed").
  final String? label;

  static const double _height = 6;

  double get _fraction => (value / max).clamp(0.0, 1.0);

  int get _percent => (_fraction * 100).round();

  String get _statusLabel {
    if (value <= 0) return 'Starting';
    if (value >= max) return 'Completed';
    return 'In Progress';
  }

  @override
  Widget build(BuildContext context) {
    final Widget content;
    switch (indicator) {
      case GHProgressBarIndicator.none:
        content = _buildTrack(context);
      case GHProgressBarIndicator.valueOnly:
        content = Row(
          children: [
            Expanded(child: _buildTrack(context)),
            SizedBox(width: context.spacing.sm),
            Text('$_percent%', style: _valueStyle(context)),
          ],
        );
      case GHProgressBarIndicator.labelAndValue:
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTrack(context),
            SizedBox(height: context.spacing.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label ?? _statusLabel, style: _labelStyle(context)),
                Text('$_percent%', style: _valueStyle(context)),
              ],
            ),
          ],
        );
    }

    return Semantics(
      label: label ?? _statusLabel,
      value: '$_percent%',
      child: ExcludeSemantics(child: content),
    );
  }

  Widget _buildTrack(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth;
        final fillWidth = math.min(math.max(trackWidth * _fraction, _height), trackWidth);
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: _height,
              decoration: BoxDecoration(color: context.colors.surfaceVariant, borderRadius: BorderRadius.circular(_height / 2)),
            ),
            AnimatedContainer(
              duration: DurationTokens.normal,
              curve: Curves.easeOut,
              width: fillWidth,
              height: _height,
              decoration: BoxDecoration(color: context.colors.onSurface, borderRadius: BorderRadius.circular(_height / 2)),
            ),
          ],
        );
      },
    );
  }

  TextStyle _labelStyle(BuildContext context) => context.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600, color: context.colors.onSurfaceVariant);

  TextStyle _valueStyle(BuildContext context) => context.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w700, color: context.colors.onSurface);
}
