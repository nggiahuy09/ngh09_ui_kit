# Color System — Design Spec

> Source of truth for the **Finesse UI Kit** color palette.
> Values read directly from the Figma design nodes (hex captured per swatch).
>
> **Status: implemented** (2026-06-22) — see §5 for the code mapping.

## Source

| Field | Value |
|---|---|
| File | ❖ Finesse UI – Figma UI Kit and Design System (FREE) (Community) |
| File key | `F0swFRt1RZPBzTtnbx9DIO` |
| Selected node | `882:35744` — `Body` of the Colors page |
| Captured | 2026-06-22 |

The page presents five groups: **Primary**, **Gray**, **Error**, **Warning**, **Success**. Each colored ramp runs **50 → 1000** (11 steps). The free kit has **no Info/blue ramp** and **no colored brand ramp**.

---

## 1. Primary

> "Primary color is your main 'brand' color … Here, we deliberately chose black and white only so you can customize the palette according to your brand colors swiftly."

| Name | Hex |
|---|---|
| White | `#FFFFFF` |
| Black | `#000000` |

Black is the brand/primary; white is its on-color (and vice-versa in dark mode).

---

## 2. Gray — neutral foundation

> "Gray is a neutral color and is the foundation of the color system. Almost everything in UI design — text, form fields, backgrounds, dividers — are usually gray."

| Step | Hex |
|---|---|
| 50   | `#FAFAFA` |
| 100  | `#F6F7F9` |
| 200  | `#E5E7EA` |
| 300  | `#CED2D6` |
| 400  | `#9EA5AD` |
| 500  | `#676E76` |
| 600  | `#596066` |
| 700  | `#454C52` |
| 800  | `#383F45` |
| 900  | `#24292E` |
| 1000 | `#1A1D1F` |

> Note: this resolves the earlier "two grays" flag — Finesse `Grey/500` (`#676E76`) is **Gray/500** here. The `#667085` seen on the Typography page is a *different* style token (`Gray/500` in that style set); the canonical neutral ramp is the one above.

---

## 3. Error — red (destructive / negative)

> "Error colors are used across error states and in 'destructive' actions…"

| Step | Hex |
|---|---|
| 50   | `#FAFAFA` ⚠️ |
| 100  | `#FEF2F2` |
| 200  | `#FDE9E9` |
| 300  | `#FAC7C7` |
| 400  | `#F7A1A1` |
| 500  | `#F37373` |
| 600  | `#F34141` |
| 700  | `#CD3636` |
| 800  | `#A32E2E` |
| 900  | `#7C2323` |
| 1000 | `#601B1B` |

> ⚠️ **Anomaly:** Error/50 is `#FAFAFA` (a neutral gray, identical to Gray/50) rather than a pale red. This looks like a slip in the free kit — Error/100 (`#FEF2F2`) is the first actual red tint. Captured verbatim for fidelity; revisit if it should be a light red (e.g. `~#FEF5F5`).

---

## 4. Warning — amber

> "Warning colors can communicate that an action is potentially destructive or 'on-hold'…"

| Step | Hex |
|---|---|
| 50   | `#FFFCF5` |
| 100  | `#FEFAF5` |
| 200  | `#FBF2CB` |
| 300  | `#FDE57E` |
| 400  | `#FFD16A` |
| 500  | `#FBBC55` |
| 600  | `#E9A23B` |
| 700  | `#C8811A` |
| 800  | `#A35C00` |
| 900  | `#8B4400` |
| 1000 | `#78310B` |

---

## 5. Success — green

> "Success colors communicate a positive action, positive trend, or a successful confirmation…"

| Step | Hex |
|---|---|
| 50   | `#F6FEF9` |
| 100  | `#EFFDF6` |
| 200  | `#D9F9E6` |
| 300  | `#B8F1D2` |
| 400  | `#8EE4BA` |
| 500  | `#6AD09D` |
| 600  | `#53B483` |
| 700  | `#2F9461` |
| 800  | `#2F7657` |
| 900  | `#255E46` |
| 1000 | `#1E4D3A` |

---

## 6. Implementation in this project (Flutter) — what shipped

Decisions taken (2026-06-22):

- **Primary = Black/White** — dropped the indigo brand ramp; primary is black (light) / white (dark).
- **Full 11-step ramps** — Gray, Error, Warning, Success each carry 50→1000.
- **Info kept as legacy** — the prior blue `info` role/ramp is retained as a **non-Finesse extension** so nothing breaks during migration; flagged in code.
- **Token names → Finesse** — primitives renamed `neutral → gray`, `danger → error` (semantic `GHAppColors` role names like `danger`/`success` are unchanged).

Files touched:

- `lib/src/tokens/colors.dart` → `ColorTokens`: base + `gray{50..1000}`, `error/warning/success{50..1000}`, legacy `info{50,500,700}`. Removed `brand*`, `neutral*`, `danger*`.
- `lib/src/theme/app_colors.dart` → `GHAppColors.light()/.dark()` remapped (see below).
- `test/tokens/app_theme_test.dart` → token references updated to the gray ramp.

### Semantic role mapping (as implemented)

| Role | Light | Dark |
|---|---|---|
| primary | Black `#000000` | White `#FFFFFF` |
| onPrimary | White | Black |
| primaryContainer | gray100 `#F6F7F9` | gray800 `#383F45` |
| onPrimaryContainer | gray900 `#24292E` | gray50 `#FAFAFA` |
| background | gray50 `#FAFAFA` | gray1000 `#1A1D1F` |
| onBackground | gray900 | gray50 |
| surface | White `#FFFFFF` | gray900 `#24292E` |
| onSurface | gray900 | gray50 |
| surfaceVariant | gray100 | gray800 |
| onSurfaceVariant | gray600 `#596066` | gray300 `#CED2D6` |
| outline | gray300 `#CED2D6` | gray600 `#596066` |
| outlineVariant | gray200 `#E5E7EA` | gray700 `#454C52` |
| success | success500 `#6AD09D` | success500 |
| onSuccess | success900 `#255E46` | success900 |
| warning | warning500 `#FBBC55` | warning500 |
| onWarning | warning900 `#8B4400` | warning900 |
| danger | error500 `#F37373` | error500 |
| onDanger | error900 `#7C2323` | error900 |
| info *(legacy)* | info500 `#2196C3` | info500 |
| onInfo *(legacy)* | White | White |

Status roles use each ramp's **500** as the base (saturated enough to read as a dot, per the Finesse "500 = base" convention) with the **900** of the same ramp as the on-color — a soft-badge style (light tinted fill + dark same-hue text). Status colors are mode-independent, matching the prior design.

---

## 7. Resolved decisions & remaining notes

1. **No Info in Finesse** — `info` is retained only for back-compat (`GHAppBadge`/`BadgeStatus.info` still resolve). Treat as deprecated; remove once consumers migrate.
2. **Error/50 anomaly** — see §3 ⚠️. Captured as `#FAFAFA`; confirm with design whether it should be a light red.
3. **Contrast** — `onDanger` (error900 on error500) is ~3.6:1, acceptable for badge labels but below 4.5:1; revisit if used for small body text. success/warning on-colors clear ~4.5:1.
4. **Knock-on effects** — changing primary to black and the status hues will shift `AppButton`/`AppBadge`/`AppChip` golden images. Components were left untouched (colors-only scope); regenerate goldens in a follow-up.
5. **Next foundations** — spacing, radii, elevation still use prior (non-Finesse) values; capture those Finesse pages later.
