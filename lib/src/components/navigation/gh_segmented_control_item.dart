import 'package:flutter/widgets.dart';

/// A single option within a `GHAppSegmentedControl`.
///
/// Provide [label], [icon], or both, matching the Finesse "Only Text",
/// "Text & Icon" and "Only Icon" segment types.
class GHSegmentedControlItem {
  /// Creates a segment option. At least one of [label] or [icon] is required.
  const GHSegmentedControlItem({this.label, this.icon}) : assert(label != null || icon != null, 'Provide a label, an icon, or both.');

  /// The segment's text, shown in the Finesse `Body/sm/Semi Bold` style.
  final String? label;

  /// The segment's icon, typically an [Icon] or `GHHeroIcon`.
  ///
  /// Rendered at 20dp when [label] is `null` (icon-only), or 16dp alongside
  /// a label.
  final Widget? icon;
}
