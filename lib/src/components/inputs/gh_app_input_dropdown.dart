import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/components/icons/heroicon_style.dart';
import 'package:ngh09_ui_kit/src/components/inputs/gh_app_dropdown.dart';
import 'package:ngh09_ui_kit/src/components/inputs/gh_app_dropdown_list.dart';
import 'package:ngh09_ui_kit/src/components/inputs/gh_app_dropdown_list_item.dart';
import 'package:ngh09_ui_kit/src/components/inputs/gh_dropdown_menu_item.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/tokens/shadows.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A search-driven select control — the Finesse UI Kit "Input Dropdowns"
/// spec, combining a search-style text field trigger with an anchored
/// `GHAppDropdown` menu.
///
/// `GHAppInputDropdown<T>` shows a text field with a fixed leading
/// magnifying-glass icon and a trailing chevron. Focusing it opens the menu
/// below; when [searchable] is `true` (the default), typing filters [items]
/// by a case-insensitive substring match on their label. Picking a row calls
/// [onChanged], fills the field with the picked label, and closes the menu.
///
/// ```dart
/// GHAppInputDropdown<String>(
///   placeholder: 'Select Work Area',
///   items: const [
///     GHDropdownMenuItem(value: 'healthcare', label: 'Healthcare'),
///     GHDropdownMenuItem(value: 'fintech', label: 'Fintech'),
///   ],
///   onChanged: (v) => setState(() => _workArea = v),
/// );
/// ```
///
/// The control is disabled when [onChanged] is `null`.
class GHAppInputDropdown<T> extends StatefulWidget {
  /// Creates a searchable dropdown select over [items].
  ///
  /// Not a `const` constructor: [items].length must be validated at runtime,
  /// which Dart's const evaluator cannot do for a `List`.
  GHAppInputDropdown({
    required this.items,
    required this.onChanged,
    this.placeholder = 'Search',
    this.searchable = true,
    this.width,
    this.menuMaxHeight,
    super.key,
  }) : assert(items.isNotEmpty, 'GHAppInputDropdown needs at least one item.');

  /// The selectable options, in order.
  final List<GHDropdownMenuItem<T>> items;

  /// Called with the picked item's value when the user selects an option.
  ///
  /// When `null`, the control is disabled and does not open.
  final ValueChanged<T>? onChanged;

  /// Placeholder shown while the field is empty.
  final String placeholder;

  /// Whether typing filters [items] by label. When `false`, the field is
  /// read-only and acts purely as a menu trigger.
  final bool searchable;

  /// A fixed width for the field and menu. When `null`, the field sizes to
  /// its parent's constraints and the menu matches the field's measured
  /// width.
  final double? width;

  /// The maximum height of the opened menu. When the items exceed this, the
  /// menu becomes vertically scrollable. When `null`, the menu grows to fit
  /// all items.
  final double? menuMaxHeight;

  @override
  State<GHAppInputDropdown<T>> createState() => _GHAppInputDropdownState<T>();
}

class _GHAppInputDropdownState<T> extends State<GHAppInputDropdown<T>> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _link = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();
  bool _hovered = false;
  double? _measuredWidth;

  bool get _isEnabled => widget.onChanged != null;

  List<GHDropdownMenuItem<T>> get _filtered {
    if (!widget.searchable) return widget.items;
    final query = _controller.text.trim().toLowerCase();
    if (query.isEmpty) return widget.items;
    return widget.items.where((item) => item.label.toLowerCase().contains(query)).toList();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    _focusNode.hasFocus ? _open() : _close();
    if (mounted) setState(() {});
  }

  void _open() {
    if (!_isEnabled || _overlayController.isShowing) return;
    final box = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    _measuredWidth = box?.size.width;
    _overlayController.show();
  }

  void _close() {
    if (_overlayController.isShowing) _overlayController.hide();
  }

  void _handleChevronTap() {
    if (!_isEnabled) return;
    _focusNode.hasFocus ? _focusNode.unfocus() : _focusNode.requestFocus();
  }

  void _handleSelect(GHDropdownMenuItem<T> item) {
    widget.onChanged?.call(item.value);
    if (widget.searchable) {
      _controller.value = TextEditingValue(
        text: item.label,
        selection: TextSelection.collapsed(offset: item.label.length),
      );
    }
    _focusNode.unfocus();
  }

  List<BoxShadow> _shadow(BuildContext context) {
    if (!_isEnabled) return ShadowTokens.medium;
    final shadows = context.shadows;
    if (_focusNode.hasFocus) return shadows.focusSecondary;
    if (_hovered) return shadows.hoverPrimary;
    return ShadowTokens.medium;
  }

  Widget _buildMenu(BuildContext context) {
    final filtered = _filtered;
    final rows = filtered.isEmpty
        ? [const GHAppDropdownListItem(label: 'No results')]
        : [
            for (final item in filtered)
              GHAppDropdownListItem(
                label: item.label,
                supportingText: item.supportingText,
                leadingType: item.leadingType,
                leadingIcon: item.leadingIcon,
                leading: item.leading,
                onTap: item.disabled ? null : () => _handleSelect(item),
              ),
          ];

    return GHAppDropdown(
      width: widget.width ?? _measuredWidth,
      maxHeight: widget.menuMaxHeight,
      sections: [GHAppDropdownList(items: rows)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;
    final colors = context.colors;
    final valueColor = _isEnabled ? colors.onSurface : colors.outline;
    final iconColor = _isEnabled ? colors.onSurfaceVariant : colors.outlineVariant;

    final field = AnimatedContainer(
      key: _triggerKey,
      duration: DurationTokens.fast,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _isEnabled ? colors.surface : colors.surfaceVariant,
        borderRadius: context.radii.borderRadiusMd,
        boxShadow: _shadow(context),
      ),
      child: Row(
        children: [
          GHHeroIcon(GHIcons.magnifyingGlass, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: _isEnabled,
              readOnly: !widget.searchable,
              onChanged: (_) => setState(() {}),
              cursorColor: colors.onSurface,
              style: textStyles.bodyMedium.copyWith(color: valueColor),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: textStyles.bodyMedium.copyWith(color: colors.onSurfaceVariant),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _handleChevronTap,
            behavior: HitTestBehavior.opaque,
            child: AnimatedRotation(
              duration: DurationTokens.fast,
              turns: _overlayController.isShowing ? 0.5 : 0,
              child: GHHeroIcon(GHIcons.chevronDown, style: HeroIconStyle.mini, size: 18, color: iconColor),
            ),
          ),
        ],
      ),
    );

    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: _link,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            child: TapRegion(
              groupId: this,
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: _buildMenu(context),
                ),
              ),
            ),
          );
        },
        child: TapRegion(
          groupId: this,
          onTapOutside: (_) => _focusNode.unfocus(),
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: field,
          ),
        ),
      ),
    );
  }
}
