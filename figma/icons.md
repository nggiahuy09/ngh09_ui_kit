# Icons — Design Spec

> Source of truth for the **Finesse UI Kit** icon system.
> Values read directly from the Figma design nodes.
>
> **Status: implemented** (2026-06-22). The kit now ships the Heroicons set as
> bundled SVGs behind a typed `GHIcons` catalog and the `GHHeroIcon` widget —
> see §6 for the code mapping and what shipped.

## Source

| Field | Value |
|---|---|
| File | ❖ Finesse UI – Figma UI Kit and Design System (FREE) (Community) |
| File key | `F0swFRt1RZPBzTtnbx9DIO` |
| Header node (design 1) | `900:35648` — `Header` (2460 × 394) |
| Catalog node (design 2) | `290:16933` — `icons` (2460 × 3120) |
| Captured | 2026-06-22 |

The page is a documentation/showcase screen: a `Header` block (intro copy) over
an `icon list` — every glyph rendered side-by-side in three styles with its
name. The kit's set is **293 icons**, drawn from
[Heroicons](https://heroicons.com) (880+ icons, MIT, by the makers of Tailwind
CSS).

---

## 1. Header (design 1 — node `900:35648`)

The doc header that introduces the Icons page.

| Element | Font (Figma style) | Size / Line | Color (Figma) | Hex |
|---|---|---|---|---|
| "Icons" headline | `Headings/lg/Semi Bold` | 48 / 60, −2% | `Grey/900` | `#24292E` |
| Description paragraph | `Body/xl/Regular` | 20 / 30, 0 | `Grey/500` | `#676E76` |
| Page background | — | — | `Grey/50` | `#FAFAFA` |
| Top bar fill | — | — | `Primary/Black` | `#000000` |
| Top bar logo / link | — | 14 / 20 | `Primary/White` | `#FFFFFF` |

Layout: a black rounded (`8`) container (padding `14 / 10`) holding the
**FINESSE** wordmark on the left and the underlined `finesseui.com` link on the
right; then a content column (gap `24`) with the headline over the description.
Outer frame padding `40`, content gap `80`.

Description copy (verbatim):

> Icons are a set of visual representations of actions, objects, or concepts
> that are used to communicate information quickly and efficiently to users.
> Icons can be used to improve the usability and accessibility of an interface,
> by providing a visual shorthand for common tasks and functions.
>
> Our design system makes use of Heroicons which is a collection of 880+
> polished and beautiful hand-crafted SVG icons, by the makers of Tailwind CSS.

---

## 2. Icon styles (the actual deliverable)

Every icon is published in **three styles**. Each style has a canonical artwork
size baked in, and a distinct render technique:

| Style (Figma symbol) | Size | Technique | Heroicons source dir |
|---|---|---|---|
| `heroicons-mini/<name>` | 20 × 20 | filled (`fill="currentColor"`) | `optimized/20/solid` |
| `heroicons-outline/<name>` | 24 × 24 | stroked, 1.5px (`stroke="currentColor"`) | `optimized/24/outline` |
| `heroicons-solid/<name>` | 24 × 24 | filled (`fill="currentColor"`) | `optimized/24/solid` |

> All three paint with `currentColor`, so a single tint recolors the whole
> glyph regardless of fill-vs-stroke — see §6 (`ColorFilter`).

> Heroicons' **mini** style maps to Heroicons' `20/solid` artwork (the design's
> "mini" label = the 20px size, not a separate drawing).

---

## 3. Catalog layout (design 2 — node `290:16933`)

The `icons` frame (2460 wide) lays the set out in columns; each column is an
`icon list` (444 wide). One **row** per icon (height `24`, vertical pitch `52`):

```
icon row (444 × 24)
├─ icons (116 × 24)
│  ├─ heroicons-mini/<name>     (20 × 20, x 0,  y 4)
│  ├─ heroicons-outline/<name>  (24 × 24, x 44, y 0)
│  └─ heroicons-solid/<name>    (24 × 24, x 92, y 0)
└─ text "<name>"                (288 × 24, x 156)
```

The label is the Heroicons file name in kebab-case (e.g. `arrow-down-circle`).

---

## 4. The set (293 icons)

All 293 names are listed in alphabetical order in the generated catalog
(`GHIcons.values`). They cover the standard Heroicons v2 families: `arrow-*`,
`chevron-*`, `arrows-*`, `chat-bubble-*`, `device-*`, `currency-*`, the
`*-circle` / `*-slash` modifiers, numerics (`battery-0/50/100`, `cog-6-tooth`,
`cog-8-tooth`, `squares-2x2`), and so on.

### 4.1 Name reconciliation (Figma → Heroicons v2)

Three labels in the Figma file are stale or mistyped relative to current
Heroicons; captured under their **correct** Heroicons names so the assets
resolve:

| Figma label | Shipped name | Reason |
|---|---|---|
| `exclaimation-circle` | `exclamation-circle` | typo in the design |
| `viewfinder-dot` | `viewfinder-circle` | renamed in Heroicons v2 |
| `slash-separator` | `slash` | renamed in Heroicons v2 |

---

## 5. License

Heroicons is **MIT licensed**, © Tailwind Labs. The SVGs are vendored verbatim
from `tailwindlabs/heroicons` (`optimized/` output). Attribution retained in
`pubspec.yaml` and the `GHIcons` doc comment.

---

## 6. Implementation in this project (Flutter) — what shipped

Decisions taken (2026-06-22):

- **SVG, not an icon font** — Heroicons' `outline` style is stroke-based and
  cannot be reproduced faithfully in a monochrome glyph font; SVG rendering
  preserves all three styles exactly. Accepts one runtime dependency
  (`flutter_svg`), the only break from the "minimal deps" rule, made explicitly
  for fidelity.
- **Full set bundled** — all 293 icons × 3 styles (879 SVGs, ~3.4 MB) shipped as
  package assets so consumers need no network or extra package.
- **Typed catalog** — every icon is a `GHIconData` constant on `GHIcons`
  (kebab-case → camelCase), plus a `GHIcons.values` list for pickers/grids.

Files touched:

- `assets/icons/heroicons/{mini,outline,solid}/<name>.svg` — 293 names per
  style, sourced from Heroicons `optimized/{20/solid, 24/outline, 24/solid}`.
- `lib/src/components/icons/heroicon_style.dart` → `HeroIconStyle` enum
  (`mini` / `outline` / `solid`), each carrying its asset `folder` and
  `nominalSize` (20 / 24 / 24).
- `lib/src/components/icons/gh_icon_data.dart` → `GHIconData` — immutable
  descriptor wrapping the Heroicons `name`.
- `lib/src/components/icons/gh_hero_icon.dart` → `GHHeroIcon` — the widget.
  Renders `assets/icons/heroicons/<style.folder>/<name>.svg` via
  `SvgPicture.asset` (`package: 'ngh09_ui_kit'`), square, tinted with
  `ColorFilter.mode(color, BlendMode.srcIn)`.
- `lib/src/components/icons/gh_icons.dart` → `GHIcons` — **generated** catalog
  of 293 `GHIconData` constants + `values`. Regenerated from the bundled SVGs;
  do not hand-edit.
- `lib/ngh09_ui_kit.dart` — exports the four icon files.
- `pubspec.yaml` — added `flutter_svg: ^2.0.10`; registered the three asset
  dirs.
- `widgetbook/lib/use_cases/heroicon_use_cases.dart` + `widgetbook/lib/main.dart`
  — a **Components ▸ Icons** catalog page reproducing the design (doc header +
  searchable 3-style grid), plus Playground and "Styles & sizes" use cases.

### API

```dart
GHHeroIcon(GHIcons.bell);                              // 24px outline (default)
GHHeroIcon(GHIcons.bell, style: HeroIconStyle.solid);  // 24px filled
GHHeroIcon(GHIcons.bell, style: HeroIconStyle.mini);   // 20px filled
GHHeroIcon(GHIcons.trash, color: context.colors.danger, size: 18);
```

### Resolution rules (as implemented)

| Prop | Default |
|---|---|
| `style` | `HeroIconStyle.outline` |
| `size` | `style.nominalSize` (20 for mini, 24 for outline/solid) |
| `color` | `color` → ambient `IconTheme.color` → `Theme.colorScheme.onSurface` |

So a `GHHeroIcon` placed inside a button, list tile or `IconTheme` inherits the
surrounding content color like a Material `Icon`, while still defaulting to the
Figma artwork size for pixel-accurate rendering.

### Header → kit mapping (design 1 reproduction)

| Element | Figma | Kit role |
|---|---|---|
| "Icons" headline | `Headings/lg/Semi Bold` 48 | `headlineMedium` (48) |
| Description | `Body/xl/Regular` 20 | `bodyLarge` (18) ⚠️ |
| Headline color | `Grey/900 #24292E` | `colors.onBackground` |
| Description color | `Grey/500 #676E76` | `colors.onSurfaceVariant` |
| Page background | `Grey/50 #FAFAFA` | `colors.background` |
| Top bar | `Primary/Black/White` | `ColorTokens.black/white` |

---

## 7. Resolved decisions & remaining notes

1. **`flutter_svg` dependency** — accepted as the cost of faithful outline
   rendering (see §6). If the kit later drops outline support, a generated icon
   font for `solid`/`mini` would remove the dependency.
2. **Body/xl gap** — the description is `Body/xl/Regular` (20px) in Figma, but
   the kit's largest regular body role (`bodyLarge`) is 18px; the catalog header
   uses 18px. No 20px regular role exists in the type scale (20px is
   `titleSmall`, Medium). Revisit only if a 20px regular role is added.
3. **FINESSE logo** — the Figma top-bar logo is a raster image; the Widgetbook
   header renders a styled `❖ FINESSE` wordmark instead (no logo asset bundled).
   Swap in the real asset if exact reproduction is required.
4. **Set size** — 293 of Heroicons' 880+ icons (the subset present in this free
   Figma file). To extend to the full set, drop the new SVGs into the three
   asset dirs and regenerate `gh_icons.dart`.
5. **Micro (16px)** — Heroicons v2 also ships a 16px `micro` style; it is not in
   this Figma file and was not bundled. Add a `HeroIconStyle.micro` +
   `optimized/16/solid` assets if needed later.
