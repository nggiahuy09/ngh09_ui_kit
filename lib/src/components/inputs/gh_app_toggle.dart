import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngh09_ui_kit/src/components/inputs/toggle_size.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/tokens/shadows.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A themeable toggle switch built on the Finesse UI Kit design tokens.
///
/// `GHAppToggle` is the canonical binary-choice input. It supports three
/// [ToggleSize] values, hover / focus / disabled states with Finesse
/// shadow transitions, and exposes the toggled value via [onChanged].
///
/// ```dart
/// GHAppToggle(
///   value: _isOn,
///   onChanged: (v) => setState(() => _isOn = v),
/// );
///
/// GHAppToggle(
///   value: _isOn,
///   size: ToggleSize.large,
///   onChanged: (v) => setState(() => _isOn = v),
/// );
/// ```
///
/// A toggle is disabled when [onChanged] is `null`.
class GHAppToggle extends StatefulWidget {
  /// Creates a toggle switch.
  const GHAppToggle({required this.value, required this.onChanged, this.size = ToggleSize.small, this.semanticLabel, super.key});

  /// Whether the toggle is on.
  final bool value;

  /// Called when the user flips the toggle. Pass `null` to disable.
  final ValueChanged<bool>? onChanged;

  /// The size variant. See [ToggleSize].
  final ToggleSize size;

  /// Optional label read by screen readers instead of the default
  /// "toggle switch" description.
  final String? semanticLabel;

  @override
  State<GHAppToggle> createState() => _GHAppToggleState();
}

class _GHAppToggleState extends State<GHAppToggle> {
  bool _hovered = false;
  bool _focused = false;

  bool get _isEnabled => widget.onChanged != null;

  // ── Dimensions ─────────────────────────────────────────────────────────────

  double get _trackWidth => switch (widget.size) {
    ToggleSize.small => 36,
    ToggleSize.medium => 44,
    ToggleSize.large => 52,
  };

  double get _trackHeight => switch (widget.size) {
    ToggleSize.small => 20,
    ToggleSize.medium => 24,
    ToggleSize.large => 32,
  };

  double get _thumbSize => switch (widget.size) {
    ToggleSize.small => 16,
    ToggleSize.medium => 20,
    ToggleSize.large => 24,
  };

  EdgeInsets get _trackPadding => switch (widget.size) {
    ToggleSize.small => const EdgeInsets.all(2),
    ToggleSize.medium => const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
    ToggleSize.large => const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  };

  // ── Colors ─────────────────────────────────────────────────────────────────

  Color get _trackColor {
    if (!_isEnabled) return widget.value ? ColorTokens.gray400 : ColorTokens.gray300;
    if (widget.value) return _hovered ? ColorTokens.gray1000 : Colors.black;
    if (_focused) return ColorTokens.gray100;
    if (_hovered) return ColorTokens.gray300;
    return ColorTokens.gray200;
  }

  // ── Shadows ────────────────────────────────────────────────────────────────

  List<BoxShadow> _trackShadow(BuildContext context) {
    if (!_isEnabled) return const [];
    final shadows = context.shadows;
    if (_focused) return shadows.focusSecondary;
    if (_hovered) return shadows.hoverSecondary;
    return const [];
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
    final trackShadow = _trackShadow(context);
    final borderRadius = BorderRadius.circular(100);

    final track = AnimatedContainer(
      duration: DurationTokens.fast,
      width: _trackWidth,
      height: _trackHeight,
      padding: _trackPadding,
      decoration: BoxDecoration(color: _trackColor, borderRadius: borderRadius, boxShadow: trackShadow),
      child: AnimatedAlign(
        duration: DurationTokens.fast,
        alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        child: _Thumb(size: _thumbSize, isEnabled: _isEnabled),
      ),
    );

    return Semantics(
      toggled: widget.value,
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
          child: GestureDetector(onTap: _isEnabled ? _handleTap : null, child: track),
        ),
      ),
    );
  }
}

/// The round white thumb that slides inside a [GHAppToggle] track.
class _Thumb extends StatelessWidget {
  const _Thumb({required this.size, required this.isEnabled});

  final double size;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: isEnabled ? ShadowTokens.small : null,
      ),
    );
  }
}
