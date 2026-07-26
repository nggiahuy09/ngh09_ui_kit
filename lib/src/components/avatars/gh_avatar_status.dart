/// Describes the optional status badge overlaid on a [GHUserAvatar].
///
/// Construct a concrete sub-class to enable a badge:
/// - [GHAvatarStatusNone] — no indicator (default).
/// - [GHAvatarStatusOnline] — presence dot at the bottom-right.
/// - [GHAvatarStatusVerified] — verified checkmark at the bottom-right.
/// - [GHAvatarStatusNumber] — notification count circle at the top-right.
sealed class GHAvatarStatus {
  /// @nodoc
  const GHAvatarStatus();
}

/// No status indicator. This is the default.
final class GHAvatarStatusNone extends GHAvatarStatus {
  /// Creates a no-indicator status.
  const GHAvatarStatusNone();
}

/// An online-presence dot.
///
/// [isOnline] `true` → green dot (`Success/600`);
/// [isOnline] `false` → grey dot (`Grey/200`).
final class GHAvatarStatusOnline extends GHAvatarStatus {
  /// Creates an online-presence indicator.
  const GHAvatarStatusOnline({this.isOnline = true});

  /// Whether to show the green (online) or grey (offline) dot.
  final bool isOnline;
}

/// A verified-account checkmark badge at the bottom-right.
final class GHAvatarStatusVerified extends GHAvatarStatus {
  /// Creates a verified-account badge.
  const GHAvatarStatusVerified({this.style = GHVerifiedBadgeStyle.defaultGreen});

  /// Colour theme of the checkmark badge.
  final GHVerifiedBadgeStyle style;
}

/// A notification-count badge at the top-right.
///
/// Counts above 9 are clamped to "9+".
final class GHAvatarStatusNumber extends GHAvatarStatus {
  /// Creates a notification-count badge with the given [count].
  const GHAvatarStatusNumber({required this.count});

  /// The number to display. Values above 9 render as "9+".
  final int count;
}

/// Colour theme of the [GHAvatarStatusVerified] badge.
enum GHVerifiedBadgeStyle {
  /// Twitter / X-style blue checkmark (`#1D9BF0`).
  twitterBlue,

  /// Finesse default green checkmark (`Success/600 — #53B483`).
  defaultGreen,
}
