import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/display/chip_variant.dart';
import 'package:ngh09_ui_kit/src/theme/app_colors.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A compact, interactive element built on the kit's semantic tokens.
///
/// `AppChip` covers the three Material 3 chip families through [ChipVariant]:
/// * [ChipVariant.input] — a discrete entry (tag, recipient) with an optional
///   [leading] icon and a trailing delete affordance ([onDeleted]).
/// * [ChipVariant.filter] — a toggleable filter reflecting [selected]; tapping
///   it reports the *next* selection state through [onSelected].
/// * [ChipVariant.choice] — a single selection from a set, also reflecting
///   [selected] via [onSelected].
///
/// All colors, radii, spacing and text styles are read from the active theme
/// (`context.colors`, `context.radii`, …), so the chip adapts to light/dark
/// mode and any custom brand theme — nothing is hardcoded. When [selected], the
/// chip fills with `primaryContainer`; otherwise it uses `surfaceVariant` with
/// an `outline` border.
///
/// A chip is disabled when [enabled] is `false`, in which case it ignores all
/// input.
///
/// ```dart
/// AppChip.filter(
///   label: 'Unread',
///   selected: _unreadOnly,
///   onSelected: (value) => setState(() => _unreadOnly = value),
/// );
///
/// AppChip.input(
///   label: 'design',
///   leading: const Icon(Icons.tag),
///   onDeleted: () => _removeTag('design'),
/// );
/// ```
class AppChip extends StatelessWidget {
  /// Creates a chip with an explicit [variant] (defaults to
  /// [ChipVariant.input]).
  const AppChip({
    required this.label,
    this.variant = ChipVariant.input,
    this.size = ChipSize.medium,
    this.selected = false,
    this.enabled = true,
    this.expanded = false,
    this.leading,
    this.onPressed,
    this.onSelected,
    this.onDeleted,
    super.key,
  });

  /// Creates a [ChipVariant.input] chip — a discrete entry with an optional
  /// [leading] icon and a trailing delete affordance ([onDeleted]).
  const AppChip.input({
    required this.label,
    this.size = ChipSize.medium,
    this.enabled = true,
    this.expanded = false,
    this.leading,
    this.onPressed,
    this.onDeleted,
    super.key,
  }) : variant = ChipVariant.input,
       selected = false,
       onSelected = null;

  /// Creates a [ChipVariant.filter] chip — a toggleable filter reflecting
  /// [selected] and reporting the next state through [onSelected].
  const AppChip.filter({
    required this.label,
    required this.selected,
    this.size = ChipSize.medium,
    this.enabled = true,
    this.expanded = false,
    this.leading,
    this.onSelected,
    super.key,
  }) : variant = ChipVariant.filter,
       onPressed = null,
       onDeleted = null;

  /// Creates a [ChipVariant.choice] chip — a single selection from a set,
  /// reflecting [selected] and reporting the next state through [onSelected].
  const AppChip.choice({
    required this.label,
    required this.selected,
    this.size = ChipSize.medium,
    this.enabled = true,
    this.expanded = false,
    this.leading,
    this.onSelected,
    super.key,
  }) : variant = ChipVariant.choice,
       onPressed = null,
       onDeleted = null;

  /// The chip's text label.
  final String label;

  /// The interaction model of the chip. See [ChipVariant].
  final ChipVariant variant;

  /// The size of the chip. See [ChipSize].
  final ChipSize size;

  /// Whether the chip is in its selected state.
  ///
  /// Meaningful only for [ChipVariant.filter] and [ChipVariant.choice]; always
  /// `false` for [ChipVariant.input].
  final bool selected;

  /// Whether the chip currently reacts to input.
  ///
  /// When `false`, the chip is rendered in its disabled state and does not fire
  /// [onPressed], [onSelected] or [onDeleted].
  final bool enabled;

  /// Whether the chip should stretch to fill the available horizontal space.
  ///
  /// When `false` (the default) the chip hugs its content; when `true` it grows
  /// to the width offered by its parent, with content centered.
  final bool expanded;

  /// Optional widget shown before the [label] (typically an [Icon]).
  final Widget? leading;

  /// Called when an [ChipVariant.input] chip body is tapped.
  ///
  /// Ignored for filter/choice chips, which report through [onSelected].
  final VoidCallback? onPressed;

  /// Called with the next selection state when a [ChipVariant.filter] or
  /// [ChipVariant.choice] chip is tapped.
  final ValueChanged<bool>? onSelected;

  /// Called when the trailing delete affordance of an [ChipVariant.input] chip
  /// is tapped.
  ///
  /// When `null`, no delete affordance is shown.
  final VoidCallback? onDeleted;

  /// Whether the chip currently reacts to body taps.
  bool get _isInteractive {
    if (!enabled) return false;
    return switch (variant) {
      ChipVariant.input => onPressed != null,
      ChipVariant.filter || ChipVariant.choice => onSelected != null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foreground = _foregroundColor(colors);
    final showDelete =
        enabled && variant == ChipVariant.input && onDeleted != null;

    final content = _ChipContent(
      label: label,
      labelStyle: _labelStyle(context).copyWith(color: foreground),
      leading: leading,
      foreground: foreground,
      iconSize: _iconSize,
      spacing: context.spacing.xs,
      onDeleted: onDeleted,
      showDelete: showDelete,
    );

    final decorated = Container(
      constraints: BoxConstraints(
        minWidth: expanded ? double.infinity : 0,
        minHeight: _height,
      ),
      padding: _paddingFor(showDelete: showDelete),
      // Only center within the box when expanded; an unconditional alignment
      // would make the chip greedily fill loose constraints.
      alignment: expanded ? Alignment.center : null,
      decoration: BoxDecoration(
        color: _backgroundColor(colors),
        borderRadius: context.radii.borderRadiusFull,
        border: selected ? null : Border.all(color: colors.outline),
      ),
      child: content,
    );

    if (!_isInteractive) {
      // Still expose selection state to accessibility for filter/choice chips.
      return Semantics(
        selected: variant == ChipVariant.input ? null : selected,
        child: decorated,
      );
    }

    return Semantics(
      button: true,
      selected: variant == ChipVariant.input ? null : selected,
      child: Material(
        type: MaterialType.transparency,
        borderRadius: context.radii.borderRadiusFull,
        child: InkWell(
          onTap: _onTap,
          borderRadius: context.radii.borderRadiusFull,
          child: decorated,
        ),
      ),
    );
  }

  void _onTap() {
    switch (variant) {
      case ChipVariant.input:
        onPressed?.call();
      case ChipVariant.filter:
      case ChipVariant.choice:
        onSelected?.call(!selected);
    }
  }

  TextStyle _labelStyle(BuildContext context) {
    final styles = context.textStyles;
    return switch (size) {
      ChipSize.small => styles.labelSmall,
      ChipSize.medium => styles.labelMedium,
    };
  }

  Color _backgroundColor(AppColors colors) {
    if (selected) return colors.primaryContainer;
    return colors.surfaceVariant;
  }

  Color _foregroundColor(AppColors colors) {
    if (selected) return colors.onPrimaryContainer;
    return colors.onSurfaceVariant;
  }

  double get _height => switch (size) {
    ChipSize.small => 28,
    ChipSize.medium => 32,
  };

  double get _iconSize => switch (size) {
    ChipSize.small => 14,
    ChipSize.medium => 18,
  };

  EdgeInsetsGeometry _paddingFor({required bool showDelete}) => switch (size) {
    ChipSize.small => EdgeInsets.only(
      left: 8,
      right: showDelete ? 4 : 8,
    ),
    ChipSize.medium => EdgeInsets.only(
      left: 12,
      right: showDelete ? 6 : 12,
    ),
  };
}

/// Lays out the leading icon, label and optional delete affordance of an
/// [AppChip].
class _ChipContent extends StatelessWidget {
  const _ChipContent({
    required this.label,
    required this.labelStyle,
    required this.leading,
    required this.foreground,
    required this.iconSize,
    required this.spacing,
    required this.onDeleted,
    required this.showDelete,
  });

  final String label;
  final TextStyle labelStyle;
  final Widget? leading;
  final Color foreground;
  final double iconSize;
  final double spacing;
  final VoidCallback? onDeleted;
  final bool showDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[
          IconTheme.merge(
            data: IconThemeData(size: iconSize, color: foreground),
            child: leading!,
          ),
          SizedBox(width: spacing),
        ],
        Flexible(
          child: Text(
            label,
            style: labelStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showDelete) ...[
          SizedBox(width: spacing),
          // The delete affordance is its own tap target so it does not fire the
          // chip body's onTap.
          GestureDetector(
            onTap: onDeleted,
            child: Semantics(
              button: true,
              label: 'Delete',
              child: Icon(
                Icons.close,
                size: iconSize,
                color: foreground,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
