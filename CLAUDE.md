# CLAUDE.md — `ngh09_ui_kit` (package)

This is a **Flutter package / design system** (published to pub.dev). It is a
**two-tier token architecture** with themeable Material 3 widgets. The demo app
lives in [example/](example/) and has its own [example/CLAUDE.md](example/CLAUDE.md).

## Documentation Guide — MANDATORY

**RULE: You MUST read the matching file(s) below BEFORE writing any code.** Not
optional. Do not rely on memory or prior sessions — read fresh. If a task touches
multiple rows, read all matching files.

| File                       | Read BEFORE                                                                   |
|----------------------------|------------------------------------------------------------------------------|
| `CLAUDE.md`                | **(This file)** Any code change — conventions, naming, ordering, constraints  |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Adding/changing any component, token, or theme; understanding data flow; the test flow |
| [PLAN.md](PLAN.md)         | Picking up the roadmap, checking a component's "Done" definition & status     |
| [WIDGET_GUIDE.md](WIDGET_GUIDE.md) | Discovering which `GH*` widget exists for a UI need before building/consuming |
| [README.md](README.md)     | Public-facing usage, install, consumer-facing API                            |

**Minimum reads per task type:**
- New component end-to-end: `CLAUDE.md` + `ARCHITECTURE.md` (§2 implement flow, §3 test flow) + `PLAN.md`
- New/changed token or semantic theme: `CLAUDE.md` + `ARCHITECTURE.md` (two-tier token section)
- Test-only change: `CLAUDE.md` + `ARCHITECTURE.md` (§3)
- Demo/showcase change: `example/CLAUDE.md`

**If you skip reading a required file before implementing, the output is considered non-compliant.**

---

## The Golden Rule

> **Primitive token → semantic (`ThemeExtension`) → `GHAppTheme` into `ThemeData`
> → widget reads via `context.*`.**

- Widgets **NEVER** read a primitive token directly (e.g. `ColorTokens.brand500`).
  They read the semantic layer through `context.colors`, `context.spacing`,
  `context.radii`, `context.shadows`, `context.textStyles`.
- Re-branding must touch **one place** (the semantic layer), never a widget.
- No hardcoded colors / spacing / radii / durations in widgets. Map
  variant/size → token with a `switch` expression (see `_foregroundColor` /
  `_padding` in [lib/src/components/buttons/app_button.dart](lib/src/components/buttons/app_button.dart)).
- The **only** exception where raw numeric values live inline is per-component
  Finesse-spec dimensions (padding/icon size/gap) that are not part of a shared
  token scale — keep them in a `switch` getter, commented, as `app_button.dart` does.

---

## Layer Map (`lib/src/`)

```
lib/
├── ngh09_ui_kit.dart   ← Barrel: the ONLY public API. Everything under src/ is private.
└── src/
    ├── tokens/       (Tier 1 — PRIMITIVE)  raw abstract final class + static const, no meaning
    ├── theme/        (Tier 2 — SEMANTIC)   ThemeExtension<T> with copyWith + lerp; .light()/.dark()
    ├── components/   (Tier 3 — WIDGET)     public widgets, read ONLY from context.* (semantic)
    └── utils/                              context extensions + responsive helpers
```

- `tokens/` — never has semantics. `theme/` — maps primitives → roles. `theme/app_theme.dart`
  is the assembly point (`GHAppTheme.light()/dark()`), and takes `colors`/`typography`
  params for re-branding.
- Components live under `components/<group>/` (buttons, inputs, feedback, navigation,
  display, progress, avatars, flags, logos, icons, payment, layout).

---

## Imports

This package uses **absolute `package:` imports internally**:

- **Inside `lib/src/`**: import siblings with full paths
  `import 'package:ngh09_ui_kit/src/theme/app_colors.dart';` — NOT the barrel, to
  avoid a self-import cycle. Match what neighbouring files already do.
- **`lib/ngh09_ui_kit.dart`**: `export 'src/...';` entries, kept **alphabetically
  sorted within their comment-grouped section** (Components, Foundation semantic,
  Foundation tokens, Utilities). Every new public file MUST be exported here.
- **Grouping & order** in each file:
  1. `package:flutter/...` and external packages (alphabetical)
  2. blank line
  3. project `package:ngh09_ui_kit/src/...` imports (alphabetical)

---

## Naming Conventions

| Thing                | Pattern                          | Example                                   |
|----------------------|----------------------------------|-------------------------------------------|
| Public widget        | `GH`-prefixed class in `gh_*.dart` (or `app_*.dart` for the older set) | `GHUserAvatar` in `gh_user_avatar.dart`; `GHAppButton` in `app_button.dart` |
| Variant/size enum    | `{concept}_variant.dart` / `{concept}_size.dart` | `ButtonVariant` in `button_variant.dart`; `ButtonSize` in `icon_button_size.dart` |
| Primitive token      | `{Kind}Tokens` abstract final class | `ColorTokens`, `SpacingTokens` in `tokens/colors.dart` |
| Semantic extension   | `GHApp{Kind}` `ThemeExtension`   | `GHAppColors`, `GHAppSpacing` in `theme/app_colors.dart` |
| Extension file       | `{type}_extensions.dart`         | `context_extensions.dart`                 |

- **`GH` prefix** for all public component classes. `PascalCase` classes,
  `camelCase` methods/vars, `snake_case` file names.
- Enum values are `camelCase` (`ButtonVariant.secondaryGrey`). Never snake_case
  or UPPER_SNAKE.
- Define enums at the **end of the file**, or in their own `*_variant.dart` /
  `*_size.dart` file when shared — never as a bare `String`.

---

## Public API Docs — MANDATORY

`analysis_options.yaml` enables `very_good_analysis` with
`public_member_api_docs`. **Every public class and public member MUST have a
`///` doc comment** (matters for the pub.dev score). Reference the density in
[app_button.dart](lib/src/components/buttons/app_button.dart):

- Class doc: what it is, the variants/sizes/states it supports, a `dart` usage
  block, and behavioural notes (e.g. disabled/loading semantics).
- Each field: one line; note interactions (e.g. "Hidden while [isLoading].").
- Use `[SquareBracket]` references to link related symbols.

---

## Code Style

### Philosophy
- Think of the future: make the current implementation maintainable and
  subsequent changes seamless and low-risk.
- Cover edge/corner cases: disabled, loading, empty, error, overflow, dark mode.
- Take responsibility. No half-baked implementations that "just pass analysis."
  Find and solve the root cause; discuss with the user when unsure.
- Constraints exist for codebase quality. **DO NOT circumvent them with tricks,
  hacks, or lint suppressions just to avoid review.**

### Formatting
- Max line length: 180 (`lines_longer_than_80_chars` is intentionally ignored).
- Prefer `const` everywhere possible (const constructors, const literals).
- Rounded doubles must carry `.0` (`12.0`, not `12`) — but a `switch` returning
  Finesse spec ints (e.g. `18`) that Dart coerces to `double` follows the
  existing code; match the surrounding file.
- Don't assign an intermediate variable used only once — inline it. Exception:
  a local that shortens a long line or clarifies a complex ternary / `map`/`where` chain.
- Invoke callbacks with `.call()` (`onChanged.call(value)`), EXCEPT when passing
  a callback straight into a widget prop (`onTap: onCancel`).

### Widgets
- **Always named parameters** for widget constructors.
- `const` constructor + `super.key` last in the parameter list (matching
  `app_button.dart`).
- `StatelessWidget` by default; use `StatefulWidget` only when local state is
  required (e.g. the `WidgetStatesController` shadow pattern in `GHAppButton`).
- Read all styling from `context.*`. Map with `switch` expressions.
- Preserve footprint across states (loading keeps the label so layout doesn't jump).
- Respect a11y: rely on the underlying Material semantics; test with
  `matchesSemantics`.

### Parameters (general)
- Named parameters for constructors/methods with > 3 params, or when ≥ 2 params
  share a type. Named params are forbidden for a single-parameter method.
- No generic names: `value1/value2` → `primaryValue/secondaryValue`.

### Null Safety
- Nullable field → use `?.`, don't guard with `!= null` before a call.
- Avoid chaining `!` and `?`; assign to a `final` local and null-check it.

### Avoid local functions
- No nested/local functions defined inside another function. Extract a private
  method or `_SubWidget` instead (see `_ButtonContent` in `app_button.dart`).
  If it can't be avoided, treat it as a blocker and raise it.

---

## Field / Parameter Ordering

Group by type, in this order; sort by name within each group:
1. Collections (List, Map, Set)
2. UI types (Widget, Controller, FocusNode)
3. User-defined classes (tokens, enums-as-classes)
4. Enums
5. Complex Dart types (Duration, DateTime, Stream)
6. Primitives — exact order: `String` > `double` > `int` > `bool`
7. Callbacks — prefer explicit `void Function(...)` signatures over
   `VoidCallback`/`ValueChanged<T>` where it reduces coupling.

Constructor parameters follow declaration order regardless of nullability;
call sites follow constructor declaration order strictly.

## Class Member Ordering

1. Constructors (default first, then named variant constructors)
2. Final fields from the constructor (the public props, doc-commented)
3. `createState()` (for `StatefulWidget`)
4. State: controllers/fields, then getters, private helper getters/methods
   (grouped by concern with `// ── Section ──` banners, as in `app_button.dart`)
5. `build` method last (before any `==`/`hashCode`/`toString`)

For `ThemeExtension`s: fields → `copyWith` → `lerp` → any projection helpers
(`toColorScheme()`, `toTextTheme()`).

---

## Testing (3 tiers) — see ARCHITECTURE.md §3

| Tier   | Tool          | Covers                                                              |
|--------|---------------|--------------------------------------------------------------------|
| Unit   | `flutter_test`| token values, theme→`ColorScheme`/`TextTheme`, `copyWith`/`lerp`, extensions |
| Widget | `flutter_test`| render, tap, disabled/loading, icon hiding, **a11y (`matchesSemantics`)**, named-ctor→variant |
| Golden | **alchemist** | snapshot each variant × light/dark × size × state                  |

- `test/flutter_test_config.dart` runs automatically before all tests; it forces
  **CI goldens only** (platform goldens off) for pixel-stable, low-flake results.
- Test files mirror `lib/src/` under `test/` (`test/components/<group>/*_test.dart`
  and `*_golden_test.dart`).
- Wrap widgets in `GHAppTheme.light()/dark()` (helper `_wrap`/`_themed`) so
  `context.*` resolves.
- Infinite-animation goldens (spinners) use `pumpBeforeTest: pumpOnce` — never
  `pumpAndSettle` (it hangs).
- Golden images live in `goldens/ci/`. Updating them is a **manual, reviewed**
  action (`flutter test --update-goldens`); CI only verifies. Do NOT
  `--update-goldens` unless the user explicitly asks and the UI change is intentional.
- `failures/` dirs are diff artifacts — never commit or hand-edit them.

---

## Definition of Done (per component)

A component is "done" only when ALL hold:
1. Variant/size enum in its own file (no `String`).
2. Widget is token-driven (reads only `context.*`), `const` ctor + named
   variant constructors.
3. `///` docs on the class and every public member.
4. Exported from the barrel `lib/ngh09_ui_kit.dart` (alphabetical in its section).
5. Widget test (including a11y) + golden test (light/dark).
6. (Recommended) A playground screen added to the demo — see `example/CLAUDE.md`.

---

## Constraints

**DO NOT circumvent established constraints with tricks, hacks, or lint
suppressions just to avoid review.**

- **No primitive tokens in widgets.** Widgets read the semantic layer via
  `context.*`. If a needed role is missing, add it to the semantic layer — do not
  reach into `tokens/`.
- **No hardcoded style values** (color / radius / duration) outside a documented
  per-component Finesse-spec `switch`.
- **Barrel is the only public surface.** Never tell consumers to import from
  `src/`. Any new public symbol must be exported.
- **No local/nested functions** — extract private methods or sub-widgets.
- **Don't hand-edit generated files** (`*.g.dart`, `*.freezed.dart`) or golden
  `failures/` artifacts.

---

## Analysis

- Run `flutter analyze` on changed files/folders; fix **errors first**.
  `analysis_options.yaml` is strict (`strict-casts`/`inference`/`raw-types`,
  `public_member_api_docs`). Missing docs surface here.
- `example/**` and generated files are excluded from analysis.
- Do NOT run `format`. Do NOT compile/run code at the end of changes. Do NOT run
  code generation. This project uses **fvm Flutter 3.44.6** (pinned in `.fvmrc`).
