# UI Kit Implementation Rules — `ngh09_ui_kit`

> **Baseline:** fvm Flutter 3.44.6 (pinned in `.fvmrc`) · Dart SDK `^3.9.0` ·
> Material 3 · Impeller · `very_good_analysis`
>
> **Convention:** **MUST** = required · **SHOULD** = recommended · **NEVER** = absolutely not.
> Any PR violating a MUST/NEVER is rejected.
>
> This is the **enforcement checklist** for `ngh09_ui_kit`. Companion docs:
> [CLAUDE.md](CLAUDE.md) (code conventions, field ordering) ·
> [ARCHITECTURE.md](ARCHITECTURE.md) (two-tier token architecture, implement/test flow) ·
> [PLAN.md](PLAN.md) (roadmap, status) ·
> [WIDGET_GUIDE.md](WIDGET_GUIDE.md) (inventory of shipped `GH*` widgets).
>
> Where this document and `CLAUDE.md` disagree, **`CLAUDE.md` wins** — it is the
> source of truth for code conventions.

---

## 1. Foundational principles

1. **MUST** — The UI Kit is a **pure presentation** package. No network, no
   storage, no analytics, no state management (Bloc/Riverpod/GetX).
2. **MUST** — Components receive data through the constructor and emit events
   through callbacks. They never fetch data themselves.
3. **NEVER** — Hardcode user-facing strings inside a component. Text is always
   passed from the app layer (the app owns i18n).
4. **MUST** — Every component must run standalone, wrapped only in
   `GHAppTheme.light()`/`.dark()` — no further app bootstrapping required.
5. **SHOULD** — Prefer `StatelessWidget`. Use `StatefulWidget` only when the state
   belongs to the UI itself (animation, focus, hover, expand) — e.g. the
   `WidgetStatesController` pattern in [`GHAppButton`](lib/src/components/buttons/app_button.dart).
6. **MUST** — Keep runtime dependencies minimal. A new `pubspec.yaml` dependency
   must carry its justification in a comment on that line (see how `flutter_svg`
   is explained). Tooling goes in `dev_dependencies`; the demo's dependencies live
   in `example/pubspec.yaml` and **never** leak into the package.

---

## 2. Folder structure

The **actual** structure of this repo (differs from the generic template: there is
no `foundations/`; tokens live in `tokens/` + `theme/`):

```
lib/
├── ngh09_ui_kit.dart           # barrel: the only public API
└── src/
    ├── tokens/                 # Tier 1 — PRIMITIVE: colors, spacing, typography,
    │                           #   radii, shadows, durations, breakpoints
    ├── theme/                  # Tier 2 — SEMANTIC: ThemeExtension + GHAppTheme.light/dark
    ├── components/<group>/      # Tier 3 — WIDGET
    │   └── buttons/ inputs/ feedback/ display/ navigation/ progress/
    │       avatars/ flags/ logos/ icons/ payment/ layout/
    └── utils/                  # context extensions + responsive helpers
test/
├── flutter_test_config.dart    # runs automatically before every test (alchemist config)
├── tokens/ utils/
└── components/<group>/
    ├── *_test.dart             # widget test
    ├── *_golden_test.dart      # golden test
    └── goldens/ci/             # golden images (CI goldens, colocated with the test)
```

1. **MUST** — Everything under `src/` is private. Export only through
   `ngh09_ui_kit.dart`.
2. **NEVER** — Apps import `package:ngh09_ui_kit/src/...` directly.
3. **MUST** — Put new components in an existing `components/<group>/`; create a new
   group only when none fits.
4. **MUST** — Inside `lib/src/`, import siblings with the **full `package:` path**
   (`package:ngh09_ui_kit/src/theme/app_colors.dart`) — **never** the barrel (it
   would create a self-import cycle).
5. **SHOULD** — Split files over 300 lines. Accepted exception: **catalog / lookup
   data** files (`gh_icons.dart`, `gh_company.dart`, `gh_country.dart`) — they are
   long because they are data tables, not because of logic.
6. **MUST** — Files are `snake_case`. Public widgets are named `gh_*.dart`; the
   older set uses `app_*.dart` (`app_button.dart`, `app_badge.dart`,
   `app_chip.dart`, `app_icon_button.dart`) — **leave those as they are** to avoid
   breaking changes. New code uses `gh_*`.

---

## 3. Naming & prefixes

1. **MUST** — Every **public widget class** carries the **`GH`** prefix:
   `GHAppButton`, `GHUserAvatar`, `GHProgressBar`.
2. **MUST** — Semantic `ThemeExtension`s follow `GHApp{Kind}`: `GHAppColors`,
   `GHAppSpacing`, `GHAppRadii`, `GHAppShadows`, `GHAppTypography`.
3. **MUST** — Primitive tokens are `abstract final class {Kind}Tokens`:
   `ColorTokens`, `SpacingTokens`, `RadiusTokens`, `ShadowTokens`,
   `DurationTokens`, `TypographyTokens`, `BreakpointTokens`. They carry **no** `GH`
   prefix — a deliberate exception, because tokens are an internal tier and `GH` is
   reserved for the API apps use day to day.
4. **SHOULD** — New public enums should carry the `GH` prefix (`GHAvatarSize`,
   `GHSnackbarState`). The repo still has unprefixed enums (`ButtonVariant`,
   `ButtonSize`, `BadgeColor`, `ChipSize`, `TooltipCorner`, …) — **do not rename
   them** (breaking change); apply `GH` to **new** enums only.
5. **MUST** — Private types in `src/` are `_`-prefixed (`_ButtonContent`,
   `_StepState`).
6. **NEVER** — Use another prefix (`Custom*`, `My*`) or leave a public widget
   unprefixed. No exceptions for "temporary" components.
7. **MUST** — Enum values are `camelCase` (`ButtonVariant.secondaryGrey`). Never
   snake_case, never UPPER_SNAKE.
8. **MUST** — Variant/size enums live in their **own file** when shared
   (`button_variant.dart`, `icon_button_size.dart`), or at the **end of** the widget
   file when used only internally. **NEVER** use a `String` in place of an enum.

---

## 4. Design tokens — two tiers

1. **NEVER** — Hardcode a color, spacing, radius, font size, or duration in a
   component.
   ```dart
   // ❌
   Container(color: const Color(0xFF2196F3), padding: const EdgeInsets.all(16))
   // ✅
   Container(color: context.colors.primary, padding: EdgeInsets.all(context.spacing.md))
   ```
2. **NEVER** — Use Material's `Colors.*` in a component (allowed only in the
   primitive token files).
3. **MUST** — Tokens are two-tier:
   - **Primitive** (`tokens/`): `brand500`, `neutral900` — **never** used directly
     in a component.
   - **Semantic** (`theme/`): `primary`, `surface`, `onSurface`, `outline`,
     `danger` — components use **only** this tier.
4. **MUST** — Use **this repo's** 4pt spacing scale:
   `none=0, xxs=2, xs=4, sm=8, smd=12, md=16, lg=24, xl=32, xxl=48, xxxl=64`.
   No off-scale values.
5. **MUST** — Dark mode is resolved at the token tier via `.light()`/`.dark()`.
   **NEVER** write `if (isDark)` to pick a color in a component. (`context.isDarkMode`
   is only for non-color decisions — e.g. choosing an asset.)
6. **MUST** — Use `withValues(alpha: ...)`; `withOpacity()` is deprecated. The repo
   is currently **clean** — keep it that way.
7. **MUST** — If a color/spacing role is missing, **add it to the semantic tier**.
   Never reach into `tokens/` from a widget.
8. **MUST (the one exception)** — Per-component Finesse-spec dimensions
   (padding/icon size/gap that aren't part of a shared scale) may be inline
   **inside a commented `switch` getter** — exactly as `_padding` does in
   `app_button.dart`. Do not scatter magic numbers through `build()`.

---

## 5. Theming

1. **MUST** — Tokens are exposed through `ThemeExtension<T>` with **complete
   `copyWith()` + `lerp()`** (a missing `lerp` breaks theme animation).
2. **MUST** — Access tokens through the `BuildContext` extension
   ([`context_extensions.dart`](lib/src/utils/context_extensions.dart)); do not
   scatter `Theme.of(context).extension<...>()!` calls:
   ```dart
   context.colors  context.spacing  context.radii  context.shadows  context.textStyles
   ```
3. **MUST** — `GHAppTheme.light()`/`.dark()` is the **single assembly point**: it
   projects semantic colors → `ColorScheme`, typography → `TextTheme`, then attaches
   the extensions. Re-branding goes through the `colors`/`typography` params —
   **never** by editing a widget.
4. **MUST** — Components **do not accept** absolute colors/sizes as required params.
   They resolve from the theme by default; an optional override is allowed.
5. **MUST** — Use `WidgetStateProperty` / `WidgetState` (no more
   `MaterialStateProperty` / `MaterialState`).
6. **SHOULD** — Map variant/size → token with a **`switch` expression** in a private
   getter (`_foregroundColor`, `_backgroundColor`, `_padding`). This repo does **not**
   use a separate `*_style.dart` pattern — don't introduce it for a single component;
   raise it for discussion first if you want to change that.

---

## 6. Component API

1. **MUST** — `const` constructor with `super.key` **last** in the parameter list:
   ```dart
   const GHAppButton({required this.label, this.onPressed, super.key});
   ```
2. **MUST** — Fields are `final`. `ThemeExtension` and style classes are
   `@immutable`.
3. **MUST** — Always use **named parameters** for widget constructors.
4. **MUST** — Express variants with an `enum` or a **named constructor** — never
   with stacked `bool`s.
   ```dart
   // ❌ GHAppButton(isPrimary: true, isOutlined: false, isDanger: true)
   // ✅ GHAppButton.primary(...) / variant: ButtonVariant.outlined
   ```
5. **MUST** — Disabled is expressed as `onPressed == null`; do **not** add a
   separate `isDisabled` flag.
6. **MUST** — Field/param ordering follows [CLAUDE.md](CLAUDE.md): grouped by type
   (Collections → UI types → user-defined → enums → Duration/DateTime → primitives
   `String > double > int > bool` → callbacks), sorted by name within each group.
   Call sites follow the constructor's declaration order exactly.
7. **NEVER** — Pass `BuildContext` as a component parameter.
8. **NEVER** — Put `Scaffold`, `MaterialApp`, or `SafeArea` inside a small
   component. A component makes no assumption about its position in the tree.
9. **SHOULD** — Accept custom child widgets through `Widget?` slots (`leading`,
   `trailing`) rather than a hardcoded `IconData`.
10. **MUST** — Any new param added to an already-public component must have a
    **default value** (non-breaking).
11. **MUST** — Preserve the layout footprint across states (loading keeps the label
    so the layout doesn't jump).
12. **NEVER** — Define a **local/nested function** inside another function. Extract
    a private method or a `_SubWidget` (see `_ButtonContent`). If it can't be
    avoided, treat it as a blocker and raise it.
13. **MUST** — Invoke callbacks with `.call()` (`onChanged.call(value)`), **except**
    when passing one straight into another widget's prop (`onTap: onCancel`) — there
    you pass the reference, never `() => onCancel.call()`.
14. **MUST** — Callback types: `VoidCallback` for no-arg, `ValueChanged<T>` for a
    single value. These are the Flutter idiom and what the package uses throughout.
    Use an explicit `void Function(T1, T2)` only for 2+ params or a return value.
15. **MUST** — Widgets always use named params (§6.3), but for **non-widget**
    methods and helper classes the rule is the general one: named params when there
    are > 3 params or when 2+ params share a type; **named params are forbidden for a
    single-parameter method** (`_restingShadow(shadows)`, not
    `_restingShadow(shadows: shadows)`).
16. **NEVER** — Use generic parameter names (`value1`, `value2`) — say
    `primaryValue`/`secondaryValue`, or better, what they actually mean.

---

## 7. Layout & responsive

1. **NEVER** — `MediaQuery.of(context).size` → use `MediaQuery.sizeOf(context)`
   (fewer rebuilds). The repo is currently **clean**.
2. **MUST** — Components adapt to the parent's constraints (`LayoutBuilder`), not to
   the screen size.
3. **MUST** — Breakpoints are defined in **exactly one place**:
   [`tokens/breakpoints.dart`](lib/src/tokens/breakpoints.dart)
   (`mobile=600, tablet=1024, desktop=1440`), consumed via `ScreenType` /
   `context.responsiveValue(...)` / `ResponsiveBuilder`. **NEVER** write
   `width > 600` in a component.
4. **NEVER** — Give a text container a fixed height. Text scaling must not cause
   overflow.
5. **NEVER** — Use `Expanded`/`Flexible` at a component's **root** (it forces the
   parent to be a Flex). Use an `expanded` flag plus
   `SizedBox(width: double.infinity)`, as `GHAppButton` does.

---

## 8. Accessibility

1. **MUST** — Minimum tap target of 48×48 logical px.
2. **MUST** — Icon-only controls must have a `Semantics(label: ...)` or a `tooltip`.
3. **MUST** — Text/background contrast ≥ 4.5:1 (≥ 3:1 for text ≥ 18pt), in **both**
   light and dark.
4. **MUST** — Verify rendering at `TextScaler.linear(2.0)` (use `TextScaler`;
   `textScaleFactor` is deprecated).
5. **MUST** — Interactive components must be focusable with a clear focus indicator.
6. **MUST** — Widget tests must assert a11y with `matchesSemantics` (see
   `test/components/buttons/app_button_test.dart`).
7. **SHOULD** — Prefer the built-in semantics of Material widgets
   (`FilledButton`/`OutlinedButton`/`TextButton`) over rebuilding them.
8. **SHOULD** — Respect `MediaQuery.disableAnimationsOf(context)` for non-essential
   animation.

---

## 9. Performance

1. **MUST** — `const` for every static widget / `EdgeInsets` / `TextStyle`.
2. **MUST** — Never create an `AnimationController` without `dispose()`. Same for
   `WidgetStatesController`, `FocusNode`, and `TextEditingController` **the component
   creates itself** (a controller passed in from outside is **not** disposed).
3. **SHOULD** — Wrap continuously animating regions (shimmer, loading, progress) in
   a `RepaintBoundary`.
4. **NEVER** — Heavy logic (sorting, parsing, complex formatting) in `build()`.
5. **NEVER** — Call `setState` inside `build`, or inside a listener/async callback
   without a `mounted` guard.
6. **SHOULD** — For lists: `ListView.builder` plus `itemExtent`/`prototypeItem` when
   items are uniform.
7. **NEVER** — Nest multiple `Opacity`/`ClipRRect` layers where `AnimatedOpacity` or
   `BoxDecoration(borderRadius:)` would do.

---

## 10. Material / Cupertino decoupling

Flutter 3.44 **froze** Material & Cupertino in the core SDK, in preparation for
splitting them into the `material_ui` / `cupertino_ui` packages.

1. **SHOULD** — Confine `import 'package:flutter/material.dart'` to as few files as
   possible; files that need no Material widget import
   `package:flutter/widgets.dart`. Current state: 42 files import `material.dart`, 6
   use `widgets.dart` — **reduce gradually**, no big-bang refactor.
2. **SHOULD** — Don't extend Material widgets directly. Wrap them (composition) so
   the implementation can later be swapped in one place.
3. **MUST** — If you wrap a Material widget (`InkWell`, `Material`, `Theme`), wrap it
   **inside** a UI Kit component; the app never uses it directly.
4. **SHOULD** — Track the `material_ui` 1.0 release and plan the migration.

---

## 11. Dart / code style

1. **MUST** — `flutter analyze` is clean on the changed files/folders; **fix errors
   first**. `analysis_options.yaml` enables `very_good_analysis` plus
   `strict-casts`/`strict-inference`/`strict-raw-types` and `public_member_api_docs`.
2. **MUST** — Max line length **180 characters** — see §16 for the full rule.
   Trailing commas on multi-line parameter lists.
3. **MUST** — **Do NOT run `dart format`**, code generation, or compile/run the code
   at the end of a change (per [CLAUDE.md](CLAUDE.md)). Format by hand to match the
   surrounding file.
4. **SHOULD** — Declare a public class `final class` when it isn't meant to be
   extended. The repo still has many plain `class` declarations — apply this to **new
   code**, don't sweep the whole codebase.
5. **MUST** — Primitive tokens are always `abstract final class` + `static const`.
6. **SHOULD** — Use `sealed class` for a closed variant set that needs an exhaustive
   `switch`.
7. **NEVER** — `dynamic`, gratuitous `!`, or `late` without a clear reason. For a
   nullable field use `?.` rather than guarding with `!= null` before the call; never
   chain `!` with `?` — assign to a `final` local and null-check that.
8. **MUST** — Rounded doubles carry `.0` (`12.0`, not `12`) — except a `switch`
   returning Finesse-spec integers that Dart coerces, where you match the surrounding
   file.
9. **SHOULD** — Don't assign an intermediate variable used only once — inline it.
   Exception: a local that shortens a long line or clarifies a complex ternary or
   `map`/`where` chain.
10. **NEVER** — Use lint suppressions (`// ignore:`), tricks, or hacks to dodge
    review. Constraints exist for codebase quality; if one blocks you, **discuss it**
    rather than working around it.

---

## 12. Testing — three tiers

| Tier       | Tool           | Covers                                                                          |
|------------|----------------|---------------------------------------------------------------------------------|
| **Unit**   | `flutter_test` | token values, theme → `ColorScheme`/`TextTheme`, `copyWith`/`lerp`, extensions   |
| **Widget** | `flutter_test` | render, tap, disabled/loading, icon hiding, **a11y (`matchesSemantics`)**, named-ctor→variant |
| **Golden** | **alchemist**  | a snapshot per variant × light/dark × size × state                              |

1. **MUST** — Every public component has at least: one render widget test, one
   interaction test (if it has a callback), one a11y assertion, and one light + dark
   golden test.
2. **MUST** — Test files mirror `lib/src/` under `test/`:
   `test/components/<group>/{name}_test.dart` + `{name}_golden_test.dart`.
3. **MUST** — Wrap widgets in `GHAppTheme.light()/dark()` via a `_wrap`/`_themed`
   helper so `context.*` resolves.
4. **MUST** — `test/flutter_test_config.dart` runs automatically before every test
   and enables **CI goldens only** (platform goldens off) for pixel-stable, low-flake
   results. Do not bypass it.
5. **MUST** — Goldens for infinite animations (spinner, shimmer) use
   `pumpBeforeTest: pumpOnce` — **NEVER** `pumpAndSettle` (it hangs).
6. **MUST** — Golden images live in `test/components/<group>/goldens/ci/`. Updating
   goldens is a **manual, reviewed** action: `flutter test --update-goldens`. **NEVER**
   run `--update-goldens` unless the user explicitly asks and the UI change is
   intentional. CI only verifies.
7. **NEVER** — Commit or hand-edit `failures/` directories (diff artifacts).
8. **MUST** — Test public behaviour, not private/implementation details.
9. **SHOULD** — Cover these states with goldens: default / hover / focused / pressed
   / disabled / loading.
10. **SHOULD** — Component coverage ≥ 80% (excluding generated files).
11. **SHOULD** — Cover the two a11y/robustness cases §8.4 and §14 require but that
    **no test currently exercises** — the whole suite has zero `TextScaler` usage.
    Add them for new components, and to existing ones when you touch their tests:
    ```dart
    // text scale 2.0 — must not overflow
    await tester.pumpWidget(_wrap(
      const GHAppButton(label: 'Save'),
      textScaler: const TextScaler.linear(2.0),
    ));
    expect(tester.takeException(), isNull);

    // narrow constraint (320px) — the smallest supported width
    await tester.pumpWidget(_wrap(const SizedBox(width: 320.0, child: …)));
    ```
    Use `TextScaler`, never the deprecated `textScaleFactor`. Keep these out of the
    golden suite — assert no-overflow in widget tests instead, so you don't multiply
    golden images per scale factor.

---

## 13. Documentation & versioning

1. **MUST** — **Every** public class and public member has a `///` dartdoc — the
   `public_member_api_docs` lint is on and the pub.dev score depends on it. Reference
   density: [`app_button.dart`](lib/src/components/buttons/app_button.dart).
   - Class doc: what it is, which variants/sizes/states it supports, a ```dart```
     usage block, and behavioural notes (disabled/loading semantics).
   - Each field: one line; note interactions ("Hidden while [isLoading].").
   - Use `[SquareBracket]` references to link related symbols.
2. **MUST** — Export every new public symbol in `lib/ngh09_ui_kit.dart`,
   **alphabetically within its comment-grouped section** (Components / Foundation
   semantic / Foundation tokens / Utilities). The barrel is the **only public
   surface** — never tell a consumer to import from `src/`.
3. **MUST** — New components should be showcased in the demo
   [`example/lib/main.dart`](example/lib/main.dart).
4. **MUST** — Semver: changing/removing a param or changing default behaviour is
   **major**. Adding a param with a default is **minor**.
5. **MUST** — Don't delete an API immediately. Use
   `@Deprecated('Use X instead. Will be removed in v1.0.0')` and keep it for at least
   one minor version.
6. **MUST** — Update [CHANGELOG.md](CHANGELOG.md) in the same PR.
7. **NEVER** — Hand-edit generated files (`*.g.dart`, `*.freezed.dart`).

---

## 14. Definition of Done for a component

Mirrors [CLAUDE.md](CLAUDE.md) and [PLAN.md](PLAN.md) §"Done". A component is done
only when **all** of these hold:

- [ ] Variant/size enum in its own file (no bare `String`)
- [ ] No hardcoded color / spacing / radius / duration (outside a commented
      Finesse-spec `switch`)
- [ ] Token-driven: reads only `context.*`; correct in both light and dark
- [ ] `const` constructor plus a named constructor per variant, `final` fields,
      `super.key` last
- [ ] Disabled = `onPressed == null`
- [ ] Constructor invariants asserted with messages (§18); required collections
      non-empty-asserted and never mutated (§19)
- [ ] No `Widget`-returning method — private `_SubWidget` instead (§20.1)
- [ ] No user-facing string default (§21)
- [ ] Tap target ≥ 48×48, semantics label on icon-only controls
- [ ] Correct at text scale 2.0 and under a narrow constraint (320px), with tests
      that actually assert it (§12.11)
- [ ] Complete `///` dartdoc on the class and every public member
- [ ] Exported from `lib/ngh09_ui_kit.dart` (right section, right alphabetical spot)
- [ ] Widget test (render + interaction + a11y) and light/dark golden test pass
- [ ] `flutter analyze` clean on the changed files
- [ ] CHANGELOG updated; (recommended) showcased in `example/lib/main.dart`

---

## 15. Deviations from the generic rule template

Recorded so nobody later "fixes" this file back toward the template:

| Generic template                       | `ngh09_ui_kit` (actual)                                                      |
|----------------------------------------|------------------------------------------------------------------------------|
| `src/foundations/`                     | `src/tokens/` (primitive) + `src/theme/` (semantic); `foundations/` is empty  |
| Barrel `ui_kit.dart`                   | `lib/ngh09_ui_kit.dart`                                                      |
| Style split into `*_style.dart`         | private `switch` getters inside the widget file                              |
| Every public type prefixed `GH`         | Widgets: required. Tokens: `{Kind}Tokens` (deliberate). Existing enums: unchanged |
| All widget files `gh_*.dart`            | the older `app_*.dart` set stays; new code uses `gh_*.dart`                  |
| Spacing `xs=4 … xxl=48`                 | adds `none=0, xxs=2, smd=12, xxxl=64`                                        |
| `dart format` + `--fatal-infos`         | **No** format run; `flutter analyze` on changed files                        |
| Widgetbook catalog                     | `example/lib/main.dart`, a single screen                                     |
| Goldens in `test/.../goldens/`          | `test/components/<group>/goldens/ci/` (CI goldens only)                       |
| `flutter_lints`                        | `very_good_analysis` + strict casts/inference/raw-types                      |
| Files > 300 lines must be split         | exempts data-catalog files (`gh_icons`, `gh_company`, `gh_country`)          |
| Prefer `void Function(...)` callbacks   | `VoidCallback` / `ValueChanged<T>` — the Flutter idiom, 32 uses vs 0 (§6.14) |
| Barrel/relative imports, `mapNotNull`   | absolute `package:` imports (§2.4); no collection-extension utils (§19.7)     |

---

## 16. Line length — 180 characters

`analysis_options.yaml` sets `lines_longer_than_80_chars: ignore`, so **180 is a
project convention the analyzer does not enforce**. Nothing fails the build if you
exceed it — respecting it is on you and the reviewer.

1. **MUST** — Max **180 characters** per line in `lib/` and `test/`. Current state:
   **0 lines exceed it**; the longest line in `lib/src` is 159 characters
   ([gh_breadcrumbs.dart:39](lib/src/components/navigation/gh_breadcrumbs.dart#L39)).
   Keep that record clean — a new over-180 line is a review comment, not a nit.
2. **MUST** — Count **characters, not bytes.** Box-drawing (`─`), `×`, `≥`, and
   emoji are multi-byte in UTF-8, so byte-based tooling (`awk 'length>180'`,
   `wc -L`) over-reports and will send you chasing lines that are actually fine. A
   correct check:
   ```bash
   # flags real violations in lib/ and test/
   python3 -c "
   import glob,sys
   for p in ('lib','test'):
       for f in glob.glob(p+'/**/*.dart', recursive=True):
           for i,l in enumerate(open(f,encoding='utf-8'),1):
               if len(l.rstrip(chr(10)))>180: print(f'{f}:{i}')
   "
   ```
3. **MUST** — 180 is a **ceiling, not a target.** Most of the codebase sits far
   below it (only ~100 lines exceed even 120). Don't collapse a readable multi-line
   widget tree onto one long line just because it fits — the budget exists for the
   cases in rule 4, not as licence to write dense code.
4. **SHOULD** — Spend the long-line budget on things that genuinely read better
   unbroken: a `switch` expression arm mapping variant → token, a single-expression
   getter, or a `WidgetStateProperty.resolveWith` line. Break instead when the line
   holds two or more independent ideas.
5. **MUST** — Never satisfy 180 by deleting a needed `///` doc, inlining a name into
   something cryptic, or adding a `// ignore:`. If a line can't fit without hurting
   clarity, restructure it — extract a private getter or a `_SubWidget`.
6. **MUST** — Since `dart format` is **not** run in this project (§11.3), line
   breaking is manual. Match the wrapping style of the surrounding file: one argument
   per line with a trailing comma once a call goes multi-line.

---

## 17. Comments & generated code

### Comment style

1. **MUST** — Public API documentation uses `///` dartdoc, never `//` (§13.1). Use
   `//` only for **implementation notes aimed at maintainers**.
2. **SHOULD** — Wrap `///` doc text at **~80 characters** even though code may run to
   180. Docs are read as prose and rendered on pub.dev, where narrow lines read
   better. Current state: of 2,723 `///` lines, only 6 exceed 80.
3. **SHOULD** — Group members inside a large widget with **section banner comments**,
   the established pattern in
   [`app_button.dart`](lib/src/components/buttons/app_button.dart):
   ```dart
   // ── Shape ──────────────────────────────────────────────────────────────────
   ```
   Pad the trailing `─` run so the whole line is **exactly 80 characters** — 46 of
   the 54 banners in `lib/src` already are. Banners mark concerns (`Design tokens`,
   `Shape`, `ButtonStyle`, `Build`), and `Build` goes last.
4. **MUST** — Comments explain **why**, not **what**. A comment restating the code is
   noise; delete it.
   ```dart
   // ❌ // set the padding
   // ✅ // Finesse spec: 18px icon in a 40px tap target — not on the shared scale.
   ```
5. **MUST** — Every inline numeric literal permitted by §4.8 carries a comment naming
   its source (the Finesse spec), so a later reader doesn't mistake it for a magic
   number.
6. **NEVER** — Leave commented-out code, `TODO` without an owner/issue reference, or
   a stale comment describing behaviour that has since changed. A wrong comment is
   worse than none.
7. **NEVER** — Use `// ignore:` / `// ignore_for_file:` to silence a lint (§11.10).
8. **SHOULD** — Write comments in **English**, matching the codebase and these docs,
   since the package is published publicly on pub.dev.

### Generated code

This project currently has **no** generated Dart files — no `*.g.dart`, no
`*.freezed.dart`, no build_runner in `dev_dependencies`. The rules below govern what
happens if that changes.

9. **NEVER** — Hand-edit a generated file (`*.g.dart`, `*.freezed.dart`). Change the
   source annotation/template and regenerate instead.
10. **NEVER** — Run code generation as part of a routine change (§11.3). If a task
    genuinely needs it, say so and let the user run it.
11. **MUST** — Generated files stay excluded from analysis; the `**/*.g.dart` and
    `**/*.freezed.dart` entries in `analysis_options.yaml` must be preserved when that
    file is edited.
12. **MUST** — Generated files are excluded from the ≥ 80% coverage target (§12.10).
13. **SHOULD** — Think hard before adding a codegen dependency at all. It costs every
    consumer build time, and a UI kit's value is in staying dependency-light (§1.6).
    Raise it for discussion rather than introducing it unilaterally.
14. **NEVER** — Commit or hand-edit golden `failures/` artifacts (§12.7) — they are
    generated diff output, not source.

---

## 18. Constructor asserts (invariants)

The codebase has a strong, consistent convention here — **27 asserts across 16
component files, every one carrying a message.** It was undocumented until now.

1. **MUST** — Validate constructor invariants with `assert`, and **always give it a
   message**. A bare `assert(x > 0)` tells the consumer nothing at 2am.
   ```dart
   }) : assert(max > 0, 'GHProgressBar needs a positive max.'),
        assert(value >= 0 && value <= max, 'value must be within [0, max].');
   ```
2. **MUST** — Message style: name the widget when the invariant is about the widget as
   a whole (`'GHPagination needs at least one page.'`), name the parameter when it's
   about one argument (`'currentPage must be within [1, totalPages].'`). End with a
   period. Ranges read as `[min, max]`.
3. **SHOULD** — Assert the invariants this codebase already covers, so new components
   match: a **non-empty** required collection (`assert(items.isNotEmpty, …)`), a
   **minimum count** where the widget is meaningless below it
   (`assert(segments.length >= 2, …)`), an **index in bounds** against the collection
   it indexes, a **numeric range** (`value` within `[0, max]`), and **at least one of
   two optional slots** (`assert(label != null || icon != null, 'Provide a label, an
   icon, or both.')`).
4. **MUST** — A class with an `assert` in its initializer list **cannot** stay `const`
   in every position, so it loses the `const` constructor. That trade is accepted
   where it already exists (`GHBreadcrumbs`, `GHAppDropdown`, `GHPagination`) — a
   caught bug beats a const literal. Don't drop a needed assert to win back `const`.
5. **NEVER** — Use `assert` to validate *runtime* data that legitimately varies (an
   empty list from an API is a UI state, not a programmer error). Asserts are compiled
   out in release; they encode **programmer** contracts only. Render an empty/error
   state instead.
6. **SHOULD** — Document the invariant in the member's `///` doc as well as asserting
   it. The assert fires in debug; the doc is what the consumer reads first.

---

## 19. Collections in public APIs

Eight components take a `List` prop (`items`, `segments`, `steps`, `sections`,
`layers`). Today none defensively copies and none exposes an unmodifiable view.

1. **MUST** — Never mutate a collection passed in through the constructor. The caller
   owns it; a widget that sorts or adds to it corrupts caller state.
2. **SHOULD** — When a component needs sorted/filtered/normalized data, derive a new
   local list (`List.of(items)..sort(...)`) rather than mutating the parameter.
3. **SHOULD** — Prefer `List<T>` over `Iterable<T>` for public props. `List` is what
   the UI actually needs — `.length`, indexed access, repeated traversal — and a lazy
   `Iterable` re-evaluates on every rebuild. The repo currently uses `List`
   exclusively; keep it that way.
4. **MUST** — Normalize before rendering: transform the raw input into the final
   renderable list once, then render from it. Don't scatter `.where(...)` /
   null-filtering through the widget tree, and don't base fallback logic ("is it
   empty?") on the raw input when it's the normalized output that gets rendered.
5. **SHOULD** — Pair a required collection with an `assert` per §18.3, so the failure
   surfaces at the call site rather than as a confusing empty render.
6. **MUST** — A `List` prop is not `const`-safe to default. Prefer `required` (the
   current convention across all eight) over `this.items = const []`, so an empty list
   is a deliberate caller choice, never an accidental default.
7. **SHOULD** — Filter nulls with `.whereType<T>()`, not `.where((e) => e != null)` —
   the latter leaves the element type nullable, forcing a `!` downstream. The repo is
   currently clean of both; keep it that way.
   ```dart
   // ❌ leaves List<T?>, forces ! later
   items.where((e) => e != null).map((e) => e!.label)
   // ✅ narrows the type
   items.whereType<GHBreadcrumbItem>().map((e) => e.label)
   ```
   This package deliberately ships **no** collection-extension utilities (`mapNotNull`,
   `whereNotNull`) — those belong to an app, and a UI kit shouldn't export general Dart
   helpers from its public API (§1.6). Use the SDK methods.
8. **MUST** — If UI logic needs `.length`, indexed access, or repeated traversal,
   materialize with `.toList()` — never iterate a lazy `Iterable` twice in a `build()`.

---

## 20. Widget composition

1. **NEVER** — Write a function or method that returns a `Widget`. Extract a private
   `_SubWidget` class instead. This is already §6.12 for local functions, but it
   applies equally to **private methods**: a `Widget _buildX()` method rebuilds
   unconditionally with its parent and can't be `const`, while a `_SubWidget` gets its
   own element and can skip rebuilds.
   Current state: **6 such methods remain** — in
   [gh_progress_bar.dart:100](lib/src/components/progress/gh_progress_bar.dart#L100),
   [gh_progress_stepper.dart:92](lib/src/components/progress/gh_progress_stepper.dart#L92),
   [gh_user_avatar.dart:173](lib/src/components/avatars/gh_user_avatar.dart#L173),
   [gh_app_range_slider.dart:141](lib/src/components/inputs/gh_app_range_slider.dart#L141),
   [gh_app_dropdown_button.dart:128](lib/src/components/inputs/gh_app_dropdown_button.dart#L128),
   and [gh_app_input_dropdown.dart:141](lib/src/components/inputs/gh_app_input_dropdown.dart#L141).
   Convert one when you're already editing that file — don't open a dedicated
   refactor PR. New code must not add a seventh.
   > A method returning a small `switch` over tokens (e.g. `_buildStatusIndicator`) is
   > the borderline case; converting it is optional if it stays under a few lines and
   > returns leaf widgets.
2. **SHOULD** — Prefer the specific box over `Container`: `DecoratedBox`
   (decoration only), `Padding` (padding only), `SizedBox` (sizing only), `ColoredBox`
   (background only). `Container` bundles all of them, which obscures intent and often
   blocks `const`.
   **But** don't sweep the existing code: of 37 `Container` uses, **35 genuinely set 2+
   properties** and are correct as-is. Only reach for the specific box when the
   `Container` does exactly one thing.
3. **MUST** — No `Scaffold`, `MaterialApp`, or `SafeArea` inside a component (§6.8),
   and no `Expanded`/`Flexible` at the root (§7.5).
4. **SHOULD** — Wrap a sub-widget in its own `const` constructor wherever the props
   allow, so a parent rebuild doesn't propagate.

---

## 21. Default strings — a known deviation

§1.3 forbids user-facing strings inside components, because the app owns i18n. Two
components currently violate it with English defaults:

| Component | Param | Default |
|-----------|-------|---------|
| [`GHAppDropdownButton`](lib/src/components/inputs/gh_app_dropdown_button.dart#L43) | `placeholder` | `'Select'` |
| [`GHAppInputDropdown`](lib/src/components/inputs/gh_app_input_dropdown.dart#L41) | `placeholder` | `'Search'` |

1. **NEVER** — Add a new user-facing string default to a component. Make the param
   `required`, or default it to `null` and render nothing.
2. **SHOULD** — When these two are next touched, migrate toward a `required`
   placeholder. That is a **breaking change** (§13.4), so it belongs in a major
   release with a `@Deprecated` transition — not a drive-by edit.
3. **MUST** — Never hardcode a string inside `build()` where the consumer cannot
   override it at all. A defaultable constructor param is a wart; an unreachable
   literal is a defect.
