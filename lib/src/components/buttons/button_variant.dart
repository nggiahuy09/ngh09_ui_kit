/// The visual emphasis / type of a `GHAppButton`.
///
/// Maps to the five button types documented in the Finesse UI Kit:
///
/// * Primary → [filled] — Primary CTA (highest emphasis).
/// * Secondary Color → [tonal] — Secondary alongside primary.
/// * Secondary Grey → [secondaryGrey] — Neutral secondary action.
/// * Outline → [outlined] — Lower-emphasis secondary action.
/// * Text Only → [text] — Inline or lowest-emphasis action.
enum ButtonVariant {
  /// Highest emphasis: solid `primary` (black) fill with `onPrimary` (white)
  /// content. Maps to the **Primary** button type in Finesse.
  filled,

  /// Medium emphasis: tonal `primaryContainer` fill with `onPrimaryContainer`
  /// content. Maps to the **Secondary Color** button type in Finesse.
  tonal,

  /// Medium emphasis: `surface` (white) fill, shadow-rendered border, and
  /// `onSurface` content. Maps to the **Secondary Grey** type in Finesse.
  secondaryGrey,

  /// Lower emphasis: transparent fill with an `outline`-colored border and
  /// `primary` content. Maps to the **Outline** button type in Finesse.
  outlined,

  /// Lowest emphasis: no fill or border, `primary` content only. Maps to the
  /// **Text Only** button type in Finesse.
  text,
}

/// The size of a `GHAppButton`, controlling height, padding, icon size, gap
/// and label style.
///
/// Matches the five sizes documented in the Finesse UI Kit:
///
/// | Finesse name | Dart value    | Height | H-pad | V-pad | Icon | Gap |
/// |--------------|---------------|--------|-------|-------|------|-----|
/// | Extra Small  | [extraSmall]  | 40 px  | 18 px | 10 px | 18px | 8px |
/// | Small        | [small]       | 44 px  | 20 px | 12 px | 18px | 8px |
/// | Medium       | [medium]      | 52 px  | 22 px | 14 px | 20px | 10px|
/// | Large        | [large]       | 56 px  | 24 px | 16 px | 20px | 10px|
/// | Extra Large  | [extraLarge]  | 64 px  | 26 px | 18 px | 24px | 12px|
enum ButtonSize {
  /// Extra-small button — 40 logical px tall. For very dense layouts.
  extraSmall,

  /// Small button — 44 logical px tall. For compact layouts and secondary
  /// actions.
  small,

  /// Default button size — 52 logical px tall.
  medium,

  /// Large button — 56 logical px tall. For prominent calls to action.
  large,

  /// Extra-large button — 64 logical px tall. For hero / marketing CTAs.
  extraLarge,
}
