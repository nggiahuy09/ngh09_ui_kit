import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/avatars/gh_avatar_interaction_state.dart';
import 'package:ngh09_ui_kit/src/components/avatars/gh_avatar_size.dart';
import 'package:ngh09_ui_kit/src/components/avatars/gh_avatar_status.dart';
import 'package:ngh09_ui_kit/src/components/avatars/gh_avatar_variant.dart';
import 'package:ngh09_ui_kit/src/tokens/colors.dart';
import 'package:ngh09_ui_kit/src/tokens/shadows.dart';

/// A circular user avatar from the Finesse UI Kit.
///
/// Renders either a hand-drawn portrait illustration (primary constructor) or
/// an initials placeholder ([GHUserAvatar.initials]).
///
/// ```dart
/// // Illustrated portrait
/// const GHUserAvatar(GHAvatarVariant.v03)
/// const GHUserAvatar(GHAvatarVariant.v07, size: GHAvatarSize.xl)
///
/// // Initials
/// const GHUserAvatar.initials('AB')
/// const GHUserAvatar.initials('JD', size: GHAvatarSize.lg)
/// ```
///
/// ### Status badges
///
/// Pass a [GHAvatarStatus] sub-class to overlay an indicator badge:
///
/// ```dart
/// // Online presence dot (bottom-right)
/// GHUserAvatar(GHAvatarVariant.v01, status: const GHAvatarStatusOnline())
///
/// // Verified checkmark (bottom-right)
/// GHUserAvatar.initials(
///   'AB',
///   status: GHAvatarStatusVerified(style: GHVerifiedBadgeStyle.twitterBlue),
/// )
///
/// // Notification count (top-right; counts above 9 → "9+")
/// GHUserAvatar(GHAvatarVariant.v05, status: GHAvatarStatusNumber(count: 3))
/// ```
///
/// ### Interaction states
///
/// [interactionState] controls the shadow ring — useful for widget-catalogue
/// snapshots or tests.
class GHUserAvatar extends StatelessWidget {
  /// Creates an avatar displaying one of the 14 illustrated portraits.
  const GHUserAvatar(
    GHAvatarVariant portraitVariant, {
    this.size = GHAvatarSize.md,
    this.status = const GHAvatarStatusNone(),
    this.interactionState = GHAvatarInteractionState.active,
    this.semanticLabel,
    super.key,
  }) : variant = portraitVariant,
       initials = null;

  /// Creates an avatar displaying up to two initials on a grey background.
  const GHUserAvatar.initials(
    String initialsText, {
    this.size = GHAvatarSize.md,
    this.status = const GHAvatarStatusNone(),
    this.interactionState = GHAvatarInteractionState.active,
    this.semanticLabel,
    super.key,
  }) : variant = null,
       initials = initialsText;

  /// The illustrated portrait to display; `null` when using [initials].
  final GHAvatarVariant? variant;

  /// Up to two characters shown when no [variant] is provided.
  final String? initials;

  /// Controls the outer diameter. Defaults to [GHAvatarSize.md] (40 dp).
  final GHAvatarSize size;

  /// Optional status badge overlaid on the avatar. Defaults to none.
  final GHAvatarStatus status;

  /// Shadow ring state for hover / focus feedback.
  ///
  /// Defaults to [GHAvatarInteractionState.active] (no shadow).
  final GHAvatarInteractionState interactionState;

  /// Accessibility label announced by screen readers.
  ///
  /// Defaults to `"User avatar"` (image variant) or `"Avatar: <initials>"`
  /// (initials variant) when `null`.
  final String? semanticLabel;

  // ── Design tokens

  static const Color _background = Color(0xFFF3F4F6);

  static const List<BoxShadow> _shadowHover = [
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 2), blurRadius: 5),
    BoxShadow(color: Color(0x3D676E76), spreadRadius: 1),
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
  ];

  static const List<BoxShadow> _shadowFocused = [
    BoxShadow(color: Color(0x29676E76), spreadRadius: 4),
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 2), blurRadius: 5),
    BoxShadow(color: Color(0x29676E76), spreadRadius: 1),
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
  ];

  List<BoxShadow> get _stateShadow => switch (interactionState) {
    GHAvatarInteractionState.active => const [],
    GHAvatarInteractionState.hover => _shadowHover,
    GHAvatarInteractionState.focused => _shadowFocused,
  };

  // ── Build

  @override
  Widget build(BuildContext context) {
    final dim = size.dimension;
    final label = semanticLabel ?? (variant != null ? 'User avatar' : 'Avatar: ${initials ?? ''}');

    return Semantics(
      label: label,
      image: true,
      child: SizedBox.square(
        dimension: dim,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox.square(
              dimension: dim,
              child: DecoratedBox(
                decoration: BoxDecoration(color: _background, shape: BoxShape.circle, boxShadow: _stateShadow),
                child: ClipOval(
                  child: variant != null
                      ? Image.asset(
                          variant!.assetPath,
                          width: dim,
                          height: dim,
                          fit: BoxFit.cover,
                          excludeFromSemantics: true,
                        )
                      : Center(
                          child: Text(
                            _truncatedInitials,
                            style: TextStyle(
                              color: ColorTokens.gray900,
                              fontSize: size.initialsFontSize,
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            semanticsLabel: '',
                          ),
                        ),
                ),
              ),
            ),
            _buildStatusIndicator(),
          ],
        ),
      ),
    );
  }

  String get _truncatedInitials {
    final text = initials ?? '';
    if (text.length > 2) return text.substring(0, 2).toUpperCase();
    return text.toUpperCase();
  }

  Widget _buildStatusIndicator() => switch (status) {
    GHAvatarStatusNone() => const SizedBox.shrink(),
    GHAvatarStatusOnline(:final isOnline) => Positioned(
      right: 0,
      bottom: 0,
      child: _OnlineDot(diameter: size.onlineDotDiameter, isOnline: isOnline),
    ),
    GHAvatarStatusVerified(:final style) => Positioned(
      right: 0,
      bottom: 0,
      child: _VerifiedBadge(diameter: size.badgeDiameter, style: style),
    ),
    GHAvatarStatusNumber(:final count) => Positioned(
      right: -1,
      top: -1,
      child: _NumberBadge(diameter: size.badgeDiameter, count: count),
    ),
  };
}

// ── Private indicator sub-widgets ────────────────────────────────────────────
//
// Each indicator renders an outer white ring (matching the indicator slot
// diameter) with an inner coloured circle. This mirrors the Finesse SVG
// composition where the white separation ring is baked into the asset frame.

class _OnlineDot extends StatelessWidget {
  const _OnlineDot({required this.diameter, required this.isOnline});

  final double diameter;
  final bool isOnline;

  static const Color _online = Color(0xFF53B483); // Success/600
  static const Color _offline = ColorTokens.gray200;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: const BoxDecoration(color: ColorTokens.white, shape: BoxShape.circle, boxShadow: ShadowTokens.small),
      child: Center(
        child: Container(
          width: diameter - 3,
          height: diameter - 3,
          decoration: BoxDecoration(color: isOnline ? _online : _offline, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge({required this.diameter, required this.style});

  final double diameter;
  final GHVerifiedBadgeStyle style;

  static const Color _twitterBlue = Color(0xFF1D9BF0);
  static const Color _defaultGreen = Color(0xFF53B483); // Success/600

  Color get _color => style == GHVerifiedBadgeStyle.twitterBlue ? _twitterBlue : _defaultGreen;

  @override
  Widget build(BuildContext context) {
    final inner = diameter - 3;
    return Container(
      width: diameter,
      height: diameter,
      decoration: const BoxDecoration(
        color: ColorTokens.white,
        shape: BoxShape.circle,
        boxShadow: ShadowTokens.small,
      ),
      child: Center(
        child: Container(
          width: inner,
          height: inner,
          decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
          child: Center(
            child: Icon(Icons.check_rounded, color: ColorTokens.white, size: inner * 0.7),
          ),
        ),
      ),
    );
  }
}

class _NumberBadge extends StatelessWidget {
  const _NumberBadge({required this.diameter, required this.count});

  final double diameter;
  final int count;

  @override
  Widget build(BuildContext context) {
    final inner = diameter - 3;
    return Container(
      width: diameter,
      height: diameter,
      decoration: const BoxDecoration(
        color: ColorTokens.white,
        shape: BoxShape.circle,
        boxShadow: ShadowTokens.small,
      ),
      child: Center(
        child: Container(
          width: inner,
          height: inner,
          decoration: const BoxDecoration(color: ColorTokens.black, shape: BoxShape.circle),
          child: Center(
            child: Text(
              count > 9 ? '9+' : count.toString(),
              style: TextStyle(
                color: ColorTokens.white,
                fontSize: inner * 0.5,
                fontWeight: FontWeight.w700,
                height: 1,
                leadingDistribution: TextLeadingDistribution.even,
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ),
    );
  }
}
