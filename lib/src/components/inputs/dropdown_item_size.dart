/// The size of a `GHAppDropdownListItem`, controlling row padding and text scale.
///
/// | Finesse name | Dart value | Vertical padding | Text style   |
/// |--------------|------------|-------------------|--------------|
/// | Small        | [small]    | 8dp               | `bodySmall`  |
/// | Medium       | [medium]   | 10dp              | `bodyMedium` |
/// | Large        | [large]    | 12dp              | `bodyMedium` |
enum GHDropdownItemSize {
  /// Small row — 8dp vertical padding, `bodySmall` text.
  small,

  /// Medium row — 10dp vertical padding, `bodyMedium` text. The default.
  medium,

  /// Large row — 12dp vertical padding, `bodyMedium` text.
  large,
}
