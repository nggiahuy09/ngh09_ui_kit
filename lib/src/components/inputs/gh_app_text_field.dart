import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/feedback/gh_alert_state.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icon_data.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/tokens/shadows.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A themeable single-line text input built on the Finesse UI Kit design
/// tokens.
///
/// `GHAppTextField` pairs an optional [label] above the field with an
/// optional [helperText] row below (prefixed with a status icon), and
/// reflects hover / focus / disabled / read-only states plus a [status]
/// (from [GHAlertState]) that tints the field for error, warning or success
/// feedback.
///
/// ```dart
/// GHAppTextField(
///   label: 'Email',
///   placeholder: 'you@example.com',
///   controller: _emailController,
/// );
///
/// GHAppTextField(
///   label: 'Email',
///   controller: _emailController,
///   status: GHAlertState.error,
///   helperText: 'Enter a valid email address.',
/// );
/// ```
///
/// The field is disabled when [enabled] is `false`, and read-only (visible
/// but non-editable) when [readOnly] is `true`.
class GHAppTextField extends StatefulWidget {
  /// Creates a single-line text field.
  const GHAppTextField({
    this.controller,
    this.focusNode,
    this.label,
    this.placeholder,
    this.helperText,
    this.leadingIcon,
    this.status = GHAlertState.active,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    super.key,
  });

  /// Controls the field's text. When `null`, the field manages its own.
  final TextEditingController? controller;

  /// The focus node backing the field. When `null`, the field creates and
  /// owns one internally.
  final FocusNode? focusNode;

  /// Optional label shown above the field.
  final String? label;

  /// Optional placeholder shown when the field is empty.
  final String? placeholder;

  /// Optional helper/error/warning/success message shown below the field,
  /// prefixed with a status icon matching [status].
  final String? helperText;

  /// Optional leading icon shown inside the field, before the text.
  final Widget? leadingIcon;

  /// The feedback state, tinting the field and [helperText]. Defaults to
  /// [GHAlertState.active] (neutral).
  final GHAlertState status;

  /// Whether to obscure the input, for password entry.
  final bool obscureText;

  /// The keyboard type to display.
  final TextInputType? keyboardType;

  /// The action button to show on the software keyboard.
  final TextInputAction? textInputAction;

  /// Whether the field accepts input. When `false`, it renders in its
  /// disabled state.
  final bool enabled;

  /// Whether the field's content is visible but non-editable ("View Only").
  final bool readOnly;

  /// Whether the field should request focus as soon as it is inserted.
  final bool autofocus;

  /// Called on every text change.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the field (e.g. taps "done").
  final ValueChanged<String>? onSubmitted;

  @override
  State<GHAppTextField> createState() => _GHAppTextFieldState();
}

class _GHAppTextFieldState extends State<GHAppTextField> {
  bool _hovered = false;
  bool _focused = false;
  FocusNode? _internalFocusNode;

  FocusNode get _focusNode => widget.focusNode ?? (_internalFocusNode ??= FocusNode());

  // A field is "static" when it neither accepts input nor reacts to hover or
  // focus — disabled and read-only share the same muted, fixed appearance.
  bool get _isStatic => !widget.enabled || widget.readOnly;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant GHAppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      (oldWidget.focusNode ?? _internalFocusNode)?.removeListener(_handleFocusChange);
      _focusNode.addListener(_handleFocusChange);
    }
  }

  void _handleFocusChange() {
    if (mounted) setState(() => _focused = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _internalFocusNode?.dispose();
    super.dispose();
  }

  // ── Colors ─────────────────────────────────────────────────────────────────

  Color get _backgroundColor => _isStatic ? ColorTokens.gray100 : widget.status.backgroundColor;

  Color get _valueColor {
    if (!widget.enabled) return ColorTokens.gray400;
    if (widget.readOnly) return ColorTokens.gray700;
    return ColorTokens.gray900;
  }

  GHIconData get _helperIcon => switch (widget.status) {
    GHAlertState.active => GHIcons.questionMarkCircle,
    GHAlertState.error => GHIcons.exclamationCircle,
    GHAlertState.warning => GHIcons.exclamationTriangle,
    GHAlertState.success => GHIcons.checkCircle,
  };

  // ── Shadows ────────────────────────────────────────────────────────────────

  List<BoxShadow> _shadow(BuildContext context) {
    if (_isStatic) return ShadowTokens.medium;
    final shadows = context.shadows;
    return switch (widget.status) {
      GHAlertState.error => _focused ? shadows.focusError : shadows.hoverError,
      GHAlertState.warning => _focused ? shadows.focusWarning : shadows.hoverWarning,
      GHAlertState.success => _focused ? shadows.focusSuccess : shadows.hoverSuccess,
      GHAlertState.active => _focused ? shadows.focusSecondary : (_hovered ? shadows.hoverPrimary : ShadowTokens.medium),
    };
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;
    final radii = context.radii;
    final valueColor = _valueColor;

    final field = AnimatedContainer(
      duration: DurationTokens.fast,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: _backgroundColor, borderRadius: radii.borderRadiusMd, boxShadow: _shadow(context)),
      child: Row(
        children: [
          if (widget.leadingIcon != null) ...[
            IconTheme.merge(
              data: IconThemeData(size: 20, color: valueColor),
              child: widget.leadingIcon!,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              autofocus: widget.autofocus,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              cursorColor: Colors.black,
              style: textStyles.bodyMedium.copyWith(color: valueColor),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: textStyles.bodyMedium.copyWith(color: ColorTokens.gray400),
              ),
            ),
          ),
        ],
      ),
    );

    return MouseRegion(
      onEnter: _isStatic ? null : (_) => setState(() => _hovered = true),
      onExit: _isStatic ? null : (_) => setState(() => _hovered = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            Text(widget.label!, style: textStyles.labelLarge.copyWith(color: ColorTokens.gray700)),
            const SizedBox(height: 8),
          ],
          field,
          if (widget.helperText != null) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GHHeroIcon(_helperIcon, size: 14, color: widget.status.bodyColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(widget.helperText!, style: textStyles.bodySmall.copyWith(color: widget.status.bodyColor)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
