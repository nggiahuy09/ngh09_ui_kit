# Architecture & Flow of `ngh09_ui_kit`

> This document gives a repo-wide overview: the important folders/modules, the flow
> for implementing a component, and the test flow. It's for newcomers or anyone who
> needs to grasp quickly how the kit works. The component roadmap lives in
> [PLAN.md](PLAN.md).

---

## Overview

This is a **Flutter package** (not an app) that acts as a **UI Kit / Design System**
built on **Material 3 + its own design tokens**. It is publishable to pub.dev, ships
with a runnable `example/` demo app, and is tested with **Unit + Widget + Golden**.

Current status: **Foundation complete + 1 component (`GHAppButton`)**.

---

## 1. Folder / module map

```
lib/
├── ngh09_ui_kit.dart          ← Barrel export: the ONLY public API of the package
└── src/                       ← Entirely private (consumers never import it directly)
    ├── tokens/      (Tier 1 — PRIMITIVE)   raw values, no meaning
    ├── theme/       (Tier 2 — SEMANTIC)    maps primitives → roles, varies by light/dark
    ├── components/  (Tier 3 — WIDGET)      public widgets, read only from the semantic layer
    └── utils/                              context extensions + responsive helpers
```

The core of the architecture is the **two-tier token system** — this is the "soul"
of the whole kit.

### Tier 1 — `tokens/` (primitive, raw values)

`abstract final class`es holding `static const` constants, carrying **no meaning**:

- `tokens/colors.dart` — palettes `brand50→900`, `neutral0→900`, status ramps
  `success/warning/danger/info` (50/500/700).
- `tokens/spacing.dart` — 4pt scale: `xs=4, sm=8, md=16, lg=24…`
- `tokens/typography.dart` — font size/weight/line-height following the M3 type scale.
- `tokens/radii.dart`, `tokens/elevation.dart`, `tokens/durations.dart`,
  `tokens/breakpoints.dart` — `mobile=600, tablet=1024, desktop=1440`.

> **The Golden Rule:** a widget **NEVER** reads `ColorTokens.brand500` directly.

### Tier 2 — `theme/` (semantic, meaningful mapping)

Each file is a `ThemeExtension<T>` with `copyWith` + `lerp`:

- `theme/app_colors.dart` — semantic roles (`primary`, `surface`, `onSurface`,
  `outline`, `danger`…). Has two presets `.light()`/`.dark()` mapping different
  primitives, plus `toColorScheme()` to project onto Material's `ColorScheme`.
- `theme/app_typography.dart` — 15 semantic text styles + `toTextTheme()`.
- `theme/app_spacing.dart`, `theme/app_radii.dart` — (radii also has a convenience
  getter `borderRadiusMd`).
- `theme/app_theme.dart` — the **assembly point**: `GHAppTheme.light()/dark()` builds
  the M3 `ThemeData`, projects semantic colors→`ColorScheme`, typography→`TextTheme`,
  then attaches the four extensions. Takes `colors`/`typography` params for
  **re-branding**.

### `utils/`

- `utils/context_extensions.dart` — shortcuts `context.colors`, `context.spacing`,
  `context.radii`, `context.textStyles`, `context.isDarkMode` (instead of the verbose
  `Theme.of(context).extension<...>()!`) + MediaQuery helpers
  (`isMobile/isTablet/isDesktop`).
- `utils/responsive.dart` — `enum ScreenType`,
  `context.responsiveValue(mobile:…, tablet:…, desktop:…)` (with fallback down to a
  smaller breakpoint), and the `ResponsiveBuilder` widget.

### Tier 3 — `components/`

- `components/buttons/button_variant.dart` — `enum ButtonVariant`
  (filled/tonal/outlined/text) + `enum ButtonSize` (small/medium/large).
- `components/buttons/app_button.dart` — a `StatelessWidget` that reads **100% from
  `context.*`** with nothing hardcoded. Has a default + 4 named constructors,
  `leading/trailing`, `isLoading`/`disabled` (`onPressed == null`)/`expanded`. Loading
  keeps the label so the layout doesn't jump. Leans on the built-in semantics of
  `FilledButton/OutlinedButton/TextButton`.

### Sub-project (not part of the published package)

- `example/` — the runnable demo app, depending back through `path: ../`, so it
  **never leaks into** the package's dependencies. A single-screen
  `example/lib/main.dart` themes a `MaterialApp` with `GHAppTheme` and composes
  the kit's `GH*` widgets; pub.dev detects it as the package example.

---

## 2. Flow to IMPLEMENT a component (following the `GHAppButton` template)

The data flow at runtime:

```
primitive token → semantic extension → GHAppTheme attaches into ThemeData
  → MaterialApp(theme:) → widget reads via context.colors/...
```

When writing a new component, repeat these exact 5 steps (the "Done" definition is in
§9 of PLAN):

1. **Variant/size enum** in its own file (`*_variant.dart`) — never a String.
2. **Widget** in `components/<group>/app_xxx.dart` — a `StatelessWidget`, `const`
   constructor, a named constructor per variant; every color/spacing/radius comes from
   `context.*`; use a `switch` expression to map variant→token (see
   `_foregroundColor`/`_backgroundColor` in `GHAppButton`).
3. **Doc comment `///`** on the class + every public member (required for pub points —
   the `public_member_api_docs` lint).
4. **Export** through the barrel `lib/ngh09_ui_kit.dart`.
5. **Test** (see §3), and (recommended) showcase the component in the demo
   (`example/lib/main.dart`).

---

## 3. TEST flow (3 tiers)

| Tier       | Tool           | What it tests                                                                                                                                              | File                                                                            |
| ---------- | -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| **Unit**   | `flutter_test` | token values, theme→`ColorScheme`/`TextTheme` mapping, `copyWith`/`lerp`, `ScreenType`, context extensions                                                 | `test/tokens/app_theme_test.dart`                                               |
| **Widget** | `flutter_test` | correct render, tap callback, disabled/loading, hiding the icon while loading, **a11y semantics** (`matchesSemantics`), named-ctor→variant, expanded width | `test/components/buttons/app_button_test.dart`                                  |
| **Golden** | **alchemist**  | UI snapshot per variant × light/dark, sizes, states                                                                                                        | `test/components/buttons/app_button_golden_test.dart` + images in `goldens/ci/` |

Key mechanics:

- **`test/flutter_test_config.dart`** — Flutter runs this file automatically before
  every test. It wraps `AlchemistConfig.runWithConfig` and **turns off platform
  goldens**, keeping only **CI goldens** (pixel-exact, stable on every machine → less
  flaky). Alchemist loads real fonts so text isn't rendered as boxes.
- The test pattern always has a `_wrap`/`_themed` helper that wraps the widget in
  `GHAppTheme.light()/dark()` so `context.*` can resolve.
- Goldens for `loading` use `pumpBeforeTest: pumpOnce` because the spinner spins
  infinitely → `pumpAndSettle` would hang.
- Updating goldens is a manual, reviewed action: `flutter test --update-goldens`
  (CI only verifies; updating is forbidden there).

**Actual commands (using fvm Flutter 3.44.6):**

```bash
dart format .
flutter analyze --fatal-infos
flutter test                       # includes the golden compare
flutter test --update-goldens      # when the UI is changed intentionally
```

---

## In short — the mental model

> **Raw token → assign meaning (semantic) → `GHAppTheme` packages it into `ThemeData`
> → widget only "reads" via `context.*`.** Changing the brand/theme touches **one
> place** (the semantic layer), and every component follows automatically. A component
> is "done" only when it has: token-driven code + `///` docs + widget test (including
> a11y) + light/dark golden test.
