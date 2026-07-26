# Shadow System — Design Spec

> Source of truth for the **Finesse UI Kit** shadow (elevation) system.
> Values read directly from the Figma effect styles.
>
> **Status: implemented** (2026-06-22) — see §5 for the code mapping.

## Source

| Field | Value |
|---|---|
| File | ❖ Finesse UI – Figma UI Kit and Design System (FREE) (Community) |
| File key | `F0swFRt1RZPBzTtnbx9DIO` |
| Selected node | `899:42789` — `Body` of the Shadow page |
| Captured | 2026-06-22 |

Three groups, each a stack of `DROP_SHADOW` effects:

1. **Normal Styles** — Small / Medium / Large. "Regular usage for components like buttons, cards, images and dropdowns."
2. **Hover Styles** — Primary / Secondary / Error / Warning / Success. "Hover effects when the cursor is inside the component."
3. **Focused Styles** — Primary / Secondary / Error / Warning / Success. "Focused effects for drawing user attention / nested activity."

Figma effect notation below: `color #RRGGBBAA · offset (x,y) · blur=radius · spread`. Listed in Figma layer order. The Flutter equivalent is `BoxShadow(color, offset, blurRadius, spreadRadius)`.

The tint colors reuse the Finesse palette (see `figma/colors.md`): `#676E76` = Gray/500, `#F34141` = Error/600, `#E9A23B` = Warning/600, `#53B483` = Success/600, plus pure black.

---

## 1. Normal Styles

### Small
| color | offset | blur | spread |
|---|---|---|---|
| `#676E76` @8% | (0, 2) | 5 | 0 |
| `#000000` @12% | (0, 1) | 1 | 0 |

### Medium
| color | offset | blur | spread |
|---|---|---|---|
| `#000000` @12% | (0, 1) | 1 | 0 |
| `#676E76` @16% | (0, 0) | 0 | 1 |
| `#676E76` @8% | (0, 2) | 5 | 0 |

### Large
| color | offset | blur | spread |
|---|---|---|---|
| `#676E76` @8% | (0, 15) | 35 | 0 |
| `#000000` @12% | (0, 5) | 15 | 0 |

---

## 2. Hover Styles

Each = a 1px base shadow + a tinted ring (`blur 0`, `spread 1–2`) + a soft tinted shadow.

| Variant | Ring color | Ring spread | Soft shadow |
|---|---|---|---|
| Primary   | `#000000` @64% | 1 | `#676E76` @8% (0,2) b5 |
| Secondary | `#676E76` @24% | 1 | `#676E76` @8% (0,2) b5 |
| Error     | `#F34141` @40% | 2 | `#F34141` @8% (0,2) b5 |
| Warning   | `#E9A23B` @40% | 2 | `#E9A23B` @8% (0,2) b5 |
| Success   | `#53B483` @40% | 2 | `#53B483` @8% (0,2) b5 |

All share a leading `#000000` @12% · (0,1) · b1 · s0 base.

Full stacks (layer order):

- **Primary**: `#000000@12% (0,1) b1 s0` · `#000000@64% (0,0) b0 s1` · `#676E76@8% (0,2) b5 s0`
- **Secondary**: `#000000@12% (0,1) b1 s0` · `#676E76@24% (0,0) b0 s1` · `#676E76@8% (0,2) b5 s0`
- **Error**: `#000000@12% (0,1) b1 s0` · `#F34141@40% (0,0) b0 s2` · `#F34141@8% (0,2) b5 s0`
- **Warning**: `#000000@12% (0,1) b1 s0` · `#E9A23B@40% (0,0) b0 s2` · `#E9A23B@8% (0,2) b5 s0`
- **Success**: `#000000@12% (0,1) b1 s0` · `#53B483@40% (0,0) b0 s2` · `#53B483@8% (0,2) b5 s0`

---

## 3. Focused Styles

Like Hover but with an extra **outer halo** (`blur 0`, `spread 4`) at low opacity — the focus ring. Layer order:

- **Primary**: `#000000@12% (0,1) b1 s0` · `#000000@64% (0,0) b0 s1` · `#676E76@8% (0,2) b5 s0` · `#676E76@16% (0,0) b0 s4`
- **Secondary**: `#000000@12% (0,1) b1 s0` · `#676E76@16% (0,0) b0 s1` · `#676E76@8% (0,2) b5 s0` · `#676E76@16% (0,0) b0 s4`
- **Error**: `#000000@12% (0,1) b1 s0` · `#F34141@16% (0,0) b0 s1` · `#676E76@8% (0,2) b5 s0` · `#F34141@16% (0,0) b0 s4`
- **Warning**: `#000000@12% (0,1) b1 s0` · `#E9A23B@16% (0,0) b0 s1` · `#676E76@8% (0,2) b5 s0` · `#E9A23B@16% (0,0) b0 s4`
- **Success**: `#000000@12% (0,1) b1 s0` · `#53B483@16% (0,0) b0 s1` · `#676E76@8% (0,2) b5 s0` · `#53B483@16% (0,0) b0 s4`

> Opacity → 8-bit alpha reference: 8% = `0x14`, 12% = `0x1F`, 16% = `0x29`, 24% = `0x3D`, 40% = `0x66`, 64% = `0xA3`. Flutter `Color` is `0xAARRGGBB`, so e.g. `#676E76` @8% → `Color(0x14676E76)`.

---

## 4. Container (swatch) reference

The demo swatches are `200×164.4` white rounded rectangles, `borderRadius 8`. The radius is incidental to the swatch, not part of the shadow token.

---

## 5. Implementation in this project (Flutter) — what shipped

Decision: **token + semantic layer** (consistent with colors/typography/spacing/radii). The unused Material `ElevationTokens` (dp levels) was **removed** — Finesse has no dp elevation concept.

Files touched:

- `lib/src/tokens/shadows.dart` (new) → `ShadowTokens`: 13 `const List<BoxShadow>` — `small`, `medium`, `large`, `hover{Primary,Secondary,Error,Warning,Success}`, `focus{Primary,Secondary,Error,Warning,Success}`. Colors are literal `0xAARRGGBB` ARGB matching the design exactly (a comment notes the source palette token).
- `lib/src/tokens/elevation.dart` → **deleted**.
- `lib/src/theme/app_shadows.dart` (new) → `GHAppShadows` `ThemeExtension` with `.standard()`, `copyWith`, `lerp` (via `BoxShadow.lerpList`). No Material projection (shadows aren't a `ThemeData` concept).
- `lib/src/theme/app_theme.dart` → attaches `GHAppShadows.standard()` to both light & dark.
- `lib/src/utils/context_extensions.dart` → `context.shadows` accessor.
- `lib/ngh09_ui_kit.dart` → exports `app_shadows.dart` + `tokens/shadows.dart` (replacing the elevation export).
- `test/tokens/app_theme_test.dart` → asserts the `GHAppShadows` extension is attached.

Usage:

```dart
Container(
  decoration: BoxDecoration(
    color: context.colors.surface,
    borderRadius: context.radii.borderRadiusMd,
    boxShadow: context.shadows.medium,
  ),
);
```

Mapping — Figma `DROP_SHADOW(color, offset, radius, spread)` → `BoxShadow(color, offset, blurRadius, spreadRadius)`. Ring effects (`blur 0`, `spread N`) render as hard rings, the same as Figma.

---

## 6. Notes

1. **Mode-independent** — the design provides one set (on white). `GHAppShadows.standard()` is used for both light and dark; dark-mode tuning (shadows read weakly on dark surfaces) is a future refinement.
2. **Ring fidelity** — Figma `spread`-only ring shadows approximate but don't perfectly equal CSS `box-shadow` spread; Flutter's `spreadRadius` is the closest match and is used directly.
3. **Hover/Focus = interaction states** — `hover*`/`focus*` are intended for components' hovered/focused states (buttons, cards, inputs). Components are not yet wired to them (out of scope here).
