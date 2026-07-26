/// The visual content of each node in a `GHProgressStepper`.
enum GHProgressStepIndicator {
  /// A row of plain pill segments, with no number, icon or connecting line.
  ///
  /// Used when the steps have no clear names (e.g. onboarding screens).
  chip,

  /// A circle showing the step's 1-based position.
  number,

  /// A circle showing the step's `GHProgressStep.icon`, swapped for a
  /// checkmark once the step is completed.
  icon,
}
