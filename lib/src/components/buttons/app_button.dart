import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/buttons/button_variant.dart';
import 'package:ngh09_ui_kit/src/theme/app_colors.dart';
import 'package:ngh09_ui_kit/src/tokens/durations.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A themeable button built on the kit's semantic tokens.
///
/// `AppButton` is the canonical action component. It supports four
/// [ButtonVariant]s (filled / tonal / outlined / text), three [ButtonSize]s,
/// optional [leading]/[trailing] icons, and `loading`/`disabled` states.
///
/// All colors, spacing, radii and text styles are read from the active theme
/// (`context.colors`, `context.spacing`, …), so the button automatically
/// adapts to light/dark mode and any custom brand theme — nothing is
/// hardcoded.
///
/// ```dart
/// AppButton(
///   label: 'Save',
///   onPressed: _save,
///   leading: const Icon(Icons.check),
/// );
///
/// AppButton.outlined(
///   label: 'Cancel',
///   size: ButtonSize.small,
///   onPressed: _cancel,
/// );
/// ```
///
/// A button is disabled when [onPressed] is `null` or [isLoading] is `true`.
/// While [isLoading] it shows a progress indicator in place of the icons and
/// ignores taps, but keeps its label and footprint so the layout does not jump.
class AppButton extends StatelessWidget {
  /// Creates a button with an explicit [variant] (defaults to
  /// [ButtonVariant.filled]).
  const AppButton({
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expanded = false,
    super.key,
  });

  /// Creates a high-emphasis [ButtonVariant.filled] button.
  const AppButton.filled({
    required this.label,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expanded = false,
    super.key,
  }) : variant = ButtonVariant.filled;

  /// Creates a medium-emphasis [ButtonVariant.tonal] button.
  const AppButton.tonal({
    required this.label,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expanded = false,
    super.key,
  }) : variant = ButtonVariant.tonal;

  /// Creates a medium-emphasis [ButtonVariant.outlined] button.
  const AppButton.outlined({
    required this.label,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expanded = false,
    super.key,
  }) : variant = ButtonVariant.outlined;

  /// Creates a low-emphasis [ButtonVariant.text] button.
  const AppButton.text({
    required this.label,
    this.onPressed,
    this.size = ButtonSize.medium,
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
  /// When `null`, the button is rendered in its disabled state and does not
  /// respond to input.
  final VoidCallback? onPressed;

  /// The visual emphasis of the button. See [ButtonVariant].
  final ButtonVariant variant;

  /// The size of the button. See [ButtonSize].
  final ButtonSize size;

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

  /// Whether the button currently reacts to input.
  bool get _isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final style = _buttonStyle(context);

    final child = _ButtonContent(
      label: label,
      labelStyle: _labelStyle(context),
      leading: leading,
      trailing: trailing,
      isLoading: isLoading,
      iconSize: _iconSize,
      spacing: context.spacing.sm,
      progressColor: _foregroundColor(colors),
    );

    final button = switch (variant) {
      ButtonVariant.filled => FilledButton(
        onPressed: _isEnabled ? onPressed : null,
        style: style,
        child: child,
      ),
      ButtonVariant.tonal => FilledButton.tonal(
        onPressed: _isEnabled ? onPressed : null,
        style: style,
        child: child,
      ),
      ButtonVariant.outlined => OutlinedButton(
        onPressed: _isEnabled ? onPressed : null,
        style: style,
        child: child,
      ),
      ButtonVariant.text => TextButton(
        onPressed: _isEnabled ? onPressed : null,
        style: style,
        child: child,
      ),
    };

    // The underlying Material button already provides complete semantics
    // (button flag, enabled state, tap action and the label from its [Text]
    // child), so no extra Semantics wrapper is needed.
    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    final colors = context.colors;
    final radii = context.radii;
    final foreground = _foregroundColor(colors);
    final background = _backgroundColor(colors);

    return ButtonStyle(
      animationDuration: DurationTokens.fast,
      minimumSize: WidgetStatePropertyAll(Size(0, _height)),
      padding: WidgetStatePropertyAll(_padding),
      foregroundColor: WidgetStatePropertyAll(foreground),
      backgroundColor: background == null
          ? null
          : WidgetStatePropertyAll(background),
      side: variant == ButtonVariant.outlined
          ? WidgetStatePropertyAll(BorderSide(color: colors.outline))
          : null,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: radii.borderRadiusMd),
      ),
      // Disabled colors are applied by the underlying Material button using
      // opacity; we only need to supply the enabled-state colors above.
    );
  }

  TextStyle _labelStyle(BuildContext context) {
    final styles = context.textStyles;
    return switch (size) {
      ButtonSize.small => styles.labelMedium,
      ButtonSize.medium => styles.labelLarge,
      ButtonSize.large => styles.titleMedium,
    };
  }

  Color _foregroundColor(AppColors colors) {
    return switch (variant) {
      ButtonVariant.filled => colors.onPrimary,
      ButtonVariant.tonal => colors.onPrimaryContainer,
      ButtonVariant.outlined => colors.primary,
      ButtonVariant.text => colors.primary,
    };
  }

  Color? _backgroundColor(AppColors colors) {
    return switch (variant) {
      ButtonVariant.filled => colors.primary,
      ButtonVariant.tonal => colors.primaryContainer,
      ButtonVariant.outlined => Colors.transparent,
      ButtonVariant.text => Colors.transparent,
    };
  }

  double get _height => switch (size) {
    ButtonSize.small => 36,
    ButtonSize.medium => 44,
    ButtonSize.large => 52,
  };

  double get _iconSize => switch (size) {
    ButtonSize.small => 16,
    ButtonSize.medium => 18,
    ButtonSize.large => 20,
  };

  EdgeInsets get _padding => switch (size) {
    ButtonSize.small => const EdgeInsets.symmetric(horizontal: 12),
    ButtonSize.medium => const EdgeInsets.symmetric(horizontal: 16),
    ButtonSize.large => const EdgeInsets.symmetric(horizontal: 24),
  };
}

/// Lays out the leading icon, label and trailing icon of an [AppButton],
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
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: progressColor,
      ),
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
