import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/inputs/gh_app_dropdown_list_item.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A group of [GHAppDropdownListItem]s, per the Finesse UI Kit "Dropdown Lists" spec.
///
/// `GHAppDropdownList` is the section-level building block: it lays out [items] in a column, with an optional [header] label above them (e.g. "Account", "Marketing") and an optional bottom [showDivider] hairline — the two ways Finesse distinguishes one section from the next when a `GHAppDropdown` stacks more than one list.
///
/// ```dart
/// GHAppDropdownList(
///   header: 'Account',
///   items: [
///     GHAppDropdownListItem(label: 'Account Information', onTap: () {}),
///     GHAppDropdownListItem(label: 'Email', onTap: () {}),
///   ],
///   showDivider: true,
/// );
/// ```
class GHAppDropdownList extends StatelessWidget {
  /// Creates a dropdown list section from [items].
  const GHAppDropdownList({required this.items, this.header, this.showDivider = false, super.key});

  /// The rows shown, in order.
  final List<GHAppDropdownListItem> items;

  /// Optional section label shown above [items].
  final String? header;

  /// Whether to render a hairline divider below the section — used to separate this list from a following one inside a `GHAppDropdown`.
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null)
          Padding(
            padding: EdgeInsets.fromLTRB(spacing.smd, spacing.sm, spacing.smd, spacing.xs),
            child: Text(
              header!,
              style: context.textStyles.labelSmall.copyWith(color: ColorTokens.gray400, fontWeight: FontWeight.w600),
            ),
          ),
        ...items,
        if (showDivider)
          Padding(
            padding: EdgeInsets.symmetric(vertical: spacing.xs),
            child: Divider(height: 1, thickness: 1, color: context.colors.outlineVariant),
          ),
      ],
    );
  }
}
