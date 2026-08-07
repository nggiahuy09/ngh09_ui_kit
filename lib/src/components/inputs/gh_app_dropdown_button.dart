import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/components/icons/heroicon_style.dart';
import 'package:ngh09_ui_kit/src/components/inputs/dropdown_trailing_type.dart';
import 'package:ngh09_ui_kit/src/components/inputs/gh_app_dropdown.dart';
import 'package:ngh09_ui_kit/src/components/inputs/gh_app_dropdown_list.dart';
import 'package:ngh09_ui_kit/src/components/inputs/gh_app_dropdown_list_item.dart';
import 'package:ngh09_ui_kit/src/components/inputs/gh_dropdown_menu_item.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/tokens/shadows.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// An interactive, menu-backed select control — the Finesse UI Kit "Dropdowns" spec paired with an anchored, openable trigger.
///
/// `GHAppDropdownButton<T>` renders a field-shaped trigger showing the selected [items] entry's label (or [placeholder] when [value] is `null`). Tapping it opens a `GHAppDropdown` menu directly below, anchored to the trigger's width; picking a row calls [onChanged] and closes the menu.
///  Tapping outside the menu also closes it.
///
/// ```dart
/// GHAppDropdownButton<String>(
///   value: _country,
///   placeholder: 'Select a country',
///   items: const [
///     GHDropdownMenuItem(value: 'us', label: 'United States'),
///     GHDropdownMenuItem(value: 'uk', label: 'United Kingdom'),
///   ],
///   onChanged: (v) => setState(() => _country = v),
/// );
/// ```
///
/// The control is disabled when [onChanged] is `null`.
class GHAppDropdownButton<T> extends StatefulWidget {
  /// Creates a dropdown select button over [items].
  ///
  /// Not a `const` constructor: [items].length must be validated at runtime, which Dart's const evaluator cannot do for a `List`.
  GHAppDropdownButton({required this.items, required this.onChanged, this.value, this.placeholder = 'Select', this.width, super.key})
    : assert(items.isNotEmpty, 'GHAppDropdownButton needs at least one item.');

  /// The selectable options, in order.
  final List<GHDropdownMenuItem<T>> items;

  /// The currently selected value, or `null` when nothing is selected.
  final T? value;

  /// Called with the tapped item's value when the user picks an option.
  ///
  /// When `null`, the control is disabled and does not open.
  final ValueChanged<T>? onChanged;

  /// Text shown in the trigger when [value] is `null`.
  final String placeholder;

  /// A fixed width for the trigger and menu. When `null`, the trigger sizes to its parent's constraints and the menu matches the trigger's measured width.
  final double? width;

  @override
  State<GHAppDropdownButton<T>> createState() => _GHAppDropdownButtonState<T>();
}

class _GHAppDropdownButtonState<T> extends State<GHAppDropdownButton<T>> {
  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _link = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();
  bool _hovered = false;
  bool _focused = false;
  double? _measuredWidth;

  bool get _isEnabled => widget.onChanged != null;

  GHDropdownMenuItem<T>? get _selected {
    for (final item in widget.items) {
      if (item.value == widget.value) return item;
    }
    return null;
  }

  void _open() {
    if (!_isEnabled || _overlayController.isShowing) return;
    final box = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    _measuredWidth = box?.size.width;
    _overlayController.show();
    setState(() {});
  }

  void _close() {
    if (_overlayController.isShowing) _overlayController.hide();
  }

  void _toggle() => _overlayController.isShowing ? _close() : _open();

  void _handleSelect(T value) {
    widget.onChanged?.call(value);
    _close();
  }

  KeyEventResult _handleKeyEvent(FocusNode _, KeyEvent event) {
    if (!_isEnabled) return KeyEventResult.ignored;
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space || event.logicalKey == LogicalKeyboardKey.enter) {
        _toggle();
        return KeyEventResult.handled;
      }
      if (event.logicalKey == LogicalKeyboardKey.escape && _overlayController.isShowing) {
        _close();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  List<BoxShadow> _shadow(BuildContext context) {
    if (!_isEnabled) return ShadowTokens.medium;
    final shadows = context.shadows;
    if (_focused || _overlayController.isShowing) return shadows.focusSecondary;
    if (_hovered) return shadows.hoverPrimary;
    return ShadowTokens.medium;
  }

  Widget _buildMenu(BuildContext context) {
    final rows = [
      for (final item in widget.items)
        GHAppDropdownListItem(
          label: item.label,
          supportingText: item.supportingText,
          leadingType: item.leadingType,
          leadingIcon: item.leadingIcon,
          leading: item.leading,
          trailingType: GHDropdownTrailingType.checkmark,
          selected: item.value == widget.value,
          onTap: item.disabled ? null : () => _handleSelect(item.value),
        ),
    ];

    return GHAppDropdown(
      width: widget.width ?? _measuredWidth,
      sections: [GHAppDropdownList(items: rows)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;
    final selected = _selected;
    final valueColor = _isEnabled ? ColorTokens.gray900 : ColorTokens.gray400;

    final trigger = AnimatedContainer(
      key: _triggerKey,
      duration: DurationTokens.fast,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _isEnabled ? ColorTokens.white : ColorTokens.gray100,
        borderRadius: context.radii.borderRadiusMd,
        boxShadow: _shadow(context),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              selected?.label ?? widget.placeholder,
              overflow: TextOverflow.ellipsis,
              style: textStyles.bodyMedium.copyWith(color: selected == null ? ColorTokens.gray400 : valueColor),
            ),
          ),
          const SizedBox(width: 8),
          AnimatedRotation(
            duration: DurationTokens.fast,
            turns: _overlayController.isShowing ? 0.5 : 0,
            child: GHHeroIcon(
              GHIcons.chevronDown,
              style: HeroIconStyle.mini,
              size: 18,
              color: _isEnabled ? ColorTokens.gray500 : ColorTokens.gray300,
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
              onTapOutside: (_) => _close(),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(padding: const EdgeInsets.only(top: 4), child: _buildMenu(context)),
              ),
            ),
          );
        },
        child: TapRegion(
          groupId: this,
          child: Semantics(
            button: true,
            enabled: _isEnabled,
            label: selected?.label ?? widget.placeholder,
            onTap: _isEnabled ? _toggle : null,
            child: Focus(
              onKeyEvent: _handleKeyEvent,
              onFocusChange: (hasFocus) => setState(() => _focused = hasFocus),
              child: MouseRegion(
                cursor: _isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: GestureDetector(
                  onTap: _isEnabled ? _toggle : null,
                  behavior: HitTestBehavior.opaque,
                  child: ExcludeSemantics(child: trigger),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
