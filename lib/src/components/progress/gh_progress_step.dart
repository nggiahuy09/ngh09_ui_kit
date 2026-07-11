import 'package:flutter/foundation.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icon_data.dart';

/// A single step in a `GHProgressStepper`.
@immutable
class GHProgressStep {
  /// Creates a step. Supply [label] when the stepper shows labels, and
  /// [icon] when the stepper's indicator is `GHProgressStepIndicator.icon`.
  const GHProgressStep({this.label, this.icon});

  /// The step's display name (e.g. "Home").
  final String? label;

  /// The glyph shown for this step when the indicator is
  /// `GHProgressStepIndicator.icon`.
  final GHIconData? icon;
}
