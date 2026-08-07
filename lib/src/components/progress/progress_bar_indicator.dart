/// How a `GHProgressBar` annotates its current value.
enum GHProgressBarIndicator {
  /// No text alongside the bar — just the track and its fill.
  none,

  /// A status label (e.g. "In Progress") below the bar, opposite a percentage value.
  labelAndValue,

  /// A percentage value beside the bar, with no status label.
  valueOnly,
}
