/// The trailing affordance shown at the end of a `GHAppDropdownListItem`.
///
/// Matches the Finesse UI Kit "Trailing Type" property: [none], [chevron],
/// [checkmark], [toggle] and [label].
enum GHDropdownTrailingType {
  /// No trailing content.
  none,

  /// A right-pointing chevron — used for rows that drill into a submenu
  /// (e.g. "Address ›").
  chevron,

  /// A checkmark shown only when the item's `selected` is `true` — used by
  /// single/multi-select "Personnel" style lists.
  checkmark,

  /// A `GHAppToggle` bound to `toggleValue`/`onToggleChanged` — used by
  /// settings-style rows (e.g. "Biometric Authentication").
  toggle,

  /// A short trailing text label, supplied via `trailingLabel`.
  label,
}
