/// The pointed-arrow (caret) shown on a `GHTooltip`, and which edge it
/// protrudes from.
///
/// Matches the Finesse UI Kit "Pointed Arrow" property: point the arrow at
/// the edge closest to whatever the tooltip is anchored to. For example, a
/// tooltip positioned above its anchor points the arrow at [bottom].
enum TooltipArrow {
  /// No arrow. The default.
  none,

  /// Arrow on the top edge, pointing up.
  top,

  /// Arrow on the bottom edge, pointing down.
  bottom,

  /// Arrow on the left edge, pointing left.
  left,

  /// Arrow on the right edge, pointing right.
  right,
}
