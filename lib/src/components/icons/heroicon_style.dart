/// The visual style of a Heroicon.
///
/// [Heroicons](https://heroicons.com) ships every glyph in three styles, each
/// with a canonical pixel size baked into its artwork:
/// * [outline] — 24×24 with hairline 1.5px strokes; the default UI weight.
/// * [solid] — 24×24 filled shapes, for emphasis or active/selected states.
/// * [mini] — 20×20 filled shapes optimised for small sizes (e.g. inside
///   inputs, badges or dense lists).
///
/// The style maps directly to the asset sub-folder the SVG is loaded from, so
/// it also selects which artwork `GHHeroIcon` renders.
enum HeroIconStyle {
  /// 20×20 filled "mini" glyphs (`assets/icons/heroicons/mini/`).
  mini('mini', 20),

  /// 24×24 hairline outline glyphs (`assets/icons/heroicons/outline/`).
  outline('outline', 24),

  /// 24×24 filled glyphs (`assets/icons/heroicons/solid/`).
  solid('solid', 24);

  const HeroIconStyle(this.folder, this.nominalSize);

  /// The asset sub-folder under `assets/icons/heroicons/` that holds this
  /// style's SVGs.
  final String folder;

  /// The intrinsic artwork size, used as `GHHeroIcon`'s default render size
  /// when no explicit size is given.
  final double nominalSize;
}
