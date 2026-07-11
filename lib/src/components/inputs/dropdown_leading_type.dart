/// The leading affordance shown at the start of a `GHAppDropdownListItem`.
///
/// Matches the Finesse UI Kit "Leading Type" property: [none], [icon],
/// [avatar], [flag] and [checkbox].
enum GHDropdownLeadingType {
  /// No leading content — the label starts flush with the item's edge.
  none,

  /// A `GHHeroIcon` glyph, supplied via `leadingIcon`.
  icon,

  /// A `GHUserAvatar`, supplied via `leading`.
  avatar,

  /// A `GHCountryFlag`, supplied via `leading`.
  flag,

  /// A `GHAppCheckbox` bound to the item's `selected` state — used by
  /// checklist-style dropdowns where tapping the row toggles membership.
  checkbox,
}
