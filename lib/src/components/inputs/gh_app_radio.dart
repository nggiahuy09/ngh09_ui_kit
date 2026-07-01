import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngh09_ui_kit/src/components/inputs/radio_size.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/tokens/shadows.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A themeable radio button built on the Finesse UI Kit design tokens.
///
/// `GHAppRadio` is the canonical single-choice input for lists and forms. It
/// supports three [RadioSize] values, hover / focus / disabled states with
/// Finesse shadow transitions, and exposes the selected value via
/// [onChanged].
///
/// ```dart
/// GHAppRadio(
///   value: _isSelected,
///   onChanged: (v) => setState(() => _isSelected = v),
/// );
///
/// GHAppRadio(
///   value: _isSelected,
///   size: RadioSize.large,
///   onChanged: (v) => setState(() => _isSelected = v),
/// );
/// ```
///
/// A radio is disabled when [onChanged] is `null`.
class GHAppRadio extends StatefulWidget {
  /// Creates a radio button.
  const GHAppRadio({required this.value, required this.onChanged, this.size = RadioSize.small, this.semanticLabel, super.key});

  /// Whether the radio is selected.
  final bool value;

  /// Called when the user selects the radio. Pass `null` to disable.
  final ValueChanged<bool>? onChanged;

  /// The size variant. See [RadioSize].
  final RadioSize size;

  /// Optional label read by screen readers instead of the default
  /// "radio button" description.
  final String? semanticLabel;

  @override
  State<GHAppRadio> createState() => _GHAppRadioState();
}

class _GHAppRadioState extends State<GHAppRadio> {
  bool _hovered = false;
  bool _focused = false;

  bool get _isEnabled => widget.onChanged != null;

  // ── Dimensions ─────────────────────────────────────────────────────────────

  double get _circleSize => switch (widget.size) {
    RadioSize.small => 16,
    RadioSize.medium => 20,
    RadioSize.large => 24,
  };

  double get _dotSize => _circleSize / 2 - 2;

  // ── Colors ─────────────────────────────────────────────────────────────────

  Color get _backgroundColor {
    if (!_isEnabled) return widget.value ? ColorTokens.gray400 : ColorTokens.gray200;
    if (widget.value) return _hovered ? ColorTokens.gray1000 : Colors.black;
    if (_hovered) return ColorTokens.gray50;
    return Colors.white;
  }

  Color get _dotColor => _isEnabled ? Colors.white : ColorTokens.gray300;

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
    final circle = AnimatedContainer(
      duration: DurationTokens.fast,
      width: _circleSize,
      height: _circleSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: _backgroundColor, shape: BoxShape.circle, boxShadow: _boxShadow(context)),
      child: widget.value ? _Dot(size: _dotSize, color: _dotColor) : null,
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
          child: GestureDetector(onTap: _isEnabled ? _handleTap : null, child: circle),
        ),
      ),
    );
  }
}

/// The solid dot rendered inside a selected [GHAppRadio].
class _Dot extends StatelessWidget {
  const _Dot({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
