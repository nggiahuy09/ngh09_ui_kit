import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/feedback/tooltip_arrow.dart';
import 'package:ngh09_ui_kit/src/components/feedback/tooltip_corner.dart';
import 'package:ngh09_ui_kit/src/components/feedback/tooltip_size.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// An informational overlay built on the Finesse UI Kit design tokens.
///
/// `GHTooltip` always shows a [headline]. Passing [supportingText] switches it
/// from a single-line label into the "detailed" layout: a bold headline
/// followed by a line of body copy, constrained to [maxWidth].
///
/// An optional [arrow] points the tooltip at whatever it's anchored to, and
/// [onDismiss] shows a close (×) button — omit it to hide the button.
///
/// The [size] selects one of three text scales and [corner] a squared or
/// softly-rounded shape.
///
/// ```dart
/// const GHTooltip(headline: 'Here is a tooltip');
///
/// GHTooltip(
///   headline: 'Here is a tooltip',
///   supportingText: 'Here is some helpful explainer text.',
///   arrow: TooltipArrow.bottom,
///   onDismiss: () => setState(() => _show = false),
/// )
/// ```
class GHTooltip extends StatelessWidget {
  /// Creates a tooltip.
  const GHTooltip({
    required this.headline,
    this.supportingText,
    this.arrow = TooltipArrow.none,
    this.size = TooltipSize.small,
    this.corner = TooltipCorner.sharp,
    this.showCloseButton = true,
    this.onDismiss,
    this.maxWidth = 320,
    super.key,
  });

  /// The tooltip's primary text.
  ///
  /// Shown alone (medium weight) when [supportingText] is `null`, or as a
  /// bold title above it otherwise.
  final String headline;

  /// Body copy shown below [headline].
  ///
  /// Switches the tooltip from its single-line layout to the detailed
  /// headline-plus-body layout.
  final String? supportingText;

  /// Which edge the pointed arrow protrudes from. See [TooltipArrow].
  final TooltipArrow arrow;

  /// The tooltip's text scale. See [TooltipSize].
  final TooltipSize size;

  /// The corner-radius shape. See [TooltipCorner].
  final TooltipCorner corner;

  /// Whether to show a close (×) button on the trailing edge.
  final bool showCloseButton;

  /// Callback fired when the close button is tapped.
  ///
  /// The close button is still shown (as a decorative affordance) when this
  /// is `null`, matching the Finesse default — it just isn't interactive.
  final VoidCallback? onDismiss;

  /// The maximum width of the detailed (headline + [supportingText]) layout.
  ///
  /// Ignored for the single-line layout, which always hugs its content.
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final box = _TooltipBox(
      headline: headline,
      supportingText: supportingText,
      size: size,
      corner: corner,
      showCloseButton: showCloseButton,
      onDismiss: onDismiss,
      maxWidth: maxWidth,
    );

    if (arrow == TooltipArrow.none) return box;

    final tip = _ArrowTip(direction: arrow);
    return switch (arrow) {
      TooltipArrow.top => Column(mainAxisSize: MainAxisSize.min, children: [tip, box]),
      TooltipArrow.bottom => Column(mainAxisSize: MainAxisSize.min, children: [box, tip]),
      TooltipArrow.left => Row(mainAxisSize: MainAxisSize.min, children: [tip, box]),
      TooltipArrow.right => Row(mainAxisSize: MainAxisSize.min, children: [box, tip]),
      TooltipArrow.none => box,
    };
  }
}

/// The rounded content card of a [GHTooltip], excluding its arrow.
class _TooltipBox extends StatelessWidget {
  const _TooltipBox({
    required this.headline,
    required this.supportingText,
    required this.size,
    required this.corner,
    required this.showCloseButton,
    required this.onDismiss,
    required this.maxWidth,
  });

  final String headline;
  final String? supportingText;
  final TooltipSize size;
  final TooltipCorner corner;
  final bool showCloseButton;
  final VoidCallback? onDismiss;
  final double maxWidth;

  bool get _detailed => supportingText != null;

  double get _textSize => switch (size) {
    TooltipSize.small => 12,
    TooltipSize.medium => 14,
    TooltipSize.large => 16,
  };

  double get _iconSize => _textSize;

  double get _detailedPadding => switch (size) {
    TooltipSize.small => 12,
    TooltipSize.medium => 14,
    TooltipSize.large => 16,
  };

  double get _simpleGap => switch (size) {
    TooltipSize.small => 4,
    TooltipSize.medium => 6,
    TooltipSize.large => 8,
  };

  TextStyle _baseStyle(BuildContext context) => switch (size) {
    TooltipSize.small => context.textStyles.labelMedium,
    TooltipSize.medium => context.textStyles.bodySmall,
    TooltipSize.large => context.textStyles.bodyMedium,
  };

  @override
  Widget build(BuildContext context) {
    final closeButton = showCloseButton
        ? GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.opaque,
            child: GHHeroIcon(GHIcons.xMark, size: _iconSize, color: ColorTokens.black, semanticLabel: 'Close'),
          )
        : null;

    final content = _detailed
        ? Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(headline, style: _baseStyle(context).copyWith(fontWeight: FontWeight.w600, color: ColorTokens.black)),
                    Text(
                      supportingText!,
                      style: _baseStyle(context).copyWith(fontWeight: FontWeight.w400, color: ColorTokens.gray500),
                    ),
                  ],
                ),
              ),
              ?closeButton,
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            spacing: _simpleGap,
            children: [
              Text(headline, style: _baseStyle(context).copyWith(fontWeight: FontWeight.w500, color: ColorTokens.black)),
              ?closeButton,
            ],
          );

    return Container(
      constraints: _detailed ? BoxConstraints(maxWidth: maxWidth) : null,
      padding: _detailed
          ? EdgeInsets.all(_detailedPadding)
          : const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ColorTokens.white,
        borderRadius: corner == TooltipCorner.smooth ? context.radii.borderRadiusMd : null,
        boxShadow: context.shadows.large,
      ),
      child: content,
    );
  }
}

/// The small triangular caret rendered by a [GHTooltip] with a non-[TooltipArrow.none] arrow.
class _ArrowTip extends StatelessWidget {
  const _ArrowTip({required this.direction});

  final TooltipArrow direction;

  // The Finesse spec keeps the arrow the same 20x12 dp size across all
  // tooltip sizes and corner styles.
  static const double _length = 20;
  static const double _depth = 12;

  @override
  Widget build(BuildContext context) {
    final horizontal = direction == TooltipArrow.top || direction == TooltipArrow.bottom;
    return CustomPaint(
      size: horizontal ? const Size(_length, _depth) : const Size(_depth, _length),
      painter: _ArrowPainter(direction),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  const _ArrowPainter(this.direction);

  final TooltipArrow direction;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = ColorTokens.white;
    final path = Path();
    switch (direction) {
      case TooltipArrow.bottom:
        path
          ..moveTo(0, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width / 2, size.height)
          ..close();
      case TooltipArrow.top:
        path
          ..moveTo(0, size.height)
          ..lineTo(size.width, size.height)
          ..lineTo(size.width / 2, 0)
          ..close();
      case TooltipArrow.right:
        path
          ..moveTo(0, 0)
          ..lineTo(0, size.height)
          ..lineTo(size.width, size.height / 2)
          ..close();
      case TooltipArrow.left:
        path
          ..moveTo(size.width, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height / 2)
          ..close();
      case TooltipArrow.none:
        return;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) => oldDelegate.direction != direction;
}
