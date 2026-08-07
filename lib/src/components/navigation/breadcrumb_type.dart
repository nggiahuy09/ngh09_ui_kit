/// The display mode of a `GHBreadcrumbs` trail.
///
/// Controls whether each crumb shows its leading icon, its label, or both — matching the three "type" variants documented in the Finesse UI Kit.
enum BreadcrumbType {
  /// Shows both the leading icon (when provided) and the label.
  textAndIcon,

  /// Shows only the label — leading icons are hidden.
  onlyText,

  /// Shows only the leading icon — labels are hidden.
  onlyIcon,
}
