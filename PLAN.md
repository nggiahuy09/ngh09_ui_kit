# Roadmap — `ngh09_ui_kit`

> **Goal:** a Flutter **package** acting as a UI Kit / Design System, publishable
> to **pub.dev**, built on **Material 3 + its own design tokens** (the Finesse UI
> Kit), shipped with a runnable `example/` demo and tested with **Unit + Widget +
> Golden**.

This file tracks **status and what's left**. It is not the reference for how the
kit is structured or which widget to use — for that see:

- [CLAUDE.md](CLAUDE.md) — conventions, naming, ordering, the "Done" definition.
- [ARCHITECTURE.md](ARCHITECTURE.md) — the two-tier token architecture, the
  implement flow (§2) and the test flow (§3).
- [WIDGET_GUIDE.md](WIDGET_GUIDE.md) — the full inventory of shipped `GH*` widgets
  and their variants.

---

## Foundations (decided)

| Topic        | Choice                                                              |
|--------------|--------------------------------------------------------------------|
| Distribution | Publish to pub.dev (package) + `example/` demo app                  |
| Theming      | Material 3 (`ThemeExtension`) + custom design tokens               |
| Catalog      | `example/` demo — one screen composing the `GH*` widgets            |
| Testing      | Unit + Widget + Golden (alchemist)                                  |
| Toolchain    | fvm Flutter 3.44.6 (pinned in `.fvmrc`)                             |

**Two-tier token rule (the core constraint):** `tokens/` holds primitives (raw,
meaningless values); `theme/` maps them to semantic roles (`GHApp*`
`ThemeExtension`s); components read **only** from the semantic layer via
`context.*` and never hardcode a primitive. Re-branding touches one place.

---

## Current status

**Foundation — done.**
- `tokens/`: `colors`, `spacing`, `typography`, `radii`, `shadows`, `durations`,
  `breakpoints`.
- `theme/`: `GHAppColors`, `GHAppTypography`, `GHAppSpacing`, `GHAppRadii`,
  `GHAppShadows` (each with `copyWith` + `lerp`), assembled by
  `GHAppTheme.light()` / `.dark()` — which accept custom `colors`/`typography`
  for re-branding.
- `utils/`: `context.colors/spacing/radii/shadows/textStyles` extensions and
  `responsive.dart` (`ScreenType`, `responsiveValue`, `ResponsiveBuilder`).

**Components — the following are shipped** (full API in
[WIDGET_GUIDE.md](WIDGET_GUIDE.md)):

| Group      | Widgets                                                                 |
|------------|-------------------------------------------------------------------------|
| Buttons    | `GHAppButton`, `GHAppIconButton`                                         |
| Display    | `GHAppBadge`, `GHAppChip`                                                |
| Avatars    | `GHUserAvatar`                                                           |
| Feedback   | `GHAppAlert`, `GHSnackbar`, `GHTooltip`                                  |
| Inputs     | `GHAppTextField`, `GHAppTextArea`, `GHAppCheckbox`, `GHAppRadio`, `GHAppToggle`, `GHAppSlider`, `GHAppRangeSlider`, `GHAppDropdown` (+ `GHAppInputDropdown`) |
| Navigation | `GHAppSegmentedControl`, `GHBreadcrumbs`, `GHPagination`                 |
| Progress   | `GHProgressBar`, `GHProgressStepper`                                     |
| Flags      | `GHCountryFlag`                                                          |
| Icons      | `GHHeroIcon` (`GHIcons` catalog)                                         |
| Logos      | `GHCompanyLogo`                                                          |
| Payment    | `GHPaymentIcon`                                                          |

**Demo — done.** `example/lib/main.dart` is a single screen: a `MaterialApp`
themed with `GHAppTheme.light()/.dark()` (light/dark via `themeMode`) that
composes the common `GH*` widgets, all reading style from `context.*`.

---

## What's left

**Components not yet built** (build each following the `GHAppButton` template in
[ARCHITECTURE.md](ARCHITECTURE.md) §2, to the "Done" definition below):

- Display: `GHAppCard` (surface + shadow; elevated/outlined/filled), `GHAppDivider`.
- Feedback / overlays: `GHAppDialog`, `GHAppBottomSheet`, `GHAppSkeleton`/shimmer.
- Progress: standalone `GHAppProgressIndicator` (linear + circular) — extract the
  spinner currently inlined in `GHAppButton`.
- Layout: `GHAppListTile`, `GHAppScaffold`, `GHAppGap`, and (optional) `GHAppText`.
- Navigation: `GHAppTabs`, `GHAppAppBar`, `GHAppBottomNav`.

The current token set is expected to cover these without new primitives — status
colors, surfaces, outline and shadows are already in place.

**CI & publish** (not yet set up):
- `.github/workflows/ci.yaml`: `pub get` → `analyze` → `test` (golden verify runs
  inside the test step; goldens are verified, never `--update-goldens`, in CI).
- `dart pub publish --dry-run` clean.
- Automated publishing on pub.dev (GitHub OIDC — no token), release `v0.1.0`.

---

## Definition of "Done" (per component)

Mirrors [CLAUDE.md](CLAUDE.md). A component is done only when ALL hold:

1. Variant/size `enum` in its own file (no bare `String`).
2. Token-driven widget (reads only `context.*`), `const` constructor + named
   variant constructors, light/dark support.
3. `///` docs on the class and every public member.
4. Exported from the barrel `lib/ngh09_ui_kit.dart` (alphabetical in its section).
5. Widget test (render + interaction + a11y semantics) + golden test (light/dark).
6. (Recommended) Showcased in the demo (`example/lib/main.dart`).

---

## Dependency philosophy

**Zero / minimal runtime dependency** — a UI kit should not pull heavy packages.
Runtime deps stay minimal (currently only `flutter_svg`, for the Heroicons SVGs);
tooling (`alchemist`, `very_good_analysis`) lives in `dev_dependencies`; the
demo's own dependencies live in `example/pubspec.yaml` and never leak into the
published package.
