/// The size of a `GHAppIconButton`, controlling box, icon and corner-radius
/// dimensions.
///
/// Matches the seven sizes documented in the Finesse UI Kit:
///
/// | Finesse name | Dart value          | Box   | Icon | Smooth radius |
/// |--------------|----------------------|-------|------|---------------|
/// | 2xs          | [extraExtraSmall]    | 32 px | 16px | 8 px          |
/// | xs           | [extraSmall]         | 40 px | 20px | 8 px          |
/// | sm           | [small]              | 48 px | 24px | 12 px         |
/// | md           | [medium]             | 56 px | 28px | 12 px         |
/// | lg           | [large]              | 64 px | 32px | 16 px         |
/// | xl           | [extraLarge]         | 72 px | 36px | 16 px         |
/// | 2xl          | [extraExtraLarge]    | 80 px | 40px | 20 px         |
enum IconButtonSize {
  /// 2xs — 32 logical px square. For the densest icon-only actions.
  extraExtraSmall,

  /// xs — 40 logical px square.
  extraSmall,

  /// sm — 48 logical px square.
  small,

  /// md — 56 logical px square. The default size.
  medium,

  /// lg — 64 logical px square.
  large,

  /// xl — 72 logical px square.
  extraLarge,

  /// 2xl — 80 logical px square. For hero / marketing surfaces.
  extraExtraLarge,
}
