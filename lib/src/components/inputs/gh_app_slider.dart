import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngh09_ui_kit/src/components/inputs/slider_node.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A themeable single-node slider built on the Finesse UI Kit design tokens.
///
/// `GHAppSlider` drags a single [SliderNode] handle along a track to select a
/// value between [min] and [max] — the canonical control for settings like
/// volume, brightness or a price cap. Enable [showValueLabel] to print the
/// current value after the track, formatted by [labelBuilder] (percentage by
/// default).
///
/// ```dart
/// GHAppSlider(
///   value: _volume,
///   onChanged: (v) => setState(() => _volume = v),
/// );
///
/// GHAppSlider(
///   value: _price,
///   min: 0,
///   max: 500,
///   step: 5,
///   showValueLabel: true,
///   labelBuilder: (v) => '\$${v.round()}',
///   onChanged: (v) => setState(() => _price = v),
/// );
/// ```
///
/// A slider is disabled when [onChanged] is `null`.
class GHAppSlider extends StatefulWidget {
  /// Creates a single-node slider.
  const GHAppSlider({
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.showValueLabel = false,
    this.labelBuilder,
    this.semanticLabel,
    super.key,
  }) : assert(min < max, 'min must be less than max'),
       assert(step > 0, 'step must be positive');

  /// The current value. Must lie within [min] and [max].
  final double value;

  /// Called with the new value as the user drags or steps the node. Pass
  /// `null` to disable.
  final ValueChanged<double>? onChanged;

  /// The lower bound of the slider's range.
  final double min;

  /// The upper bound of the slider's range.
  final double max;

  /// The increment applied per keyboard step and drag snap.
  final double step;

  /// Whether to print the current value after the track. See [labelBuilder].
  final bool showValueLabel;

  /// Formats [value] for [showValueLabel]. Defaults to a rounded percentage.
  final String Function(double value)? labelBuilder;

  /// Optional label read by screen readers.
  final String? semanticLabel;

  @override
  State<GHAppSlider> createState() => _GHAppSliderState();
}

class _GHAppSliderState extends State<GHAppSlider> {
  bool _hovered = false;
  bool _focused = false;
  final FocusNode _focusNode = FocusNode();

  bool get _isEnabled => widget.onChanged != null;

  double get _fraction => ((widget.value - widget.min) / (widget.max - widget.min)).clamp(0, 1);

  String get _label => (widget.labelBuilder ?? (v) => '${v.round()}%')(widget.value);

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  double _snap(double value) {
    final clamped = value.clamp(widget.min, widget.max);
    final steps = ((clamped - widget.min) / widget.step).round();
    return (widget.min + steps * widget.step).clamp(widget.min, widget.max);
  }

  void _updateFromLocalX(double localX, double trackWidth) {
    if (trackWidth <= 0) return;
    final fraction = (localX / trackWidth).clamp(0.0, 1.0);
    widget.onChanged!(_snap(widget.min + fraction * (widget.max - widget.min)));
  }

  void _step(double delta) => widget.onChanged!(_snap(widget.value + delta));

  KeyEventResult _handleKeyEvent(FocusNode _, KeyEvent event) {
    if (!_isEnabled || event is! KeyDownEvent) return KeyEventResult.ignored;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
      case LogicalKeyboardKey.arrowDown:
        _step(-widget.step);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowRight:
      case LogicalKeyboardKey.arrowUp:
        _step(widget.step);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.home:
        widget.onChanged!(widget.min);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.end:
        widget.onChanged!(widget.max);
        return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final track = LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth;
        final nodeLeft = _fraction * (trackWidth - SliderNode.size);
        final fillWidth = nodeLeft + SliderNode.size / 2;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          excludeFromSemantics: true,
          onTapDown: _isEnabled ? (details) => _updateFromLocalX(details.localPosition.dx, trackWidth) : null,
          onHorizontalDragUpdate: _isEnabled ? (details) => _updateFromLocalX(details.localPosition.dx, trackWidth) : null,
          child: SizedBox(
            width: double.infinity,
            height: SliderNode.size,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: (SliderNode.size - 8) / 2,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(color: ColorTokens.gray100, borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: (SliderNode.size - 8) / 2,
                  child: Container(
                    width: fillWidth,
                    height: 8,
                    decoration: BoxDecoration(color: _isEnabled ? ColorTokens.black : ColorTokens.gray300, borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                Positioned(
                  left: nodeLeft,
                  child: SliderNode(label: _label, isEnabled: _isEnabled, isHovered: _hovered, isFocused: _focused),
                ),
              ],
            ),
          ),
        );
      },
    );

    return Semantics(
      slider: true,
      label: widget.semanticLabel,
      value: _label,
      enabled: _isEnabled,
      increasedValue: (widget.labelBuilder ?? (v) => '${v.round()}%')(_snap(widget.value + widget.step)),
      decreasedValue: (widget.labelBuilder ?? (v) => '${v.round()}%')(_snap(widget.value - widget.step)),
      onIncrease: _isEnabled ? () => _step(widget.step) : null,
      onDecrease: _isEnabled ? () => _step(-widget.step) : null,
      child: Focus(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,
        onFocusChange: (hasFocus) => setState(() => _focused = hasFocus),
        child: MouseRegion(
          cursor: _isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: Row(
            spacing: 8,
            children: [
              Expanded(child: track),
              if (widget.showValueLabel) Text(_label, style: context.textStyles.labelMedium.copyWith(color: ColorTokens.gray900)),
            ],
          ),
        ),
      ),
    );
  }
}
