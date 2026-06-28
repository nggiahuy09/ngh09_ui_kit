import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/avatars/gh_avatar_variant.dart';

/// A circular illustrated user avatar from the Finesse UI Kit.
///
/// Renders one of 14 hand-drawn portrait illustrations ([GHAvatarVariant])
/// clipped to a circle and placed on the Finesse light-grey background
/// (`#F3F4F6`).
///
/// ```dart
/// const GHUserAvatar(GHAvatarVariant.v01)              // 40 px
/// const GHUserAvatar(GHAvatarVariant.v07, size: 64)
/// const GHUserAvatar(GHAvatarVariant.v14, size: 24)
/// ```
///
/// **Size.** The [size] parameter controls both width and height in logical
/// pixels.  Defaults to `40.0`, a comfortable hit-target for interactive use.
///
/// **Package consumers.** The avatar PNGs are bundled under
/// `packages/ngh09_ui_kit/assets/images/avatars/` so they resolve correctly
/// both inside the package and when the package is used as a dependency.
class GHUserAvatar extends StatelessWidget {
  /// Creates a user avatar for the given [variant].
  const GHUserAvatar(this.variant, {this.size = 40.0, this.semanticLabel, super.key});

  /// Which of the 14 illustrated portraits to display.
  final GHAvatarVariant variant;

  /// The diameter of the circular avatar in logical pixels. Defaults to `40.0`.
  final double size;

  /// An accessibility label announced by screen readers.
  ///
  /// Defaults to `"User avatar"` when `null`.
  final String? semanticLabel;

  /// Background colour matching the Finesse avatar canvas.
  static const Color _background = Color(0xFFF3F4F6);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? 'User avatar',
      image: true,
      child: SizedBox.square(
        dimension: size,
        child: DecoratedBox(
          decoration: const BoxDecoration(color: _background, shape: BoxShape.circle),
          child: ClipOval(
            child: Image.asset(
              variant.assetPath,
              width: size,
              height: size,
              fit: BoxFit.cover,
              // The semantic label lives on the parent Semantics node.
              excludeFromSemantics: true,
            ),
          ),
        ),
      ),
    );
  }
}
