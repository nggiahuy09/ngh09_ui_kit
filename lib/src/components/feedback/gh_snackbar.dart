import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/feedback/gh_snackbar_state.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A transient, low-emphasis notification bar with four semantic states.
///
/// Snackbars communicate a brief status message inline with the content that triggered it — unlike a full alert banner, they are meant to be shown temporarily (e.g. via a [SnackBar]/overlay) and always render on a single line. They may include:
///
/// * An optional leading icon indicating the state.
/// * A single-line message.
/// * A trailing affordance — either a close (×) icon, or a "Dismiss" text button when [ctaButton] is `true`.
///
/// ```dart
/// GHSnackbar(
///   message: 'Assist text for the user',
///   onDismiss: () => setState(() => _show = false),
/// )
///
/// GHSnackbar(
///   message: 'Something went wrong.',
///   state: GHSnackbarState.error,
///   ctaButton: true,
///   onDismiss: _retry,
/// )
/// ```
///
/// **Width.** The snackbar sizes to its content on the trailing edge and expands to fill its parent on the leading edge. Constrain it with a [SizedBox] to match the Finesse fixed-width spec.
///
/// **Corners.** Pass `smooth: true` to apply an 8 px radius matching the Finesse "Smooth" variant; omit (or `false`) for the "Sharp" variant.
class GHSnackbar extends StatelessWidget {
  /// Creates a snackbar.
  const GHSnackbar({
    required this.message,
    this.state = GHSnackbarState.active,
    this.smooth = false,
    this.showLeadingIcon = true,
    this.ctaButton = false,
    this.ctaLabel = 'Dismiss',
    this.onDismiss,
    super.key,
  });

  /// The message. Rendered in a single line, truncating with an ellipsis.
  final String message;

  /// The semantic state, controlling the color scheme.
  final GHSnackbarState state;

  /// Whether to apply an 8 px corner radius (`true` = Smooth, `false` = Sharp).
  final bool smooth;

  /// Whether to show the state icon on the leading edge. Defaults to `true`.
  final bool showLeadingIcon;

  /// Whether the trailing affordance is a "Dismiss" text button rather than a close (×) icon. Defaults to `false`.
  final bool ctaButton;

  /// The label for the trailing CTA button. Only used when [ctaButton] is `true`. Defaults to `"Dismiss"`.
  final String ctaLabel;

  /// Callback fired when the trailing affordance is tapped.
  ///
  /// When `null`, no trailing affordance is shown.
  final VoidCallback? onDismiss;

  List<BoxShadow> _shadows(BuildContext context) {
    final shadows = context.shadows;
    return switch (state) {
      GHSnackbarState.active => shadows.medium,
      GHSnackbarState.error => shadows.hoverError,
      GHSnackbarState.warning => shadows.hoverWarning,
      GHSnackbarState.success => shadows.hoverSuccess,
    };
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;
    final contentColor = state.contentColor;

    final trailing = onDismiss == null
        ? null
        : GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.opaque,
            child: ctaButton
                ? Text(
                    ctaLabel,
                    style: textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600, color: state.dismissLabelColor),
                  )
                : GHHeroIcon(GHIcons.xMark, size: 14, color: contentColor, semanticLabel: 'Dismiss'),
          );

    return Semantics(
      container: true,
      label: '${state.name} snackbar: $message',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: state.backgroundColor,
          borderRadius: smooth ? context.radii.borderRadiusMd : null,
          boxShadow: _shadows(context),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            spacing: 10,
            children: [
              if (showLeadingIcon) GHHeroIcon(GHIcons.questionMarkCircle, size: 14, color: contentColor, semanticLabel: state.name),
              Expanded(
                child: Text(
                  message,
                  overflow: TextOverflow.ellipsis,
                  style: textStyles.bodySmall.copyWith(color: contentColor),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
