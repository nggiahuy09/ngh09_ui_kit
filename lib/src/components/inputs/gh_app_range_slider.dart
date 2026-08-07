import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngh09_ui_kit/src/components/inputs/slider_indicator.dart';
import 'package:ngh09_ui_kit/src/components/inputs/slider_node.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';

/// A themeable double-node ("range") slider built on the Finesse UI Kit design tokens.
///
/// `GHAppRangeSlider` drags two [SliderNode] handles along a shared track to select a sub-range between [min] and [max] — used for range filters like price or age brackets. [indicator] controls whether each handle shows no label, a text label, or a tooltip above it, formatted by [labelBuilder] (percentage by default).
///
/// ```dart
/// GHAppRangeSlider(
///   values: _priceRange,
///   min: 0,
///   max: 500,
///   indicator: SliderIndicator.tooltip,
///   labelBuilder: (v) => '\$${v.round()}',
///   onChanged: (v) => setState(() => _priceRange = v),
/// );
/// ```
///
/// A range slider is disabled when [onChanged] is `null`.
class GHAppRangeSlider extends StatefulWidget {
  /// Creates a double-node range slider.
  const GHAppRangeSlider({
    required this.values,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.indicator = SliderIndicator.none,
    this.labelBuilder,
    this.startSemanticLabel,
    this.endSemanticLabel,
    super.key,
  }) : assert(min < max, 'min must be less than max'),
       assert(step > 0, 'step must be positive');

  /// The current start/end selection. Both must lie within [min] and [max], with `values.start <= values.end`.
  final RangeValues values;

  /// Called with the new range as the user drags or steps either handle. Pass `null` to disable.
  final ValueChanged<RangeValues>? onChanged;

  /// The lower bound of the slider's range.
  final double min;

  /// The upper bound of the slider's range.
  final double max;

  /// The increment applied per keyboard step and drag snap.
  final double step;

  /// Which value indicator to render above each handle. See [SliderIndicator].
  final SliderIndicator indicator;

  /// Formats a handle's value for [indicator]. Defaults to a rounded percentage.
  final String Function(double value)? labelBuilder;

  /// Optional label read by screen readers for the start handle.
  final String? startSemanticLabel;

  /// Optional label read by screen readers for the end handle.
  final String? endSemanticLabel;

  @override
  State<GHAppRangeSlider> createState() => _GHAppRangeSliderState();
}

class _GHAppRangeSliderState extends State<GHAppRangeSlider> {
  bool _startHovered = false;
  bool _startFocused = false;
  bool _endHovered = false;
  bool _endFocused = false;
  final FocusNode _startFocusNode = FocusNode();
  final FocusNode _endFocusNode = FocusNode();

  bool get _isEnabled => widget.onChanged != null;

  double get _span => widget.max - widget.min;

  String Function(double value) get _label => widget.labelBuilder ?? (v) => '${v.round()}%';

  @override
  void dispose() {
    _startFocusNode.dispose();
    _endFocusNode.dispose();
    super.dispose();
  }

  double _snap(double value) {
    final clamped = value.clamp(widget.min, widget.max);
    final steps = ((clamped - widget.min) / widget.step).round();
    return (widget.min + steps * widget.step).clamp(widget.min, widget.max);
  }

  void _setStart(double value) {
    final snapped = _snap(value).clamp(widget.min, widget.values.end);
    widget.onChanged!(RangeValues(snapped, widget.values.end));
  }

  void _setEnd(double value) {
    final snapped = _snap(value).clamp(widget.values.start, widget.max);
    widget.onChanged!(RangeValues(widget.values.start, snapped));
  }

  void _dragStartBy(double deltaFraction) => _setStart(widget.values.start + deltaFraction * _span);

  void _dragEndBy(double deltaFraction) => _setEnd(widget.values.end + deltaFraction * _span);

  KeyEventResult _handleKeyEvent(bool isStart, FocusNode _, KeyEvent event) {
    if (!_isEnabled || event is! KeyDownEvent) return KeyEventResult.ignored;
    final set = isStart ? _setStart : _setEnd;
    final current = isStart ? widget.values.start : widget.values.end;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
      case LogicalKeyboardKey.arrowDown:
        set(current - widget.step);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowRight:
      case LogicalKeyboardKey.arrowUp:
        set(current + widget.step);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.home:
        set(widget.min);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.end:
        set(widget.max);
        return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  Widget _handle({
    required bool isStart,
    required double trackWidth,
    required FocusNode focusNode,
    required bool hovered,
    required bool focused,
    required ValueChanged<bool> setHovered,
  }) {
    final value = isStart ? widget.values.start : widget.values.end;
    final fraction = _span == 0 ? 0.0 : ((value - widget.min) / _span).clamp(0.0, 1.0);
    final left = fraction * (trackWidth - SliderNode.size);

    final node = SliderNode(label: _label(value), indicator: widget.indicator, isEnabled: _isEnabled, isHovered: hovered, isFocused: focused);

    return Positioned(
      left: left,
      bottom: 0,
      child: Semantics(
        slider: true,
        label: isStart ? widget.startSemanticLabel : widget.endSemanticLabel,
        value: _label(value),
        enabled: _isEnabled,
        increasedValue: _label(_snap(value + widget.step)),
        decreasedValue: _label(_snap(value - widget.step)),
        onIncrease: _isEnabled ? () => (isStart ? _setStart : _setEnd)(value + widget.step) : null,
        onDecrease: _isEnabled ? () => (isStart ? _setStart : _setEnd)(value - widget.step) : null,
        child: Focus(
          focusNode: focusNode,
          onKeyEvent: (node, event) => _handleKeyEvent(isStart, node, event),
          onFocusChange: (hasFocus) => setState(() => isStart ? _startFocused = hasFocus : _endFocused = hasFocus),
          child: MouseRegion(
            cursor: _isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
            onEnter: (_) => setHovered(true),
            onExit: (_) => setHovered(false),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              excludeFromSemantics: true,
              onHorizontalDragStart: _isEnabled ? (_) => focusNode.requestFocus() : null,
              onHorizontalDragUpdate: _isEnabled
                  ? (details) {
                      final travel = trackWidth - SliderNode.size;
                      if (travel <= 0) return;
                      final deltaFraction = details.delta.dx / travel;
                      isStart ? _dragStartBy(deltaFraction) : _dragEndBy(deltaFraction);
                    }
                  : null,
              child: node,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final insetHeight = SliderNode.insetHeight(widget.indicator);

    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth;
        final travel = trackWidth - SliderNode.size;
        final startFraction = _span == 0 ? 0.0 : ((widget.values.start - widget.min) / _span).clamp(0.0, 1.0);
        final endFraction = _span == 0 ? 0.0 : ((widget.values.end - widget.min) / _span).clamp(0.0, 1.0);
        final startCenter = SliderNode.size / 2 + startFraction * travel;
        final endCenter = SliderNode.size / 2 + endFraction * travel;

        return SizedBox(
          width: double.infinity,
          height: SliderNode.size + insetHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 6,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(color: ColorTokens.gray100, borderRadius: BorderRadius.circular(4)),
                ),
              ),
              Positioned(
                left: startCenter,
                bottom: 6,
                child: Container(
                  width: endCenter - startCenter,
                  height: 8,
                  decoration: BoxDecoration(color: _isEnabled ? ColorTokens.black : ColorTokens.gray300, borderRadius: BorderRadius.circular(4)),
                ),
              ),
              _handle(
                isStart: true,
                trackWidth: trackWidth,
                focusNode: _startFocusNode,
                hovered: _startHovered,
                focused: _startFocused,
                setHovered: (v) => setState(() => _startHovered = v),
              ),
              _handle(
                isStart: false,
                trackWidth: trackWidth,
                focusNode: _endFocusNode,
                hovered: _endHovered,
                focused: _endFocused,
                setHovered: (v) => setState(() => _endHovered = v),
              ),
            ],
          ),
        );
      },
    );
  }
}
