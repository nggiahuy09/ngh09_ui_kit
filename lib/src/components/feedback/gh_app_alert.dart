import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/feedback/gh_alert_state.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_hero_icon.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icons.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// A contextual alert banner with four semantic states.
///
/// Alerts communicate a short, time-sensitive message — an error, a warning, a
/// success confirmation, or a neutral notice. They sit inline (not as overlays)
/// and may include:
///
/// * An optional leading icon indicating the state.
/// * A bold headline.
/// * Optional multi-line supporting text.
/// * An optional text action link ("Learn More →").
/// * An optional dismiss (×) button.
///
/// ```dart
/// GHAppAlert(
///   headline: 'Your changes were saved.',
///   state: GHAlertState.success,
///   onDismiss: () => setState(() => _show = false),
/// )
///
/// GHAppAlert(
///   headline: 'Unable to save changes.',
///   state: GHAlertState.error,
///   supportingText: 'Check your network connection and try again.',
///   actionLabel: 'Retry',
///   onAction: _retry,
///   onDismiss: () => setState(() => _show = false),
/// )
/// ```
///
/// **Width.** The alert expands to fill its parent. Constrain it with a
/// [SizedBox] or lay it out inside a [Column] to keep it inline.
///
/// **Corners.** Pass `smooth: true` to apply an 8 px radius matching the
/// Finesse "Smooth" variant; omit (or `false`) for the "Sharp" variant.
class GHAppAlert extends StatelessWidget {
  /// Creates an alert banner.
  const GHAppAlert({
    required this.headline,
    this.state = GHAlertState.active,
    this.supportingText,
    this.actionLabel = 'Learn More',
    this.onAction,
    this.onDismiss,
    this.smooth = false,
    this.showLeadingIcon = true,
    super.key,
  });

  /// The primary message. Rendered in the headline text style.
  final String headline;

  /// The semantic state, controlling the color scheme.
  final GHAlertState state;

  /// Optional body copy rendered below [headline].
  final String? supportingText;

  /// The label for the action link. Defaults to `"Learn More"`.
  ///
  /// Only visible when [onAction] is non-null.
  final String actionLabel;

  /// Callback fired when the user taps the action link.
  ///
  /// When `null`, no action link is shown.
  final VoidCallback? onAction;

  /// Callback fired when the user taps the dismiss (×) button.
  ///
  /// When `null`, no dismiss button is shown.
  final VoidCallback? onDismiss;

  /// Whether to apply an 8 px corner radius (`true` = Smooth, `false` = Sharp).
  final bool smooth;

  /// Whether to show the state icon on the leading edge. Defaults to `true`.
  final bool showLeadingIcon;

  // ── Design-token shadows ──────────────────────────────────────────────────
  // Active uses Shadows/Medium; coloured states use Shadows/Focus States/*.
  // Values match the Finesse shadow spec exactly.
  static const _shadowBase = [
    BoxShadow(offset: Offset(0, 1), blurRadius: 1, color: Color(0x1F000000)),
    BoxShadow(spreadRadius: 1, color: Color(0x29676E76)),
    BoxShadow(offset: Offset(0, 2), blurRadius: 5, color: Color(0x14676E76)),
  ];
  static const _shadowError = [
    BoxShadow(offset: Offset(0, 1), blurRadius: 1, color: Color(0x1F000000)),
    BoxShadow(spreadRadius: 1, color: Color(0x29F34141)),
    BoxShadow(offset: Offset(0, 2), blurRadius: 5, color: Color(0x14676E76)),
    BoxShadow(spreadRadius: 4, color: Color(0x29F34141)),
  ];
  static const _shadowWarning = [
    BoxShadow(offset: Offset(0, 1), blurRadius: 1, color: Color(0x1F000000)),
    BoxShadow(spreadRadius: 1, color: Color(0x29E9A23B)),
    BoxShadow(offset: Offset(0, 2), blurRadius: 5, color: Color(0x14676E76)),
    BoxShadow(spreadRadius: 4, color: Color(0x29E9A23B)),
  ];
  static const _shadowSuccess = [
    BoxShadow(offset: Offset(0, 1), blurRadius: 1, color: Color(0x1F000000)),
    BoxShadow(spreadRadius: 1, color: Color(0x2953B483)),
    BoxShadow(offset: Offset(0, 2), blurRadius: 5, color: Color(0x14676E76)),
    BoxShadow(spreadRadius: 4, color: Color(0x2953B483)),
  ];

  List<BoxShadow> get _shadows => switch (state) {
    GHAlertState.active => _shadowBase,
    GHAlertState.error => _shadowError,
    GHAlertState.warning => _shadowWarning,
    GHAlertState.success => _shadowSuccess,
  };

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;
    final radii = context.radii;
    final accent = state.headlineColor;
    final bodyColor = state.bodyColor;

    return Semantics(
      container: true,
      label: '${state.name} alert: $headline',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: state.backgroundColor,
          borderRadius: smooth ? radii.borderRadiusMd : null,
          boxShadow: _shadows,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              // ── Flexible body (icon + text + action) ──────────────────
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    if (showLeadingIcon)
                      GHHeroIcon(
                        GHIcons.informationCircle,
                        size: 20,
                        color: accent,
                        semanticLabel: state.name,
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 24,
                        children: [
                          // ── Text content ──────────────────────────────
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Text(
                                headline,
                                style: textStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: accent),
                              ),
                              if (supportingText != null)
                                Text(
                                  supportingText!,
                                  style: textStyles.bodySmall.copyWith(color: bodyColor),
                                ),
                            ],
                          ),
                          // ── Action link ───────────────────────────────
                          if (onAction != null)
                            GestureDetector(
                              onTap: onAction,
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 8,
                                children: [
                                  Text(
                                    actionLabel,
                                    style: textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600, color: accent),
                                  ),
                                  GHHeroIcon(GHIcons.arrowRight, size: 18, color: accent),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // ── Dismiss button ─────────────────────────────────────────
              if (onDismiss != null)
                GestureDetector(
                  onTap: onDismiss,
                  behavior: HitTestBehavior.opaque,
                  child: GHHeroIcon(GHIcons.xMark, size: 20, color: accent, semanticLabel: 'Dismiss'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
