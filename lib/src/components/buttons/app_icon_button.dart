import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/buttons/icon_button_corner.dart';
import 'package:ngh09_ui_kit/src/components/buttons/icon_button_size.dart';
import 'package:ngh09_ui_kit/src/theme/app_shadows.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A themeable, icon-only button built on the Finesse UI Kit design tokens.
///
/// `GHAppIconButton` is the canonical square action button for toolbars and
/// compact controls. It supports seven [IconButtonSize] steps, two
/// [IconButtonCorner] shapes, and hover / focus / disabled states with
/// Finesse shadow transitions.
///
/// ```dart
/// GHAppIconButton(
///   icon: const Icon(Icons.add),
///   onPressed: _create,
///   semanticLabel: 'Create',
/// );
///
/// GHAppIconButton(
///   icon: const Icon(Icons.delete),
///   size: IconButtonSize.small,
///   corner: IconButtonCorner.smooth,
///   onPressed: _delete,
///   semanticLabel: 'Delete',
/// );
/// ```
///
/// A button is disabled when [onPressed] is `null`.
class GHAppIconButton extends StatefulWidget {
  /// Creates an icon button with an explicit [size] (defaults to
  /// [IconButtonSize.medium]) and [corner] (defaults to
  /// [IconButtonCorner.sharp]).
  const GHAppIconButton({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.corner = IconButtonCorner.sharp,
    this.semanticLabel,
    super.key,
  });

  /// The icon to display, typically an [Icon] or `GHHeroIcon`.
  final Widget icon;

  /// Called when the button is tapped.
  ///
  /// When `null`, the button renders in its disabled state and does not
  /// respond to input.
  final VoidCallback? onPressed;

  /// The size variant. See [IconButtonSize].
  final IconButtonSize size;

  /// The corner-radius shape. See [IconButtonCorner].
  final IconButtonCorner corner;

  /// An accessibility label announced by screen readers and shown as a
  /// tooltip on hover. Strongly recommended since the button has no text.
  final String? semanticLabel;

  @override
  State<GHAppIconButton> createState() => _GHAppIconButtonState();
}

class _GHAppIconButtonState extends State<GHAppIconButton> {
  // Shared states controller lets the shadow layer read the same states that
  // the underlying Material button reports (hover, focus, pressed, etc.).
  final _statesController = WidgetStatesController();

  bool get _isEnabled => widget.onPressed != null;

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

  double get _boxSize => switch (widget.size) {
    IconButtonSize.extraExtraSmall => 32,
    IconButtonSize.extraSmall => 40,
    IconButtonSize.small => 48,
    IconButtonSize.medium => 56,
    IconButtonSize.large => 64,
    IconButtonSize.extraLarge => 72,
    IconButtonSize.extraExtraLarge => 80,
  };

  double get _iconSize => switch (widget.size) {
    IconButtonSize.extraExtraSmall => 16,
    IconButtonSize.extraSmall => 20,
    IconButtonSize.small => 24,
    IconButtonSize.medium => 28,
    IconButtonSize.large => 32,
    IconButtonSize.extraLarge => 36,
    IconButtonSize.extraExtraLarge => 40,
  };

  double get _smoothRadius => switch (widget.size) {
    IconButtonSize.extraExtraSmall || IconButtonSize.extraSmall => 8,
    IconButtonSize.small || IconButtonSize.medium => 12,
    IconButtonSize.large || IconButtonSize.extraLarge => 16,
    IconButtonSize.extraExtraLarge => 20,
  };

  // ── Shape ──────────────────────────────────────────────────────────────────

  BorderRadius get _borderRadius => switch (widget.corner) {
    IconButtonCorner.sharp => BorderRadius.zero,
    IconButtonCorner.smooth => BorderRadius.circular(_smoothRadius),
  };

  // ── Shadows ────────────────────────────────────────────────────────────────

  List<BoxShadow> _shadowForStates(Set<WidgetState> states, GHAppShadows shadows) {
    if (!_isEnabled) return shadows.medium;

    final isFocused = states.contains(WidgetState.focused) || states.contains(WidgetState.pressed);
    final isHovered = states.contains(WidgetState.hovered);

    if (isFocused) return shadows.focusSecondary;
    if (isHovered) return shadows.hoverSecondary;
    return shadows.medium;
  }

  // ── ButtonStyle ────────────────────────────────────────────────────────────

  ButtonStyle get _buttonStyle {
    return ButtonStyle(
      animationDuration: DurationTokens.fast,
      // Remove Material's built-in elevation and hover/focus tint so they
      // don't compete with our explicit color and box-shadow layers.
      elevation: const WidgetStatePropertyAll(0),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      minimumSize: const WidgetStatePropertyAll(Size.zero),
      fixedSize: WidgetStatePropertyAll(Size.square(_boxSize)),
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      // Sizes below 48dp (2xs/xs) would otherwise be padded up to Material's
      // default minimum touch target.
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return ColorTokens.gray100;
        if (states.contains(WidgetState.hovered)) return ColorTokens.gray1000;
        return Colors.black;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return ColorTokens.gray300;
        return Colors.white;
      }),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: _borderRadius)),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final shadows = context.shadows;
    final borderRadius = _borderRadius;

    Widget button = FilledButton(
      onPressed: _isEnabled ? widget.onPressed : null,
      style: _buttonStyle,
      statesController: _statesController,
      child: IconTheme.merge(
        data: IconThemeData(size: _iconSize),
        child: widget.icon,
      ),
    );

    if (widget.semanticLabel != null) button = Tooltip(message: widget.semanticLabel, child: button);

    // The shadow is re-evaluated on each build triggered by _onStatesChanged,
    // so the correct resting / hover / focus shadow is always applied without
    // an extra widget node in the tree.
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: borderRadius, boxShadow: _shadowForStates(_statesController.value, shadows)),
      child: button,
    );
  }
}
