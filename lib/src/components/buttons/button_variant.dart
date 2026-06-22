/// The visual emphasis of an `GHAppButton`.
///
/// Variants map to the Material 3 button hierarchy but are resolved against the
/// kit's semantic color roles (`context.colors`) rather than the raw
/// `ColorScheme`, so re-theming the kit re-themes every button.
enum ButtonVariant {
  /// Highest emphasis: solid `primary` fill with `onPrimary` content.
  filled,

  /// Medium emphasis: tonal `primaryContainer` fill with `onPrimaryContainer`
  /// content.
  tonal,

  /// Medium emphasis: transparent fill with an `outline` border and `primary`
  /// content.
  outlined,

  /// Lowest emphasis: no fill or border, `primary` content only.
  text,
}

/// The size of an `GHAppButton`, controlling height, padding and label style.
enum ButtonSize {
  /// Compact button — for dense layouts and secondary actions.
  small,

  /// Default button size.
  medium,

  /// Prominent button — for primary calls to action.
  large,
}
