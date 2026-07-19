# CLAUDE.md — `app/` (Design System Explorer, the mobile app)

This is the **demo app** for `ngh09_ui_kit` (`publish_to: 'none'`). It depends on
the kit via `path: ../` and exists to **showcase and exercise components** in a
runnable app — one "playground" screen per component, plus foundation screens
(colors, spacing, typography, radii, shadows, durations, breakpoints).

> The package's own conventions are in the repo-root [../CLAUDE.md](../CLAUDE.md)
> and [../ARCHITECTURE.md](../ARCHITECTURE.md). This file covers only the demo app.

## Documentation Guide — MANDATORY

Read BEFORE writing code:

| File                          | Read BEFORE                                                        |
|-------------------------------|-------------------------------------------------------------------|
| `app/CLAUDE.md`               | **(This file)** Any change under `app/`                            |
| [../CLAUDE.md](../CLAUDE.md)  | Understanding how kit components/tokens are meant to be consumed   |
| [../PLAN.md](../PLAN.md)      | Adding a playground for a newly built component                    |

---

## What this app is

- It **consumes** the kit through the public barrel only:
  `import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';`. If something you need isn't
  exported, that's a gap to fix in the kit's barrel, not to bypass.
- Screens are plain `StatefulWidget`s holding local playground state (`setState`).

---

## Layout (`app/lib/`)

```
lib/
├── main.dart                       ← MaterialApp with GHAppTheme.light()/dark()
└── explorer/
    ├── explorer_home_screen.dart   ← entry list of all sections/components
    ├── explorer_scaffold.dart      ← shared page chrome (ExplorerScaffold, ExplorerEyebrow)
    ├── explorer_screens.dart       ← screen registry / routing table
    ├── about_sheet.dart, app_version_widget.dart
    ├── widgets/                     ← SHARED explorer widgets (reuse these!)
    │   ├── preview_card.dart        (PreviewCard — frames the live component)
    │   ├── spec_panel.dart          (SpecPanel — shows the generated code spec)
    │   ├── segmented_picker.dart    (SegmentedPicker<T> + SegmentedPickerOption)
    │   ├── option_toggle_row.dart   (OptionToggleRow — labelled switch)
    │   ├── label_field.dart, component_list_tile.dart, tile_previews.dart
    ├── components/  inputs/  feedback/  navigation/  progress/  media/  foundations/
```

Playground screens are grouped by kit component category and named
`playground_<component>_screen.dart` (e.g.
[explorer/components/playground_button_screen.dart](lib/explorer/components/playground_button_screen.dart)).
Foundation screens are `<token>_screen.dart` under `foundations/`.

---

## Imports (in `app/`)

Grouped, alphabetical within each group:
1. `package:flutter/...` and external packages (`google_fonts`, `url_launcher`, …)
2. blank line
3. `package:ngh09_ui_kit/ngh09_ui_kit.dart` (the barrel)
4. `package:ngh09_ui_kit_app/explorer/...` (this app's own files, by package name)

---

## How to add a playground screen (the `playground_button_screen.dart` pattern)

1. Create `explorer/<category>/playground_<component>_screen.dart`.
2. `StatefulWidget` named `<Component>PlaygroundScreen` holding local option
   state (variant, size, a `_state` enum for normal/loading/disabled, toggles,
   a `TextEditingController` for editable text). Dispose controllers.
3. `build` returns an `ExplorerScaffold(title: ..., trailing: Reset button,
   body: ListView(...))`.
4. Inside the list:
   - `PreviewCard(child: <the live GH component wired to the current options>)`
   - `SpecPanel(spec: _spec)` where `_spec` is a getter building the equivalent
     `GHComponent(...)` code string from the current selections.
   - Option groups, each introduced by `const ExplorerEyebrow('LABEL')` then a
     `SegmentedPicker<T>` (iterate `EnumType.values` for options) or
     `OptionToggleRow` for booleans.
5. Use `context.spacing` (`spacing.md`, `spacing.lg`, …) for gaps — no magic
   numbers; the demo should model correct kit consumption.
6. Register the screen in `explorer/explorer_screens.dart` (and the home list) so
   it's reachable.
7. Reuse the shared `widgets/` — do not reinvent PreviewCard/SpecPanel/pickers.

---

## Code Style

- Named parameters for all widget constructors; `const` where possible;
  `super.key` last.
- Max line length 180; prefer `const`; `.0` on rounded doubles.
- Read colors/spacing/typography from `context.*` — the demo must never hardcode
  design values, since it doubles as the reference for consumers.
- Local playground `enum`s (e.g. `_ButtonState`) go at the top or bottom of the
  screen file and are private (`_`-prefixed).
- Avoid nested/local functions; extract private methods or small private widgets.
- Doc comments are encouraged on screen classes (a one-line `///` describing the
  playground).

---

## Running & Analysis

- **fvm Flutter 3.44.6** (pinned in the repo `.fvmrc`). Run from the `app/` directory.
- `flutter pub get` then `flutter run` (only **iOS** is configured as a platform;
  see `flutter_launcher_icons` in `pubspec.yaml`).
- App icons are generated from `assets/branding/app_icon.png`
  (`dart run flutter_launcher_icons`); the master is rendered by
  `tool/render_icon.py`. Don't hand-edit generated icon assets.
- `flutter analyze` inside `app/` to lint the demo. Fix errors first.
- Do NOT run `format`, code generation, or compile-at-end unless asked.
