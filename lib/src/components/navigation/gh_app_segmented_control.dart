import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngh09_ui_kit/src/components/navigation/gh_segmented_control_item.dart';
import 'package:ngh09_ui_kit/src/components/navigation/segmented_control_corner.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A themeable segmented control built on the Finesse UI Kit design tokens.
///
/// `GHAppSegmentedControl` lets a user pick exactly one option from a small, fixed set of [segments] rendered as a single fused bar. Each segment can carry a label, an icon, or both (see [GHSegmentedControlItem]). Segments share hairline borders so the control reads as one control rather than a row of separate buttons, and the outer corners follow [corner].
///
/// ```dart
/// GHAppSegmentedControl(
///   segments: const [
///     GHSegmentedControlItem(label: 'Day'),
///     GHSegmentedControlItem(label: 'Week'),
///     GHSegmentedControlItem(label: 'Month'),
///   ],
///   selectedIndex: _selected,
///   onSelectedIndexChanged: (i) => setState(() => _selected = i),
/// );
/// ```
///
/// The control is disabled when [onSelectedIndexChanged] is `null`.
class GHAppSegmentedControl extends StatelessWidget {
  /// Creates a segmented control with at least two [segments].
  ///
  /// Not a `const` constructor: [segments].length must be validated at runtime, which Dart's const evaluator cannot do for a `List`.
  const GHAppSegmentedControl({
    required this.segments,
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
    this.corner = SegmentedControlCorner.sharp,
    super.key,
  }) : assert(segments.length >= 2, 'A segmented control needs at least two segments.'),
       assert(selectedIndex >= 0 && selectedIndex < segments.length, 'selectedIndex must index into segments.');

  /// The options shown, in order, from leading to trailing.
  final List<GHSegmentedControlItem> segments;

  /// The index of the currently selected segment.
  final int selectedIndex;

  /// Called with the tapped index when the user selects a segment.
  ///
  /// When `null`, the control is disabled and does not respond to input.
  final ValueChanged<int>? onSelectedIndexChanged;

  /// The corner-radius shape. See [SegmentedControlCorner].
  final SegmentedControlCorner corner;

  bool get _isEnabled => onSelectedIndexChanged != null;

  @override
  Widget build(BuildContext context) {
    final radius = corner == SegmentedControlCorner.smooth ? context.radii.borderRadiusMd : BorderRadius.zero;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (index, segment) in segments.indexed)
          Flexible(
            child: _Segment(
              key: ValueKey(index),
              item: segment,
              selected: index == selectedIndex,
              isFirst: index == 0,
              isLast: index == segments.length - 1,
              radius: radius,
              onSelected: _isEnabled ? () => onSelectedIndexChanged!(index) : null,
            ),
          ),
      ],
    );
  }
}

/// A single interactive segment within a [GHAppSegmentedControl].
class _Segment extends StatefulWidget {
  const _Segment({
    required this.item,
    required this.selected,
    required this.isFirst,
    required this.isLast,
    required this.radius,
    required this.onSelected,
    super.key,
  });

  final GHSegmentedControlItem item;
  final bool selected;
  final bool isFirst;
  final bool isLast;
  final BorderRadius radius;
  final VoidCallback? onSelected;

  @override
  State<_Segment> createState() => _SegmentState();
}

class _SegmentState extends State<_Segment> {
  bool _hovered = false;
  bool _focused = false;

  bool get _isEnabled => widget.onSelected != null;

  bool get _iconOnly => widget.item.label == null;

  // ── Colors ─────────────────────────────────────────────────────────────────

  Color _backgroundColor(BuildContext context) {
    final colors = context.colors;
    if (!_isEnabled) return widget.selected ? colors.outline : colors.surface;
    if (widget.selected) return colors.primary;
    if (_hovered) return colors.surfaceVariant;
    return colors.surface;
  }

  Color _foregroundColor(BuildContext context) {
    final colors = context.colors;
    if (!_isEnabled) return widget.selected ? colors.onPrimary : colors.outline;
    if (widget.selected) return colors.onPrimary;
    if (_hovered) return colors.onSurface;
    return colors.onSurfaceVariant;
  }

  // ── Shadows ────────────────────────────────────────────────────────────────

  List<BoxShadow> _boxShadow(BuildContext context) {
    if (!_isEnabled || !_focused) return const [];
    final shadows = context.shadows;
    return widget.selected ? shadows.focusPrimary : shadows.focusSecondary;
  }

  // ── Shape ──────────────────────────────────────────────────────────────────

  BorderRadius get _cornerRadius => BorderRadius.only(
    topLeft: widget.isFirst ? widget.radius.topLeft : Radius.zero,
    bottomLeft: widget.isFirst ? widget.radius.bottomLeft : Radius.zero,
    topRight: widget.isLast ? widget.radius.topRight : Radius.zero,
    bottomRight: widget.isLast ? widget.radius.bottomRight : Radius.zero,
  );

  // ── Interaction ────────────────────────────────────────────────────────────

  void _handleTap() => widget.onSelected?.call();

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
    final foreground = _foregroundColor(context);
    final labelStyle = context.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600, color: foreground);

    final content = _iconOnly
        ? IconTheme.merge(
            data: IconThemeData(size: 20, color: foreground),
            child: widget.item.icon!,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.item.icon != null) ...[
                IconTheme.merge(
                  data: IconThemeData(size: 16, color: foreground),
                  child: widget.item.icon!,
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(widget.item.label!, style: labelStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ],
          );

    final borderSide = BorderSide(color: context.colors.outlineVariant);
    final segment = AnimatedContainer(
      duration: DurationTokens.fast,
      padding: _iconOnly ? const EdgeInsets.all(10) : const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius: _cornerRadius,
        border: Border(top: borderSide, bottom: borderSide, right: borderSide, left: widget.isFirst ? borderSide : BorderSide.none),
        boxShadow: _boxShadow(context),
      ),
      child: ExcludeSemantics(child: content),
    );

    return Semantics(
      container: true,
      button: true,
      selected: widget.selected,
      enabled: _isEnabled,
      label: widget.item.label,
      onTap: _isEnabled ? _handleTap : null,
      child: Focus(
        onKeyEvent: _handleKeyEvent,
        onFocusChange: (hasFocus) => setState(() => _focused = hasFocus),
        child: MouseRegion(
          cursor: _isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(onTap: _isEnabled ? _handleTap : null, child: segment),
        ),
      ),
    );
  }
}
