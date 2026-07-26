import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/components/inputs/checkbox_size.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/tokens/radii.dart';
import 'package:ngh09_ui_kit/src/tokens/shadows.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A themeable checkbox built on the Finesse UI Kit design tokens.
///
/// `GHAppCheckbox` is the canonical binary-choice input for lists and forms.
/// It supports three [CheckboxSize] values, hover / focus / disabled states
/// with Finesse shadow transitions, and exposes the checked value via
/// [onChanged].
///
/// ```dart
/// GHAppCheckbox(
///   value: _isChecked,
///   onChanged: (v) => setState(() => _isChecked = v),
/// );
///
/// GHAppCheckbox(
///   value: _isChecked,
///   size: CheckboxSize.large,
///   onChanged: (v) => setState(() => _isChecked = v),
/// );
/// ```
///
/// A checkbox is disabled when [onChanged] is `null`.
class GHAppCheckbox extends StatefulWidget {
  /// Creates a checkbox.
  const GHAppCheckbox({required this.value, required this.onChanged, this.size = CheckboxSize.small, this.semanticLabel, super.key});

  /// Whether the checkbox is checked.
  final bool value;

  /// Called when the user toggles the checkbox. Pass `null` to disable.
  final ValueChanged<bool>? onChanged;

  /// The size variant. See [CheckboxSize].
  final CheckboxSize size;

  /// Optional label read by screen readers instead of the default
  /// "checkbox" description.
  final String? semanticLabel;

  @override
  State<GHAppCheckbox> createState() => _GHAppCheckboxState();
}

class _GHAppCheckboxState extends State<GHAppCheckbox> {
  bool _hovered = false;
  bool _focused = false;

  bool get _isEnabled => widget.onChanged != null;

  // ── Dimensions ─────────────────────────────────────────────────────────────

  double get _boxSize => switch (widget.size) {
    CheckboxSize.small => 16,
    CheckboxSize.medium => 20,
    CheckboxSize.large => 24,
  };

  double get _checkSize => _boxSize - 4;

  // ── Colors ─────────────────────────────────────────────────────────────────

  Color get _backgroundColor {
    if (!_isEnabled) return widget.value ? ColorTokens.gray400 : ColorTokens.gray200;
    if (widget.value) return _hovered ? ColorTokens.gray1000 : Colors.black;
    if (_hovered) return ColorTokens.gray50;
    return Colors.white;
  }

  Color get _checkColor => _isEnabled ? Colors.white : ColorTokens.gray300;

  // ── Shadows ────────────────────────────────────────────────────────────────

  List<BoxShadow> _boxShadow(BuildContext context) {
    if (!_isEnabled) return widget.value ? const [] : ShadowTokens.medium;
    final shadows = context.shadows;
    if (widget.value) {
      if (_focused) return shadows.focusPrimary;
      if (_hovered) return shadows.hoverSecondary;
      return const [];
    }
    if (_focused) return shadows.focusSecondary;
    if (_hovered) return shadows.hoverPrimary;
    return ShadowTokens.medium;
  }

  // ── Interaction ────────────────────────────────────────────────────────────

  void _handleTap() {
    if (_isEnabled) widget.onChanged!(!widget.value);
  }

  KeyEventResult _handleKeyEvent(FocusNode _, KeyEvent event) {
    if (!_isEnabled) return KeyEventResult.ignored;
    if (event is KeyDownEvent && (event.logicalKey == LogicalKeyboardKey.space || event.logicalKey == LogicalKeyboardKey.enter)) {
      _handleTap();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final box = AnimatedContainer(
      duration: DurationTokens.fast,
      width: _boxSize,
      height: _boxSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: _backgroundColor, borderRadius: BorderRadius.circular(RadiusTokens.sm), boxShadow: _boxShadow(context)),
      child: widget.value ? GHHeroIcon(GHIcons.check, size: _checkSize, color: _checkColor) : null,
    );

    return Semantics(
      checked: widget.value,
      enabled: _isEnabled,
      label: widget.semanticLabel,
      onTap: _isEnabled ? _handleTap : null,
      child: Focus(
        onKeyEvent: _handleKeyEvent,
        onFocusChange: (hasFocus) => setState(() => _focused = hasFocus),
        child: MouseRegion(
          cursor: _isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(onTap: _isEnabled ? _handleTap : null, child: box),
        ),
      ),
    );
  }
}
