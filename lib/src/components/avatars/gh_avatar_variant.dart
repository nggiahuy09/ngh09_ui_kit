/// The 14 illustrated user avatar variants from the Finesse UI Kit.
///
/// Each variant corresponds to a unique hand-drawn portrait asset bundled
/// inside `assets/images/avatars/`.  See [GHUserAvatar] for rendering details.
enum GHAvatarVariant {
  /// Illustrated portrait #01.
  v01,

  /// Illustrated portrait #02.
  v02,

  /// Illustrated portrait #03.
  v03,

  /// Illustrated portrait #04.
  v04,

  /// Illustrated portrait #05.
  v05,

  /// Illustrated portrait #06.
  v06,

  /// Illustrated portrait #07.
  v07,

  /// Illustrated portrait #08.
  v08,

  /// Illustrated portrait #09.
  v09,

  /// Illustrated portrait #10.
  v10,

  /// Illustrated portrait #11.
  v11,

  /// Illustrated portrait #12.
  v12,

  /// Illustrated portrait #13.
  v13,

  /// Illustrated portrait #14.
  v14;

  /// The bundled asset path for this variant.
  String get assetPath {
    final num = index + 1; // enum index is 0-based
    final padded = num.toString().padLeft(2, '0');
    return 'packages/ngh09_ui_kit/assets/images/avatars/avatar_$padded.png';
  }
}
