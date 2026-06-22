/// The interaction model of an `GHAppChip`.
///
/// Variants follow the Material 3 chip families but are resolved against the
/// kit's semantic color roles (`context.colors`) rather than the raw
/// `ColorScheme`, so re-theming the kit re-themes every chip.
enum ChipVariant {
  /// Represents a discrete piece of information entered by the user (e.g. a
  /// tag or recipient). Typically carries a leading avatar/icon and a trailing
  /// delete affordance (`onDeleted`).
  input,

  /// A toggleable chip used to filter content. Reflects a binary `selected`
  /// state and is the building block of a multi-select filter set.
  filter,

  /// A chip used to make a single selection from a set (radio-like). Reflects
  /// a `selected` state, usually one-of-many within a group.
  choice,
}

/// The size of an `GHAppChip`, controlling height, padding and label style.
enum ChipSize {
  /// Compact chip — for dense layouts.
  small,

  /// Default chip size.
  medium,
}
