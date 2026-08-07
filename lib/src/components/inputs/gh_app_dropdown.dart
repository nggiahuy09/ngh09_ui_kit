import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/inputs/gh_app_dropdown_list.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// The floating menu surface of the Finesse UI Kit "Dropdowns" spec.
///
/// A `GHAppDropdown` is a rounded, shadowed card that stacks one or more [GHAppDropdownList] sections — the same sub-atomic composition Finesse uses to build its sample "Checklist", "Personnel" and "Menu" dropdowns.
/// Give each section a [GHAppDropdownList.showDivider] of `true` (except the last) to separate multi-section menus.
///
/// This widget only renders the surface; pairing it with an anchored, openable trigger is `GHAppDropdownButton` (or, for a search-driven trigger, `GHAppInputDropdown`). Use `GHAppDropdown` directly when you want to place a menu inline, e.g. inside a `Positioned` overlay of your own.
///
/// ```dart
/// GHAppDropdown(
///   sections: [
///     GHAppDropdownList(
///       header: 'Account',
///       showDivider: true,
///       items: [
///         GHAppDropdownListItem(label: 'Account Information', onTap: () {}),
///         GHAppDropdownListItem(label: 'Email', onTap: () {}),
///       ],
///     ),
///     GHAppDropdownList(
///       header: 'Help',
///       items: [GHAppDropdownListItem(label: 'Contact Us', onTap: () {})],
///     ),
///   ],
/// );
/// ```
class GHAppDropdown extends StatelessWidget {
  /// Creates a dropdown menu surface from one or more [sections].
  ///
  /// Not a `const` constructor: [sections].length must be validated at runtime, which Dart's const evaluator cannot do for a `List`.
  GHAppDropdown({required this.sections, this.width, super.key}) : assert(sections.isNotEmpty, 'GHAppDropdown needs at least one section.');

  /// The stacked [GHAppDropdownList] sections, top to bottom.
  final List<GHAppDropdownList> sections;

  /// A fixed width for the surface. When `null`, it hugs its content.
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: context.spacing.xs),
      decoration: BoxDecoration(color: ColorTokens.white, borderRadius: context.radii.borderRadiusMd, boxShadow: context.shadows.large),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: sections),
    );
  }
}
