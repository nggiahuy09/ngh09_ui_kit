import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icon_data.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/components/icons/heroicon_style.dart';
import 'package:ngh09_ui_kit/src/components/inputs/dropdown_item_size.dart';
import 'package:ngh09_ui_kit/src/components/inputs/dropdown_leading_type.dart';
import 'package:ngh09_ui_kit/src/components/inputs/dropdown_trailing_type.dart';
import 'package:ngh09_ui_kit/src/components/inputs/gh_app_toggle.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// The atomic row of a dropdown menu, built on the Finesse UI Kit "Dropdown
/// List Items" spec.
///
/// A `GHAppDropdownListItem` always shows a [label]. Everything else is
/// optional and driven by the two "type" properties from the Finesse spec:
///
/// * [leadingType] — [GHDropdownLeadingType.none] / `.icon` / `.avatar` /
///   `.flag` / `.checkbox`. Provide the matching content via [leadingIcon]
///   (for `.icon`) or [leading] (for `.avatar` / `.flag`, e.g. a
///   `GHUserAvatar` or `GHCountryFlag`).
/// * [trailingType] — `.none` / `.chevron` / `.checkmark` / `.toggle` /
///   `.label`. `.checkmark` only renders when [selected] is `true`;
///   `.toggle` renders a `GHAppToggle` bound to [toggleValue] /
///   [onToggleChanged]; `.label` renders [trailingLabel].
///
/// [supportingText] adds a muted secondary line next to [label] (e.g. an
/// `@handle`). The row reflects the Finesse "Active / Hover / Focused /
/// Selected / Disabled" states: hover and focus emerge from user
/// interaction, [selected] and disabled (via a `null` [onTap]) are supplied
/// by the caller.
///
/// ```dart
/// GHAppDropdownListItem(
///   label: 'Account Information',
///   leadingType: GHDropdownLeadingType.icon,
///   leadingIcon: GHIcons.userCircle,
///   trailingType: GHDropdownTrailingType.chevron,
///   onTap: () {},
/// );
///
/// GHAppDropdownListItem(
///   label: 'Biometric Authentication',
///   leadingType: GHDropdownLeadingType.icon,
///   leadingIcon: GHIcons.fingerPrint,
///   trailingType: GHDropdownTrailingType.toggle,
///   toggleValue: _biometricsOn,
///   onToggleChanged: (v) => setState(() => _biometricsOn = v),
///   onTap: () {},
/// );
/// ```
class GHAppDropdownListItem extends StatefulWidget {
  /// Creates a dropdown list item.
  const GHAppDropdownListItem({
    required this.label,
    this.supportingText,
    this.leadingType = GHDropdownLeadingType.none,
    this.leadingIcon,
    this.leading,
    this.trailingType = GHDropdownTrailingType.none,
    this.trailingLabel,
    this.toggleValue = false,
    this.onToggleChanged,
    this.selected = false,
    this.size = GHDropdownItemSize.medium,
    this.onTap,
    this.semanticLabel,
    super.key,
  }) : assert(leadingType != GHDropdownLeadingType.icon || leadingIcon != null, 'Provide leadingIcon when leadingType is GHDropdownLeadingType.icon.'),
       assert(
         leadingType != GHDropdownLeadingType.avatar && leadingType != GHDropdownLeadingType.flag || leading != null,
         'Provide leading when leadingType is .avatar or .flag.',
       );

  /// The row's primary text.
  final String label;

  /// Optional muted secondary text shown next to [label] (e.g. `@handle`).
  final String? supportingText;

  /// The leading affordance. See [GHDropdownLeadingType].
  final GHDropdownLeadingType leadingType;

  /// The glyph shown when [leadingType] is [GHDropdownLeadingType.icon].
  final GHIconData? leadingIcon;

  /// The widget shown when [leadingType] is [GHDropdownLeadingType.avatar] or
  /// [GHDropdownLeadingType.flag] — typically a `GHUserAvatar` or
  /// `GHCountryFlag`.
  final Widget? leading;

  /// The trailing affordance. See [GHDropdownTrailingType].
  final GHDropdownTrailingType trailingType;

  /// The text shown when [trailingType] is [GHDropdownTrailingType.label].
  final String? trailingLabel;

  /// The toggle's value when [trailingType] is [GHDropdownTrailingType.toggle].
  final bool toggleValue;

  /// Called when the trailing toggle is flipped. Pass `null` to disable it.
  ///
  /// Only used when [trailingType] is [GHDropdownTrailingType.toggle].
  final ValueChanged<bool>? onToggleChanged;

  /// Whether the row is selected — highlights the row and, combined with
  /// [trailingType]/[leadingType], shows a checkmark or a checked checkbox.
  final bool selected;

  /// The row's size. See [GHDropdownItemSize].
  final GHDropdownItemSize size;

  /// Called when the row is tapped. Pass `null` to disable the row.
  final VoidCallback? onTap;

  /// Optional label read by screen readers instead of [label].
  final String? semanticLabel;

  @override
  State<GHAppDropdownListItem> createState() => _GHAppDropdownListItemState();
}

class _GHAppDropdownListItemState extends State<GHAppDropdownListItem> {
  bool _hovered = false;
  bool _focused = false;

  bool get _isEnabled => widget.onTap != null;

  // ── Dimensions ─────────────────────────────────────────────────────────────

  double get _verticalPadding => switch (widget.size) {
    GHDropdownItemSize.small => 8,
    GHDropdownItemSize.medium => 10,
    GHDropdownItemSize.large => 12,
  };

  double get _iconSize => switch (widget.size) {
    GHDropdownItemSize.small => 16,
    GHDropdownItemSize.medium => 18,
    GHDropdownItemSize.large => 20,
  };

  TextStyle _labelStyle(BuildContext context) {
    final base = widget.size == GHDropdownItemSize.small ? context.textStyles.bodySmall : context.textStyles.bodyMedium;
    final colors = context.colors;
    return base.copyWith(
      fontWeight: FontWeight.w500,
      color: _isEnabled ? colors.onSurface : colors.outline,
    );
  }

  TextStyle _supportingStyle(BuildContext context) =>
      context.textStyles.bodySmall.copyWith(color: _isEnabled ? context.colors.onSurfaceVariant : context.colors.outlineVariant);

  // ── Colors ─────────────────────────────────────────────────────────────────

  Color _backgroundColor(BuildContext context) {
    if (!_isEnabled) return ColorTokens.transparent;
    if (_hovered || widget.selected) return context.colors.surfaceVariant;
    return ColorTokens.transparent;
  }

  Color _contentColor(BuildContext context) => _isEnabled ? context.colors.onSurfaceVariant : context.colors.outlineVariant;

  // ── Interaction ────────────────────────────────────────────────────────────

  void _handleTap() => widget.onTap?.call();

  KeyEventResult _handleKeyEvent(FocusNode _, KeyEvent event) {
    if (!_isEnabled) return KeyEventResult.ignored;
    if (event is KeyDownEvent && (event.logicalKey == LogicalKeyboardKey.space || event.logicalKey == LogicalKeyboardKey.enter)) {
      _handleTap();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  // ── Leading / trailing ────────────────────────────────────────────────────

  Widget? _buildLeading(BuildContext context) {
    switch (widget.leadingType) {
      case GHDropdownLeadingType.none:
        return null;
      case GHDropdownLeadingType.icon:
        return GHHeroIcon(widget.leadingIcon!, size: _iconSize, color: _contentColor(context));
      case GHDropdownLeadingType.avatar:
      case GHDropdownLeadingType.flag:
        return widget.leading;
      case GHDropdownLeadingType.checkbox:
        return _CheckboxIndicator(checked: widget.selected, enabled: _isEnabled);
    }
  }

  Widget? _buildTrailing(BuildContext context) {
    final colors = context.colors;
    switch (widget.trailingType) {
      case GHDropdownTrailingType.none:
        return null;
      case GHDropdownTrailingType.chevron:
        return GHHeroIcon(GHIcons.chevronRight, style: HeroIconStyle.mini, size: 16, color: colors.onSurfaceVariant);
      case GHDropdownTrailingType.checkmark:
        return SizedBox(width: 18, child: widget.selected ? GHHeroIcon(GHIcons.check, size: 18, color: colors.onSurface) : null);
      case GHDropdownTrailingType.toggle:
        return GHAppToggle(value: widget.toggleValue, onChanged: widget.onToggleChanged);
      case GHDropdownTrailingType.label:
        return Text(widget.trailingLabel ?? '', style: context.textStyles.bodySmall.copyWith(color: colors.onSurfaceVariant));
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final leading = _buildLeading(context);
    final trailing = _buildTrailing(context);
    final spacing = context.spacing;

    final content = AnimatedContainer(
      duration: DurationTokens.fast,
      padding: EdgeInsets.symmetric(horizontal: spacing.smd, vertical: _verticalPadding),
      decoration: BoxDecoration(color: _backgroundColor(context), borderRadius: context.radii.borderRadiusSm),
      child: Row(
        children: [
          if (leading != null) ...[leading, SizedBox(width: spacing.sm)],
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: spacing.xs,
              children: [
                Flexible(
                  child: Text(widget.label, style: _labelStyle(context), overflow: TextOverflow.ellipsis),
                ),
                if (widget.supportingText != null) Text(widget.supportingText!, style: _supportingStyle(context)),
              ],
            ),
          ),
          if (trailing != null) ...[
            const Spacer(),
            SizedBox(width: spacing.sm),
            trailing,
          ],
        ],
      ),
    );

    return Semantics(
      button: true,
      enabled: _isEnabled,
      selected: widget.selected,
      label: widget.semanticLabel ?? widget.label,
      onTap: _isEnabled ? _handleTap : null,
      child: Focus(
        onKeyEvent: _handleKeyEvent,
        onFocusChange: (hasFocus) => setState(() => _focused = hasFocus),
        child: MouseRegion(
          cursor: _isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: _isEnabled ? _handleTap : null,
            behavior: HitTestBehavior.opaque,
            child: _focused && _isEnabled
                ? Container(
                    decoration: BoxDecoration(borderRadius: context.radii.borderRadiusSm, boxShadow: context.shadows.focusSecondary),
                    child: ExcludeSemantics(child: content),
                  )
                : ExcludeSemantics(child: content),
          ),
        ),
      ),
    );
  }
}

/// The decorative (non-interactive) checkbox glyph shown by a
/// [GHAppDropdownListItem] with [GHDropdownLeadingType.checkbox] — the row's
/// own tap target drives [GHAppDropdownListItem.selected], not this box.
class _CheckboxIndicator extends StatelessWidget {
  const _CheckboxIndicator({required this.checked, required this.enabled});

  final bool checked;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final background = !enabled
        ? (checked ? colors.outline : colors.surfaceVariant)
        : (checked ? colors.primary : colors.surface);

    return Container(
      width: 16,
      height: 16,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: context.radii.borderRadiusSm,
        border: checked ? null : Border.all(color: enabled ? colors.outline : colors.outlineVariant),
      ),
      child: checked ? GHHeroIcon(GHIcons.check, size: 12, color: enabled ? colors.onPrimary : colors.outlineVariant) : null,
    );
  }
}
