import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngh09_ui_kit/src/components/icons/gh_icon_data.dart';
import 'package:ngh09_ui_kit/src/components/icons/heroicon_style.dart';

/// Renders a [Heroicon](https://heroicons.com) as a square, tintable SVG.
///
/// Pick the glyph from the `GHIcons` catalog and the weight via [style]:
///
/// ```dart
/// GHHeroIcon(GHIcons.bell);                                  // 24px outline
/// GHHeroIcon(GHIcons.bell, style: HeroIconStyle.solid);      // 24px filled
/// GHHeroIcon(GHIcons.bell, style: HeroIconStyle.mini);       // 20px filled
/// GHHeroIcon(GHIcons.trash, color: context.colors.danger, size: 18);
/// ```
///
/// **Size.** Defaults to the style's intrinsic size
/// ([HeroIconStyle.nominalSize] — 24 for outline/solid, 20 for mini) so the
/// icon matches the Finesse design pixel-for-pixel. Pass [size] to override;
/// the icon always stays square.
///
/// **Color.** Heroicons paint with `currentColor`, so the whole glyph is tinted
/// uniformly. The color resolves to [color] when given, otherwise the ambient
/// [IconTheme] color, falling back to the theme's `onSurface`. This means a
/// `GHHeroIcon` placed inside a button, list tile or `IconTheme` inherits the
/// surrounding content color just like a Material [Icon].
class GHHeroIcon extends StatelessWidget {
  /// Creates a Heroicon for [icon] in the given [style].
  const GHHeroIcon(
    this.icon, {
    this.style = HeroIconStyle.outline,
    this.size,
    this.color,
    this.semanticLabel,
    super.key,
  });

  /// The glyph to render. Use a constant from `GHIcons`.
  final GHIconData icon;

  /// The visual weight of the glyph. Defaults to [HeroIconStyle.outline].
  final HeroIconStyle style;

  /// The width and height of the (square) icon, in logical pixels.
  ///
  /// Defaults to [HeroIconStyle.nominalSize] for [style].
  final double? size;

  /// The color to paint the glyph.
  ///
  /// Defaults to the ambient [IconTheme] color, then the theme's `onSurface`.
  final Color? color;

  /// An accessibility label announced for the icon. When `null`, the icon is
  /// treated as decorative and excluded from the semantics tree.
  final String? semanticLabel;

  /// The package that bundles the Heroicons SVG assets.
  static const String _package = 'ngh09_ui_kit';

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final resolvedSize = size ?? style.nominalSize;
    final resolvedColor =
        color ?? iconTheme.color ?? Theme.of(context).colorScheme.onSurface;

    return SvgPicture.asset(
      'assets/icons/heroicons/${style.folder}/${icon.name}.svg',
      package: _package,
      width: resolvedSize,
      height: resolvedSize,
      colorFilter: ColorFilter.mode(resolvedColor, BlendMode.srcIn),
      semanticsLabel: semanticLabel,
    );
  }
}
