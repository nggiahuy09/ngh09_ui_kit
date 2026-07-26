import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/inputs/slider_indicator.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/tokens/radii.dart';
import 'package:ngh09_ui_kit/src/tokens/shadows.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// The draggable circular handle shared by `GHAppSlider` and
/// `GHAppRangeSlider`, with an optional value label or tooltip above it.
///
/// This mirrors the Finesse "Slider Node" component. It is an internal
/// building block — not exported from the package's public API — so both
/// slider widgets stay pixel-identical.
class SliderNode extends StatelessWidget {
  /// Creates a slider node.
  const SliderNode({
    required this.label,
    this.indicator = SliderIndicator.none,
    this.isEnabled = true,
    this.isHovered = false,
    this.isFocused = false,
    super.key,
  });

  /// The fixed diameter of the circular handle.
  static const double size = 20;

  /// The gap between the handle and its label/tooltip.
  static const double labelGap = 8;

  /// The height of the [SliderIndicator.text] label, including its gap.
  static const double textInsetHeight = 18 + labelGap;

  /// The height of the [SliderIndicator.tooltip] bubble, including its gap.
  static const double tooltipInsetHeight = 34 + labelGap;

  /// The value shown by [SliderIndicator.text] or [SliderIndicator.tooltip].
  final String label;

  /// Which value indicator to render above the handle. See [SliderIndicator].
  final SliderIndicator indicator;

  /// Whether the node accepts interaction. Mirrors the Finesse "Disabled" state.
  final bool isEnabled;

  /// Whether a pointer is currently hovering the node.
  final bool isHovered;

  /// Whether the node currently has input focus.
  final bool isFocused;

  /// The vertical space an [indicator] reserves above the handle, including
  /// its gap. Used by callers to size the space around a node.
  static double insetHeight(SliderIndicator indicator) => switch (indicator) {
    SliderIndicator.none => 0,
    SliderIndicator.text => textInsetHeight,
    SliderIndicator.tooltip => tooltipInsetHeight,
  };

  Color get _handleColor => isEnabled ? ColorTokens.white : ColorTokens.gray100;

  Color get _labelColor => isEnabled ? ColorTokens.gray900 : ColorTokens.gray300;

  List<BoxShadow> _handleShadow(BuildContext context) {
    if (!isEnabled) return ShadowTokens.medium;
    final shadows = context.shadows;
    if (isFocused) return shadows.focusSecondary;
    if (isHovered) return shadows.hoverPrimary;
    return ShadowTokens.medium;
  }

  @override
  Widget build(BuildContext context) {
    final handle = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: _handleColor, shape: BoxShape.circle, boxShadow: _handleShadow(context)),
    );

    final topper = switch (indicator) {
      SliderIndicator.none => null,
      SliderIndicator.text => Text(label, style: context.textStyles.labelMedium.copyWith(color: _labelColor)),
      SliderIndicator.tooltip => _Tooltip(label: label),
    };

    if (topper == null) return handle;

    return Column(mainAxisSize: MainAxisSize.min, spacing: labelGap, children: [topper, handle]);
  }
}

/// The tooltip bubble rendered above a [SliderNode] with
/// [SliderIndicator.tooltip].
class _Tooltip extends StatelessWidget {
  const _Tooltip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(color: ColorTokens.white, borderRadius: BorderRadius.circular(RadiusTokens.md), boxShadow: ShadowTokens.large),
      child: Text(label, style: context.textStyles.labelMedium.copyWith(color: ColorTokens.black)),
    );
  }
}
