import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/feedback/gh_alert_state.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icon_data.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/tokens/shadows.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A themeable multi-line text input built on the Finesse UI Kit design tokens.
///
/// `GHAppTextArea` shares its anatomy and state colors with `GHAppTextField` (label above, helper/error/warning/success row below) but grows to fit [minLines]–[maxLines] of top-aligned content instead of a single line.
///
/// ```dart
/// GHAppTextArea(
///   label: 'Message',
///   placeholder: 'Write something…',
///   controller: _messageController,
/// );
///
/// GHAppTextArea(
///   label: 'Message',
///   controller: _messageController,
///   status: GHAlertState.error,
///   helperText: 'This field is required.',
/// );
/// ```
///
/// The field is disabled when [enabled] is `false`, and read-only (visible but non-editable) when [readOnly] is `true`.
class GHAppTextArea extends StatefulWidget {
  /// Creates a multi-line text area, at least [minLines] tall (defaults to 3) and growing up to [maxLines] (unbounded when `null`).
  const GHAppTextArea({
    this.controller,
    this.focusNode,
    this.label,
    this.placeholder,
    this.helperText,
    this.status = GHAlertState.active,
    this.minLines = 3,
    this.maxLines,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    super.key,
  }) : assert(maxLines == null || maxLines >= minLines, 'maxLines must be greater than or equal to minLines.');

  /// Controls the field's text. When `null`, the field manages its own.
  final TextEditingController? controller;

  /// The focus node backing the field. When `null`, the field creates and owns one internally.
  final FocusNode? focusNode;

  /// Optional label shown above the field.
  final String? label;

  /// Optional placeholder shown when the field is empty.
  final String? placeholder;

  /// Optional helper/error/warning/success message shown below the field, prefixed with a status icon matching [status].
  final String? helperText;

  /// The feedback state, tinting the field and [helperText]. Defaults to [GHAlertState.active] (neutral).
  final GHAlertState status;

  /// The minimum number of visible text rows. Defaults to 3.
  final int minLines;

  /// The maximum number of rows the field grows to before scrolling. `null` (the default) lets it grow without bound.
  final int? maxLines;

  /// The keyboard type to display. Defaults to [TextInputType.multiline].
  final TextInputType keyboardType;

  /// The action button to show on the software keyboard.
  final TextInputAction? textInputAction;

  /// Whether the field accepts input. When `false`, it renders in its disabled state.
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
  State<GHAppTextArea> createState() => _GHAppTextAreaState();
}

class _GHAppTextAreaState extends State<GHAppTextArea> {
  bool _hovered = false;
  bool _focused = false;
  FocusNode? _internalFocusNode;

  FocusNode get _focusNode => widget.focusNode ?? (_internalFocusNode ??= FocusNode());

  // A field is "static" when it neither accepts input nor reacts to hover or focus — disabled and read-only share the same muted, fixed appearance.
  bool get _isStatic => !widget.enabled || widget.readOnly;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant GHAppTextArea oldWidget) {
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
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: Colors.black,
        style: textStyles.bodyMedium.copyWith(color: valueColor),
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: widget.placeholder,
          hintStyle: textStyles.bodyMedium.copyWith(color: ColorTokens.gray400),
        ),
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
