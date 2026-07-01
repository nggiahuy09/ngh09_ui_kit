import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/buttons/button_corner.dart';
import 'package:ngh09_ui_kit/src/components/buttons/button_variant.dart';
import 'package:ngh09_ui_kit/src/theme/app_colors.dart';
import 'package:ngh09_ui_kit/src/theme/app_shadows.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A themeable button built on the Finesse UI Kit design tokens.
///
/// `GHAppButton` is the canonical action component. It supports all five
/// [ButtonVariant] types (filled / tonal / secondaryGrey / outlined / text),
/// five [ButtonSize] steps, four [ButtonCorner] shapes, optional
/// [leading]/[trailing] icons, and `loading`/`disabled` states.
///
/// Hover and focus shadows are driven by the active theme's [GHAppShadows]
/// so every state transition faithfully follows the Finesse specification —
/// nothing is hardcoded.
///
/// ```dart
/// GHAppButton(
///   label: 'Save',
///   onPressed: _save,
///   leading: const Icon(Icons.check),
/// );
///
/// GHAppButton.outlined(
///   label: 'Cancel',
///   size: ButtonSize.small,
///   onPressed: _cancel,
/// );
///
/// GHAppButton.secondaryGrey(
///   label: 'Dismiss',
///   corner: ButtonCorner.full,
///   onPressed: _dismiss,
/// );
/// ```
///
/// A button is disabled when [onPressed] is `null` or [isLoading] is `true`.
/// While [isLoading] it shows a progress indicator in place of the icons and
/// ignores taps, but keeps its label and footprint so the layout does not jump.
class GHAppButton extends StatefulWidget {
  /// Creates a button with an explicit [variant] (defaults to
  /// [ButtonVariant.filled]) and [corner] (defaults to [ButtonCorner.medium]).
  const GHAppButton({
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.corner = ButtonCorner.medium,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expanded = false,
    super.key,
  });

  /// Creates a high-emphasis [ButtonVariant.filled] button (Primary).
  const GHAppButton.filled({
    required this.label,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.corner = ButtonCorner.medium,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expanded = false,
    super.key,
  }) : variant = ButtonVariant.filled;

  /// Creates a medium-emphasis [ButtonVariant.tonal] button (Secondary Color).
  const GHAppButton.tonal({
    required this.label,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.corner = ButtonCorner.medium,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expanded = false,
    super.key,
  }) : variant = ButtonVariant.tonal;

  /// Creates a medium-emphasis [ButtonVariant.secondaryGrey] button.
  ///
  /// Uses the `surface` background with a shadow-rendered border ring.
  const GHAppButton.secondaryGrey({
    required this.label,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.corner = ButtonCorner.medium,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expanded = false,
    super.key,
  }) : variant = ButtonVariant.secondaryGrey;

  /// Creates a lower-emphasis [ButtonVariant.outlined] button (Outline).
  const GHAppButton.outlined({
    required this.label,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.corner = ButtonCorner.medium,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expanded = false,
    super.key,
  }) : variant = ButtonVariant.outlined;

  /// Creates a lowest-emphasis [ButtonVariant.text] button (Text Only).
  const GHAppButton.text({
    required this.label,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.corner = ButtonCorner.medium,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expanded = false,
    super.key,
  }) : variant = ButtonVariant.text;

  /// The button's text label.
  final String label;

  /// Called when the button is tapped.
  ///
  /// When `null`, the button renders in its disabled state and does not
  /// respond to input.
  final VoidCallback? onPressed;

  /// The visual type of the button. See [ButtonVariant].
  final ButtonVariant variant;

  /// The size of the button. See [ButtonSize].
  final ButtonSize size;

  /// The corner-radius shape. See [ButtonCorner].
  final ButtonCorner corner;

  /// Optional widget shown before the [label] (typically an [Icon]).
  ///
  /// Hidden while [isLoading].
  final Widget? leading;

  /// Optional widget shown after the [label] (typically an [Icon]).
  ///
  /// Hidden while [isLoading].
  final Widget? trailing;

  /// Whether to show a progress indicator and block input.
  ///
  /// The label and footprint are preserved so the layout does not shift.
  final bool isLoading;

  /// Whether the button should stretch to fill the available horizontal space.
  final bool expanded;

  @override
  State<GHAppButton> createState() => _GHAppButtonState();
}

class _GHAppButtonState extends State<GHAppButton> {
  // Shared states controller lets the shadow layer read the same states that
  // the underlying Material button reports (hover, focus, pressed, etc.).
  final _statesController = WidgetStatesController();

  bool get _isEnabled => widget.onPressed != null && !widget.isLoading;

  @override
  void initState() {
    super.initState();
    // Defer listener registration to after the first frame. FilledButton calls
    // statesController.update() during its own mount (to set the disabled
    // state), which would fire _onStatesChanged mid-build and violate
    // Flutter's "no setState during build" invariant.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _statesController.addListener(_onStatesChanged);
    });
  }

  void _onStatesChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _statesController
      ..removeListener(_onStatesChanged)
      ..dispose();
    super.dispose();
  }

  // ── Dimensions ─────────────────────────────────────────────────────────────

  EdgeInsets get _padding => switch (widget.size) {
    ButtonSize.extraSmall => const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
    ButtonSize.small => const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    ButtonSize.medium => const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
    ButtonSize.large => const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    ButtonSize.extraLarge => const EdgeInsets.symmetric(vertical: 18, horizontal: 26),
  };

  double get _iconSize => switch (widget.size) {
    ButtonSize.extraSmall || ButtonSize.small => 18,
    ButtonSize.medium || ButtonSize.large => 20,
    ButtonSize.extraLarge => 24,
  };

  double get _gap => switch (widget.size) {
    ButtonSize.extraSmall || ButtonSize.small => 8,
    ButtonSize.medium || ButtonSize.large => 10,
    ButtonSize.extraLarge => 12,
  };

  // ── Typography ─────────────────────────────────────────────────────────────

  TextStyle _labelStyle(BuildContext context) {
    final styles = context.textStyles;
    // Finesse buttons use SemiBold (600) for all sizes.
    const semiBold = FontWeight.w600;
    return switch (widget.size) {
      ButtonSize.extraSmall || ButtonSize.small => styles.bodySmall.copyWith(fontWeight: semiBold),
      ButtonSize.medium || ButtonSize.large => styles.bodyMedium.copyWith(fontWeight: semiBold),
      ButtonSize.extraLarge => styles.bodyLarge.copyWith(fontWeight: semiBold),
    };
  }

  // ── Colors ─────────────────────────────────────────────────────────────────

  Color _foregroundColor(GHAppColors colors) => switch (widget.variant) {
    ButtonVariant.filled => colors.onPrimary,
    ButtonVariant.tonal => colors.onPrimaryContainer,
    ButtonVariant.secondaryGrey => colors.onSurface,
    ButtonVariant.outlined => colors.primary,
    ButtonVariant.text => colors.primary,
  };

  Color? _backgroundColor(GHAppColors colors) => switch (widget.variant) {
    ButtonVariant.filled => colors.primary,
    ButtonVariant.tonal => colors.primaryContainer,
    ButtonVariant.secondaryGrey => colors.surface,
    ButtonVariant.outlined => Colors.transparent,
    ButtonVariant.text => Colors.transparent,
  };

  // ── Shadows ────────────────────────────────────────────────────────────────

  bool get _hasShadow => widget.variant != ButtonVariant.text;

  List<BoxShadow> _shadowForStates(Set<WidgetState> states, GHAppShadows shadows) {
    if (!_isEnabled) return shadows.medium;

    final isPrimary = widget.variant == ButtonVariant.filled;
    final isFocused = states.contains(WidgetState.focused) || states.contains(WidgetState.pressed);
    final isHovered = states.contains(WidgetState.hovered);

    if (isFocused) return isPrimary ? shadows.focusPrimary : shadows.focusSecondary;
    if (isHovered) return isPrimary ? shadows.hoverPrimary : shadows.hoverSecondary;
    return shadows.medium;
  }

  // ── Shape ──────────────────────────────────────────────────────────────────

  BorderRadius _borderRadius(BuildContext context) {
    final radii = context.radii;
    return switch (widget.corner) {
      ButtonCorner.none => BorderRadius.zero,
      ButtonCorner.small => radii.borderRadiusSm,
      ButtonCorner.medium => radii.borderRadiusMd,
      ButtonCorner.full => radii.borderRadiusFull,
    };
  }

  // ── ButtonStyle ────────────────────────────────────────────────────────────

  ButtonStyle _buttonStyle(BuildContext context) {
    final colors = context.colors;
    final foreground = _foregroundColor(colors);
    final background = _backgroundColor(colors);
    final borderRadius = _borderRadius(context);

    // Disabled foreground for secondaryGrey uses the explicit Finesse token
    // (Grey/300). For all other variants, Material's default disabled opacity
    // (applied automatically) produces the correct result.
    final disabledFg = widget.variant == ButtonVariant.secondaryGrey ? ColorTokens.gray300 : null;

    return ButtonStyle(
      animationDuration: DurationTokens.fast,
      // Remove Material's built-in elevation so it doesn't compete with our
      // custom box-shadow layer.
      elevation: const WidgetStatePropertyAll(0),
      minimumSize: const WidgetStatePropertyAll(Size.zero),
      padding: WidgetStatePropertyAll(_padding),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled) && disabledFg != null) return disabledFg;
        return foreground;
      }),
      backgroundColor: background == null ? null : WidgetStatePropertyAll(background),
      side: widget.variant == ButtonVariant.outlined ? WidgetStatePropertyAll(BorderSide(color: colors.outline)) : null,
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: borderRadius)),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final shadows = context.shadows;
    final borderRadius = _borderRadius(context);

    final content = _ButtonContent(
      label: widget.label,
      labelStyle: _labelStyle(context),
      leading: widget.leading,
      trailing: widget.trailing,
      isLoading: widget.isLoading,
      iconSize: _iconSize,
      spacing: _gap,
      progressColor: _foregroundColor(colors),
    );

    final style = _buttonStyle(context);

    Widget button = switch (widget.variant) {
      ButtonVariant.filled => FilledButton(
        onPressed: _isEnabled ? widget.onPressed : null,
        style: style,
        statesController: _statesController,
        child: content,
      ),
      ButtonVariant.tonal => FilledButton.tonal(
        onPressed: _isEnabled ? widget.onPressed : null,
        style: style,
        statesController: _statesController,
        child: content,
      ),
      ButtonVariant.secondaryGrey => FilledButton(
        onPressed: _isEnabled ? widget.onPressed : null,
        style: style,
        statesController: _statesController,
        child: content,
      ),
      ButtonVariant.outlined => OutlinedButton(
        onPressed: _isEnabled ? widget.onPressed : null,
        style: style,
        statesController: _statesController,
        child: content,
      ),
      ButtonVariant.text => TextButton(
        onPressed: _isEnabled ? widget.onPressed : null,
        style: style,
        statesController: _statesController,
        child: content,
      ),
    };

    if (widget.expanded) button = SizedBox(width: double.infinity, child: button);

    // Text-only buttons carry no shadow.
    if (!_hasShadow) return button;

    // The shadow is re-evaluated on each build triggered by _onStatesChanged,
    // so the correct resting / hover / focus shadow is always applied without
    // an extra widget node in the tree.
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: borderRadius, boxShadow: _shadowForStates(_statesController.value, shadows)),
      child: button,
    );
  }
}

/// Lays out the leading icon, label and trailing icon of a [GHAppButton],
/// swapping the icons for a progress indicator while loading.
class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.labelStyle,
    required this.leading,
    required this.trailing,
    required this.isLoading,
    required this.iconSize,
    required this.spacing,
    required this.progressColor,
  });

  final String label;
  final TextStyle labelStyle;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;
  final double iconSize;
  final double spacing;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    final spinner = SizedBox(
      width: iconSize,
      height: iconSize,
      child: CircularProgressIndicator(strokeWidth: 2, color: progressColor),
    );

    final children = <Widget>[
      if (isLoading)
        spinner
      else if (leading != null)
        IconTheme.merge(
          data: IconThemeData(size: iconSize),
          child: leading!,
        ),
      if (isLoading || leading != null) SizedBox(width: spacing),
      Flexible(
        child: Text(
          label,
          style: labelStyle,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
      if (!isLoading && trailing != null) ...[
        SizedBox(width: spacing),
        IconTheme.merge(
          data: IconThemeData(size: iconSize),
          child: trailing!,
        ),
      ],
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
