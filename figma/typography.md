# Typography — Design Spec

> Source of truth for the **Finesse UI Kit** typography system.
> Values read directly from the Figma design nodes.
>
> **Status: implemented** (2026-06-22). The Finesse scale now backs the kit's
> typography layer — see §6 for the code mapping and what shipped.

## Source

| Field | Value |
|---|---|
| File | ❖ Finesse UI – Figma UI Kit and Design System (FREE) (Community) |
| File key | `F0swFRt1RZPBzTtnbx9DIO` |
| Selected node | `52:4` — page “↳ Typography” |
| Root frame | `875:36478` — `Typography` (1229 × 3326) |
| Captured | 2026-06-22 |

The page is a documentation/showcase screen: a `Header` instance, a `Body` containing the font intro + three type-scale sections (Titles, Headings, Body), and a `Footer` instance.

---

## 1. Font family

- **Inter** (open-source, by Rasmus Andersson, 2017). Single family for the whole kit.
- Weights used: **Regular (400)**, **Medium (500)**, **Semi Bold (600)**.
- Intro paragraph copy (node `881:35632`) describes Inter's large x-height, open apertures and 140+ language support.

In Figma the family style strings are `Inter:Regular`, `Inter:Medium`, `Inter:Semi Bold` (note the space — `Semi Bold`, not `SemiBold`).

---

## 2. Color tokens referenced on this page

| Token (Figma) | Hex | Usage on page |
|---|---|---|
| `Gray/900` | `#101828` | Font name heading, section headings |
| `Gray/500` | `#667085` | Intro paragraph body text |
| `Grey/500` | `#676E76` | Section description text (note: distinct token, different spelling/value from `Gray/500`) |
| `Primary/Black` | `#000000` | Sample-style labels + info text |

> ⚠️ The file contains two near-duplicate “500 gray” tokens (`Gray/500 #667085` and `Grey/500 #676E76`). Flag for de-duplication when porting to the project color tokens.

---

## 3. Type scale (the actual deliverable)

All sizes in logical px. **Line Spacing** = absolute line-height in px (Figma `lineHeight` in px). The **ratio** column is `lineHeight ÷ fontSize` — use this as Flutter's `TextStyle.height` multiplier. **Letter Spacing** given as the design `%`, the em equivalent, and the resolved logical-px value (`size × %`), which is what Flutter's `letterSpacing` expects.

### 3.1 Titles — `Headings/*` family, large display sizes

For main screen titles. Should not appear more than once per screen; use only to draw maximum attention.

| Name | Size | Line (px) | Line ratio | Letter % | Letter (em) | Letter (px) | Weight |
|---|---|---|---|---|---|---|---|
| Large | 120 | 150 | 1.250 | −2% | −0.02 | −2.40 | — |
| Small | 96  | 120 | 1.250 | −2% | −0.02 | −1.92 | — |

### 3.2 Headings

For section headers and sub-headings; can be used multiple times on a single page.

| Name | Size | Line (px) | Line ratio | Letter % | Letter (em) | Letter (px) | Weight |
|---|---|---|---|---|---|---|---|
| Huge        | 72 | 90 | 1.250 | −2% | −0.02 | −1.44 | — |
| Extra Large | 60 | 72 | 1.200 | −2% | −0.02 | −1.20 | — |
| Large       | 48 | 60 | 1.250 | −2% | −0.02 | −0.96 | — |
| Medium      | 36 | 44 | 1.222 | −2% | −0.02 | −0.72 | — |
| Small       | 30 | 38 | 1.267 |  0% |  0.00 |  0.00 | — |
| Extra Small | 24 | 32 | 1.333 |  0% |  0.00 |  0.00 | — |

### 3.3 Body

For paragraphs, descriptions and other blocks of text that make up the bulk of an interface or content area.

| Name | Size | Line (px) | Line ratio | Letter % | Letter (em) | Letter (px) | Weight |
|---|---|---|---|---|---|---|---|
| Extra Large | 20 | 30 | 1.500 | 0% | 0.00 | 0.00 | — |
| Large       | 18 | 28 | 1.556 | 0% | 0.00 | 0.00 | — |
| Medium      | 16 | 24 | 1.500 | 0% | 0.00 | 0.00 | — |
| Small       | 14 | 20 | 1.429 | 0% | 0.00 | 0.00 | — |
| Extra Small | 12 | 18 | 1.500 | 0% | 0.00 | 0.00 | — |
| Tiny        | 10 | 16 | 1.600 | 0% | 0.00 | 0.00 | — |

> The scale labels (Large/Small/Huge/Medium/Tiny…) are the kit's own names. Weight is **not annotated per scale step** in the design — the page documents size / line / letter only. Confirm the intended weight per role before implementation (the labels in the design are rendered Medium 500, but that is the *demo label* style, see §4, not necessarily the scale step's production weight).

---

## 4. Auxiliary / page-chrome styles (for reproducing the showcase, not part of the scale)

| Element | Node | Font | Size | Line | Letter | Color |
|---|---|---|---|---|---|---|
| Font-name heading (“Inter”) | `881:35631` | Inter Semi Bold (600) | 48 | 60 | −2% (−0.96px) | `#101828` |
| Intro paragraph | `881:35632` | Inter Regular (400) | 18 | 28 | 0 | `#667085` |
| Section heading (“Titles”/“Headings”/“Body”) | e.g. `881:35638` | Inter Semi Bold (600) | 36 | 44 | −2% (−0.72px) | `#101828` |
| Section description | e.g. `881:35745` | Inter Regular (400) | 16 | 24 | 0 | `#676E76` |
| Sample-style label (“Large”, “Small”…) | e.g. `881:35666` | Inter Medium (500) | 30 | 38 | 0 | `#000000` |
| Sample info line (“Font Size: …”) | e.g. `881:35669` | Inter Regular (400) | 18 | 28 | 0 | `#000000` |

Named Figma text styles encountered: `Headings/lg/Semi Bold` (48/60/−2), `Headings/md/Semi Bold` (36/44/−2), `Headings/sm/Medium` (30/38/0), `Body/lg/Regular` (18/28/0), `Body/md/Regular` (16/24/0), `Text lg/Normal` (18/28/0).

---

## 5. Showcase layout (for rebuilding the demo page)

```
Typography (frame, 1229 wide)
├─ Header (instance)
├─ Body (padding-x: 40)
│  ├─ Divider (1px hairline)
│  ├─ Font            → "Inter" heading + intro paragraph (gap 24)
│  ├─ Titles section  → Section(heading+desc) + 1 row of 2 Text-Style cards
│  ├─ Headings section→ Section + 3 rows × 2 Text-Style cards
│  └─ Body section    → Section + 3 rows × 2 Text-Style cards
└─ Footer (instance)
```

- **Text-Style card** (`Text Style`, `881:35663…`): horizontal, two `content-layer` columns, gap 24, padding `16 / 8`. Each column = a `text-layer` (the style label) stacked over an `info-layer` (3 lines: Font Size / Line Spacing / Letter Spacing), gap 24 between label and info, ~5px between info lines.
- Section block = heading + description stacked, gap 24.

---

## 6. Implementation in this project (Flutter) — what shipped

Decisions taken (2026-06-22):

- **Keep Material role names**, reskin their values to the Finesse scale (no parallel Finesse-named API).
- **Keep the Material substrate** — `GHAppTheme` still builds `ThemeData` and projects the scale onto `TextTheme`/`ColorScheme`.
- **Bundle Inter** as a local asset (no runtime font dependency).

Files touched:

- `lib/src/tokens/typography.dart` → `TypographyTokens`: `fontFamily = 'Inter'`, weight constants retained, `size{Role}` reskinned to Finesse, plus new per-role `lineHeight{Role}` (absolute px) and `letterSpacing{Role}` (px) constants. The 3 shared height multipliers (`heightTight/Snug/Relaxed`) were removed.
- `lib/src/theme/app_typography.dart` → `GHAppTypography.standard()`: each role binds `fontFamily`, `fontSize`, retained `fontWeight`, `height = lineHeightPx ÷ sizePx`, and `letterSpacing`.
- `pubspec.yaml`: `Inter` family wired with weights 400/500/600/700; description updated off "Material 3 based".
- `assets/fonts/Inter-{Regular,Medium,SemiBold,Bold}.ttf`: latin static weights (fontsource).

### Role → Finesse mapping (as implemented)

| Material role | Finesse step | Size | Line (px) | Letter (px) | Weight |
|---|---|---|---|---|---|
| displayLarge   | Titles/Large        | 120 | 150 | −2.40 | Regular 400 |
| displayMedium  | Titles/Small        | 96  | 120 | −1.92 | Regular 400 |
| displaySmall   | Headings/Huge       | 72  | 90  | −1.44 | Regular 400 |
| headlineLarge  | Headings/Extra Large| 60  | 72  | −1.20 | Semi Bold 600 |
| headlineMedium | Headings/Large      | 48  | 60  | −0.96 | Semi Bold 600 |
| headlineSmall  | Headings/Medium     | 36  | 44  | −0.72 | Semi Bold 600 |
| titleLarge     | Headings/Small      | 30  | 38  | 0     | Semi Bold 600 |
| titleMedium    | Headings/Extra Small| 24  | 32  | 0     | Medium 500 |
| titleSmall     | Body/Extra Large    | 20  | 30  | 0     | Medium 500 |
| bodyLarge      | Body/Large          | 18  | 28  | 0     | Regular 400 |
| bodyMedium     | Body/Medium         | 16  | 24  | 0     | Regular 400 |
| bodySmall      | Body/Small          | 14  | 20  | 0     | Regular 400 |
| labelLarge     | Body/Small (reused) | 14  | 20  | 0     | Medium 500 |
| labelMedium    | Body/Extra Small    | 12  | 18  | 0     | Medium 500 |
| labelSmall     | Body/Tiny           | 10  | 16  | 0     | Medium 500 |

All 14 distinct Finesse steps are covered; `Body/Small (14px)` maps to both `bodySmall` and `labelLarge` (matching Material's own 14px reuse).

---

## 7. Resolved decisions & remaining notes

1. **Weights** — the Finesse design does not annotate weight per step, so each role *retains the kit's prior weight* (display/body = Regular, headline + titleLarge = Semi Bold, titleMedium/Small + label = Medium). Revisit if design supplies per-step weights.
2. **Two grays** — `Gray/500 #667085` vs `Grey/500 #676E76` still needs reconciling, but that's a **color** concern, deferred to the colors pass (out of scope for this typography step).
3. **Knock-on effects** — changing the type scale will shift component golden images (`AppButton`/`AppBadge`/`AppChip` render text). Components were intentionally left untouched (typography-only scope); their goldens need regeneration in a follow-up.
4. **Next foundations** — colors, spacing, radii, elevation still follow the prior (non-Finesse) values. Capture those Finesse pages from Figma in later steps.
