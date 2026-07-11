import 'package:flutter/widgets.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icon_data.dart';
import 'package:ngh09_ui_kit/src/components/inputs/dropdown_leading_type.dart';

/// A single selectable option for `GHAppDropdownButton` / `GHAppInputDropdown`.
///
/// Bundles the [value] returned on selection with the display properties a
/// `GHAppDropdownListItem` needs to render the row: [label],
/// [supportingText], and a leading affordance via [leadingType] +
/// [leadingIcon] / [leading].
///
/// ```dart
/// GHDropdownMenuItem(value: 'healthcare', label: 'Healthcare');
///
/// GHDropdownMenuItem(
///   value: user.id,
///   label: user.name,
///   supportingText: '@${user.handle}',
///   leadingType: GHDropdownLeadingType.avatar,
///   leading: GHUserAvatar.initials(user.initials),
/// );
/// ```
@immutable
class GHDropdownMenuItem<T> {
  /// Creates a dropdown menu option.
  const GHDropdownMenuItem({
    required this.value,
    required this.label,
    this.supportingText,
    this.leadingType = GHDropdownLeadingType.none,
    this.leadingIcon,
    this.leading,
    this.disabled = false,
  }) : assert(leadingType != GHDropdownLeadingType.icon || leadingIcon != null, 'Provide leadingIcon when leadingType is GHDropdownLeadingType.icon.'),
       assert(
         leadingType != GHDropdownLeadingType.avatar && leadingType != GHDropdownLeadingType.flag || leading != null,
         'Provide leading when leadingType is .avatar or .flag.',
       );

  /// The value returned by `onChanged` when this option is picked.
  final T value;

  /// The option's primary text.
  final String label;

  /// Optional muted secondary text shown next to [label].
  final String? supportingText;

  /// The leading affordance. See [GHDropdownLeadingType].
  final GHDropdownLeadingType leadingType;

  /// The glyph shown when [leadingType] is [GHDropdownLeadingType.icon].
  final GHIconData? leadingIcon;

  /// The widget shown when [leadingType] is [GHDropdownLeadingType.avatar] or
  /// [GHDropdownLeadingType.flag].
  final Widget? leading;

  /// Whether this option is unselectable.
  final bool disabled;
}
