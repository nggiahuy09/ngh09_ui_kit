# CLAUDE.md — `ngh09_ui_kit` (package)

This is a **Flutter package / design system** (published to pub.dev). It is a
**two-tier token architecture** with themeable Material 3 widgets. A minimal
runnable demo lives in [example/](example/) — a single-screen
[example/lib/main.dart](example/lib/main.dart) that themes a `MaterialApp` with
`GHAppTheme` and composes the kit's `GH*` widgets — so pub.dev detects the
package example.

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
| [UI_KIT_RULES.md](UI_KIT_RULES.md) | MUST/SHOULD/NEVER checklist: a11y, perf, responsive, semver, line length, comments/codegen, asserts, collections, composition |
| [README.md](README.md)     | Public-facing usage, install, consumer-facing API                            |

> `UI_KIT_RULES.md` is a checklist layered on top of this file. Where the two
> disagree, **`CLAUDE.md` wins**.

**Minimum reads per task type:**
- New component end-to-end: `CLAUDE.md` + `ARCHITECTURE.md` (§2 implement flow, §3 test flow) + `PLAN.md`
- New/changed token or semantic theme: `CLAUDE.md` + `ARCHITECTURE.md` (two-tier token section)
- Test-only change: `CLAUDE.md` + `ARCHITECTURE.md` (§3)
- Demo/example change: `CLAUDE.md` + [example/lib/main.dart](example/lib/main.dart)

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
- Components live under `components/<group>/`: buttons, inputs, feedback, navigation,
  display, progress, avatars, flags, logos, icons, payment. (`layout/` exists as an
  empty placeholder — see [PLAN.md](PLAN.md) for the widgets slated to land there.)

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
| Variant/size enum    | `{concept}_variant.dart` / `{concept}_size.dart` | `ButtonVariant` + `ButtonSize` in `button_variant.dart`; `IconButtonSize` in `icon_button_size.dart` |
| Primitive token      | `{Kind}Tokens` abstract final class | `ColorTokens` in `tokens/colors.dart`; `SpacingTokens` in `tokens/spacing.dart` — one file per kind |
| Semantic extension   | `GHApp{Kind}` `ThemeExtension`   | `GHAppColors` in `theme/app_colors.dart`; `GHAppSpacing` in `theme/app_spacing.dart` — one file per kind |
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
- Max line length: **180 characters** (`lines_longer_than_80_chars` is intentionally
  ignored, so the analyzer does NOT enforce this — it's a convention). Count
  characters, not bytes: `─`/`×`/`≥` are multi-byte, so `awk 'length>180'` and
  `wc -L` over-report. Today **0 lines exceed 180**; the longest is 159. It's a
  ceiling, not a target — don't collapse a readable widget tree to use up the budget.
  Full rule: [UI_KIT_RULES.md](UI_KIT_RULES.md) §16.
- Wrap `///` doc text at ~80 chars even though code may reach 180 — docs render as
  prose on pub.dev. Group members in large widgets with
  `// ── Section ──` banners padded to exactly 80 chars (see `app_button.dart`);
  `Build` goes last. Comments explain **why**, not **what**. See §17.
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
1. Collections (List, Map, Set) — regardless of element type. A widget prop is a
   plain `List<T>`; never mutate it (see [UI_KIT_RULES.md](UI_KIT_RULES.md) §19).
   The "expose collections as unmodifiable views" rule for domain entities does
   **not** apply to widgets.
2. UI types (Widget, Controller, FocusNode, Services)
3. User-defined classes (tokens, enums-as-classes)
4. Enums
5. Complex Dart types (Duration, DateTime, Stream)
6. Primitives — exact order: `String` > `double` > `int` > `bool`
7. Callbacks — `VoidCallback` for no-arg, `ValueChanged<T>` for single-value; these
   are the Flutter idiom and what this package uses throughout (16 + 16 = 32
   declarations, 0 uses of bare `void Function`). Order by arity, then by return
   type, within the group:
   `VoidCallback` → `ValueChanged<T>` → `void Function(T1, T2)` → `T Function()` →
   `T Function(T p)`.
   Reach for an explicit `void Function(...)` only when the signature has 2+ params
   or a return value, where no Flutter typedef fits.

> **Do not** swap `VoidCallback`/`ValueChanged<T>` for a bare `void Function()` to
> "reduce dependency" — they are `dart:ui` / `foundation.dart` typedefs, so they are
> the *same type* with no extra import. Spelling them out costs the shared vocabulary
> and the signal that `ValueChanged` carries, and diverges from how the SDK itself
> declares `InkWell.onTap` / `TextField.onChanged`. Gains nothing.

Constructor parameters follow declaration order regardless of nullability;
call sites follow constructor declaration order strictly.

Named parameters: required for **all** widget constructors (see §Widgets). For
non-widget methods and helper classes, use them when there are > 3 parameters or
≥ 2 parameters share a type — and **never** for a single-parameter method.

## Class Member Ordering

1. Constructors (default first, then named variant constructors)
2. `static const` values of the class's own type (e.g. token/catalog entries), then
   static factory-ish methods returning that same type
3. Final fields from the constructor (the public props, doc-commented) — in the
   same order as the constructor parameters, per §Field / Parameter Ordering
4. Other static members
5. `createState()` (for `StatefulWidget`)
6. State: controllers/fields, then getters, private helper getters/methods
   (grouped by concern with `// ── Section ──` banners, as in `app_button.dart`)
7. Read-only properties (except `hashCode`)
8. Overridden getters/methods that aren't `build`
9. Operators other than `==`
10. `build` method
11. `operator ==`, `hashCode`, `toString`, diagnostics — always last (see
    [gh_icon_data.dart](lib/src/components/icons/gh_icon_data.dart))

Public widgets and tokens in this package are **immutable** — `lib/` currently has
zero setters, and a `GH*` widget must not gain one. If a `State` class genuinely
needs a mutable property, keep the trio adjacent with **no blank lines between
them**, in the order getter → private field → setter, and place it in tier 6.

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
- Golden images live beside their test, in `test/components/<group>/goldens/ci/`
  (there is no root-level `goldens/`). Updating them is a **manual, reviewed**
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
6. (Recommended) Showcased in the demo — see [example/lib/main.dart](example/lib/main.dart).

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
- `example/**` (the demo app) and generated files are excluded from analysis.
- Do NOT run `format`. Do NOT compile/run code at the end of changes. Do NOT run
  code generation. This project uses **fvm Flutter 3.44.6** (pinned in `.fvmrc`).
