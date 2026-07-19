# ngh09_ui_kit_example — Design System Explorer

A runnable demo for [`ngh09_ui_kit`](../). It is a **Design System Explorer**: a
navigable showcase that exercises every kit component and foundation token on the
kit's real widgets and theme layer — the same code a consumer would write.

The app depends on the kit via `path: ../` and consumes it **only through the
public barrel** (`import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';`). If something
isn't exported, that's a gap to fix in the kit's barrel — not to bypass.

## What's inside

A home screen lists **12 categories**; each row opens a screen:

- **Components** — Buttons, Icon buttons, Badges, Chips, Avatars
- **Feedback** — Alerts, Snackbars, Tooltips
- **Inputs** — Checkbox, Radio, Toggle, Slider, Range slider, Text field,
  Text area, Dropdown, Input dropdown
- **Navigation** — Segmented control, Breadcrumbs, Pagination
- **Progress** — Progress bar, Progress stepper
- **Media** — Flags, Icons, Logos, Payment icons
- **Foundations** — Colors, Typography, Spacing, Radii, Shadows, Breakpoints,
  Durations

Component screens are interactive **playgrounds**: a live preview, a generated
code spec, and pickers/toggles that drive the component's variants, sizes, and
states. Foundation screens render each token scale. Light/dark theme toggle and
an About sheet live in the home header.

## Running

Uses **fvm Flutter 3.44.6** (pinned in the repo `.fvmrc`). Only **iOS** is set up
as a platform.

```bash
cd example
flutter pub get
flutter run
```

App launcher icons are generated from `assets/branding/app_icon.png`
(`dart run flutter_launcher_icons`); the master is rendered by `tool/render_icon.py`.
Don't hand-edit generated icon assets.

## Layout (`lib/`)

```
lib/
├── main.dart                       ← MaterialApp with GHAppTheme.light()/dark()
└── explorer/
    ├── explorer_home_screen.dart   ← entry list of all sections
    ├── explorer_scaffold.dart      ← shared page chrome (ExplorerScaffold, ExplorerEyebrow)
    ├── explorer_screens.dart       ← screen registry
    ├── about_sheet.dart, app_version_widget.dart
    ├── widgets/                     ← SHARED explorer widgets (reuse these!)
    │   ├── preview_card.dart        (PreviewCard — frames the live component)
    │   ├── spec_panel.dart          (SpecPanel — shows the generated code spec)
    │   ├── segmented_picker.dart    (SegmentedPicker<T> + SegmentedPickerOption)
    │   ├── option_toggle_row.dart   (OptionToggleRow — labelled switch)
    │   ├── label_field.dart, component_list_tile.dart, tile_previews.dart
    └── components/ inputs/ feedback/ navigation/ progress/ media/ foundations/
```

Playground screens are named `playground_<component>_screen.dart`; foundation
screens are `<token>_screen.dart`.

## Adding a playground screen

1. Create `explorer/<category>/playground_<component>_screen.dart`.
2. A `StatefulWidget` named `<Component>PlaygroundScreen` holds local option state
   (variant, size, a `_state` enum, toggles, a `TextEditingController` for editable
   text). Dispose controllers. Local `enum`s are private (`_`-prefixed).
3. `build` returns an `ExplorerScaffold(title:, trailing: Reset button, body: ListView(...))`.
4. In the list: a `PreviewCard(child: <live GH component>)`, a `SpecPanel(spec: _spec)`
   whose `_spec` getter renders the equivalent `GHComponent(...)` code string, then
   option groups — each an `ExplorerEyebrow('LABEL')` followed by a
   `SegmentedPicker<T>` (iterate `EnumType.values`) or `OptionToggleRow` for booleans.
5. Register the screen in `explorer/explorer_screens.dart` and add its row to the
   home list.
6. **Reuse the shared `widgets/`** — do not reinvent PreviewCard / SpecPanel / pickers.

## Conventions

The demo doubles as the reference for correct kit consumption, so it holds itself
to the kit's rules:

- **Read all design values from `context.*`** (`context.colors`, `context.spacing`,
  `context.textStyles`, `context.radii`, `context.shadows`) — never hardcode colors,
  spacing, or radii.
- Named parameters for widget constructors; `const` wherever possible; `super.key`
  last; `.0` on rounded doubles; max line length 180.
- Avoid functions returning widgets — extract a small private widget instead.
- Prefer `DecoratedBox` / `Padding` / `SizedBox` / `ColoredBox` over `Container`
  unless you genuinely need several properties at once.

Full package conventions live in [../CLAUDE.md](../CLAUDE.md); the demo-specific
rules are in [CLAUDE.md](CLAUDE.md).
