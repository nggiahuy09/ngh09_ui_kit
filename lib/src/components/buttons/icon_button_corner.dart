import 'package:ngh09_ui_kit/src/components/buttons/button_corner.dart';
import 'package:ngh09_ui_kit/src/components/buttons/icon_button_size.dart';

/// The corner-radius shape of a `GHAppIconButton`.
///
/// Mirrors the two corner variants documented in the Finesse UI Kit for icon
/// buttons. Unlike [ButtonCorner], [smooth] does not use a single fixed
/// radius — it scales with the button's [IconButtonSize] (see the table on
/// that enum).
enum IconButtonCorner {
  /// No rounding — sharp, square corners (0 px radius) at every size.
  sharp,

  /// Rounded corners that scale with the button's size.
  smooth,
}
