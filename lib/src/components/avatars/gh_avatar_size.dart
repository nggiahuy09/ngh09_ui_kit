/// The 6 canonical sizes for [GHUserAvatar], matching the Finesse UI Kit.
enum GHAvatarSize {
  /// 24 × 24 dp.
  xs,

  /// 32 × 32 dp.
  sm,

  /// 40 × 40 dp (default).
  md,

  /// 48 × 48 dp.
  lg,

  /// 56 × 56 dp.
  xl,

  /// 64 × 64 dp.
  xxl;

  /// Outer diameter of the avatar circle in logical pixels.
  double get dimension => switch (this) {
    xs  => 24,
    sm  => 32,
    md  => 40,
    lg  => 48,
    xl  => 56,
    xxl => 64,
  };

  /// Diameter of the online / offline dot indicator.
  double get onlineDotDiameter => switch (this) {
    xs  => 6,
    sm  => 8,
    md  => 10,
    lg  => 12,
    xl  => 14,
    xxl => 16,
  };

  /// Diameter of the verified-badge or number-count badge.
  double get badgeDiameter => switch (this) {
    xs  => 8,
    sm  => 10,
    md  => 12,
    lg  => 14,
    xl  => 16,
    xxl => 18,
  };

  /// Font size used when rendering initials inside the avatar.
  double get initialsFontSize => switch (this) {
    xs  => 12,
    sm  => 14,
    md  => 16,
    lg  => 18,
    xl  => 20,
    xxl => 24,
  };
}
