# Widget Guide — `ngh09_ui_kit`

## Overview

This guide is a **discovery entrypoint** for the kit's public `GH*` widgets. Use it
to find out _what already exists_ before building a screen or a new component, then
inspect the widget's own source and doc comments for the exact API.

Every public widget lives under `lib/src/components/<group>/` and is re-exported
from the single barrel [lib/ngh09_ui_kit.dart](lib/ngh09_ui_kit.dart). Consumers
import **only** the barrel:

```dart
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
```

This file owns shared-widget discovery and usage lookup. For the token→theme→widget
architecture and how to add a component, see [ARCHITECTURE.md](ARCHITECTURE.md). For
naming, ordering, and validation, see [CLAUDE.md](CLAUDE.md). For component status
and the roadmap, see [PLAN.md](PLAN.md).

## Quick Reference

- Start from the inventory below, then open the widget file for its real API.
- Reuse an existing `GH*` widget and its variants before building anything custom.
- Widgets read **all** styling from `context.*` — never pass hardcoded colors,
  spacing, or radii into them (see [CLAUDE.md](CLAUDE.md) — The Golden Rule).
- Select a variant/size by its **enum**, never a `String`.
- If a needed widget or role is missing, it's a gap to fill in the kit (a new
  component, or a new role on the semantic layer) — not to work around.

## How to Use This Guide

When building UI:

1. Find a likely widget category in the inventory.
2. Open the widget's file under `lib/src/components/<group>/` and read its `///`
   docs and named constructors — those are the source of truth for its API.
3. Look at the matching playground in
   [example/lib/explorer/](example/lib/explorer/) for a live, wired usage.
4. Reuse an established variant/size before adding a new one.
5. Only create a new primitive when no existing `GH*` widget fits — and then follow
   the component flow in [ARCHITECTURE.md](ARCHITECTURE.md) §2.

## Widget Inventory

Use this as a starting point, then inspect the file. Variant/size options are the
real enums exported from the barrel.

| Category    | Widget(s)                                               | Key variants / sizes                                                                                                                                                                       | File group               |
| ----------- | ------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------ |
| Buttons     | `GHAppButton`                                           | `ButtonVariant` (filled · tonal · secondaryGrey · outlined · text), `ButtonSize`. Named ctors `.filled/.tonal/.secondaryGrey/.outlined/.text`; `isLoading`, `expanded`, `leading/trailing` | `components/buttons/`    |
| Icon button | `GHAppIconButton`                                       | `IconButtonSize` (xxs → xxl, 7 sizes), `IconButtonCorner` (sharp · smooth)                                                                                                                 | `components/buttons/`    |
| Badges      | `GHAppBadge`                                            | `BadgeColor` (primary · error · warning), `BadgeSize` (small · medium · large), `BadgeCorner` (sharp · smooth); dot & icon                                                                 | `components/display/`    |
| Chips       | `GHAppChip`                                             | `ChipVariant` (input · filter · choice), `ChipSize` (small · medium)                                                                                                                       | `components/display/`    |
| Avatars     | `GHUserAvatar`                                          | `GHAvatarVariant` (v01–v13), `GHAvatarSize` (xs · sm · md · lg · xl), status & verified badge                                                                                              | `components/avatars/`    |
| Alerts      | `GHAppAlert`                                            | `GHAlertState` (active · error · warning · success)                                                                                                                                        | `components/feedback/`   |
| Snackbars   | `GHSnackbar`                                            | `GHSnackbarState` (active · error · warning · success); optional CTA                                                                                                                       | `components/feedback/`   |
| Tooltips    | `GHTooltip`                                             | `TooltipSize` (small · medium · large), `TooltipArrow`, `TooltipCorner`                                                                                                                    | `components/feedback/`   |
| Checkbox    | `GHAppCheckbox`                                         | `CheckboxSize` (3 sizes); checked & disabled                                                                                                                                               | `components/inputs/`     |
| Radio       | `GHAppRadio`                                            | `RadioSize` (3 sizes); checked & disabled                                                                                                                                                  | `components/inputs/`     |
| Toggle      | `GHAppToggle`                                           | `ToggleSize` (3 sizes); on/off & disabled                                                                                                                                                  | `components/inputs/`     |
| Slider      | `GHAppSlider`, `GHAppRangeSlider`                       | `SliderIndicator`; single & dual-handle                                                                                                                                                    | `components/inputs/`     |
| Text input  | `GHAppTextField`, `GHAppTextArea`                       | status, obscure, leading icon; min/max lines (area)                                                                                                                                        | `components/inputs/`     |
| Dropdown    | `GHAppDropdown`, `GHAppInputDropdown`                   | `DropdownItemSize`, `DropdownLeadingType`, `DropdownTrailingType`; searchable (input)                                                                                                      | `components/inputs/`     |
| Segmented   | `GHAppSegmentedControl` (`GHSegmentedControlItem`)      | 2–4 segments · label & icon · `SegmentedControlCorner`                                                                                                                                     | `components/navigation/` |
| Breadcrumbs | `GHBreadcrumbs` (`GHBreadcrumbItem`, `GHCrumb`)         | `BreadcrumbType` (textAndIcon · onlyText · onlyIcon); auto-collapse                                                                                                                        | `components/navigation/` |
| Pagination  | `GHPagination`                                          | `PaginationType` (numbered · simple)                                                                                                                                                       | `components/navigation/` |
| Progress    | `GHProgressBar`, `GHProgressStepper` (`GHProgressStep`) | `GHProgressBarIndicator` (none · labelAndValue · valueOnly), `GHProgressStepIndicator` (chip · number · icon)                                                                              | `components/progress/`   |
| Flags       | `GHCountryFlag` (`GHCountry`)                           | 215 countries · searchable                                                                                                                                                                 | `components/flags/`      |
| Icons       | `GHHeroIcon` (`GHIcons`, `GHIconData`)                  | 293 Heroicons · `HeroiconStyle` (mini · outline · solid)                                                                                                                                   | `components/icons/`      |
| Logos       | `GHCompanyLogo` (`GHCompany`, `GHLogoLayer`)            | 137 companies · searchable                                                                                                                                                                 | `components/logos/`      |
| Payment     | `GHPaymentIcon` (`GHPaymentMethod`)                     | cards & wallets · `GHPaymentIconSize`                                                                                                                                                      | `components/payment/`    |

> The demo app [example/](example/) has a playground screen for nearly every row
> above — the fastest way to see a widget wired to all its options.

## Foundation — reading tokens

Widgets never take raw style values; they read the **semantic layer** through
`context.*` extensions (from `utils/context_extensions.dart`):

| Extension            | Returns           | Use for                                        |
| -------------------- | ----------------- | ---------------------------------------------- |
| `context.colors`     | `GHAppColors`     | `primary`, `surface`, `onSurface`, `danger`, … |
| `context.spacing`    | `GHAppSpacing`    | `xs`, `sm`, `md`, `lg`, … gaps & padding       |
| `context.radii`      | `GHAppRadii`      | corner radii (`borderRadiusMd`, …)             |
| `context.textStyles` | `GHAppTypography` | `display`, `headlineSmall`, `bodySmall`, …     |
| `context.shadows`    | `GHAppShadows`    | elevation & focus shadows                      |
| `context.isDarkMode` | `bool`            | branching on theme brightness                  |

For responsive layout use `context.isMobile/isTablet/isDesktop`,
`context.responsiveValue(mobile:, tablet:, desktop:)`, or the `ResponsiveBuilder`
widget (from `utils/responsive.dart`).

## Common Composition Patterns

### Theme host

Every screen (and every test/demo) must sit under a `GHAppTheme` so `context.*`
resolves:

```dart
MaterialApp(
  theme: GHAppTheme.light(),
  darkTheme: GHAppTheme.dark(),
  // ...
);
```

### Variant selection by enum, styling from context

```dart
GHAppButton.filled(
  label: 'Continue',
  size: ButtonSize.medium,      // enum, not a String
  isLoading: state.isSubmitting,
  expanded: true,
  onPressed: _submit,           // null onPressed == disabled
);
```

Inside a component, map the variant/size to a token with a `switch` expression
(see `_foregroundColor` / `_padding` in
[lib/src/components/buttons/app_button.dart](lib/src/components/buttons/app_button.dart)) —
never inline a color or a magic number.

### Gaps and padding from the spacing scale

```dart
Padding(
  padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
  child: Column(
    children: [
      const GHAppTextField(/* ... */),
      SizedBox(height: context.spacing.sm),
      GHAppButton.filled(label: 'Save', onPressed: _save),
    ],
  ),
);
```

## Widget Constraints

- **No hardcoded style values in widgets.** Colors, spacing, radii, durations, and
  text styles come from `context.*`. If a role is missing, add it to the semantic
  layer under `lib/src/theme/` — do not reach into `lib/src/tokens/`.
- **No `String` variants.** Every variant/size is an enum in its own
  `*_variant.dart` / `*_size.dart` file (see [CLAUDE.md](CLAUDE.md) — Naming).
- **Barrel is the only public surface.** Never tell a consumer to import from
  `src/`; any new public widget must be exported from
  [lib/ngh09_ui_kit.dart](lib/ngh09_ui_kit.dart) (alphabetical in its section).
- **Avoid functions returning widgets** — extract a private `_SubWidget` (see
  `_ButtonContent` in `app_button.dart`).
- **Preserve footprint across states** — e.g. loading keeps the label so layout
  doesn't jump.
- **Respect a11y** — rely on the underlying Material semantics; verify with
  `matchesSemantics` in widget tests.

## Lookup Rules

- Prefer an existing `GH*` widget and its variants before building a custom
  equivalent.
- Read the widget's `///` docs and named constructors for its real API — this guide
  is a map, not the full reference.
- Follow the pattern of the nearest existing playground/screen when several widgets
  could fit.
- Keep app-specific behavior in the consuming app; only genuinely reusable behavior
  belongs in a shared `GH*` primitive.

## When to Reference This File

**Use WIDGET_GUIDE.md when:**

- Building a screen and looking for an existing widget to reuse
- Choosing between widget categories / variants
- Finding where to inspect a widget's real usage (playgrounds)

**Do NOT use for:**

- The full API of any single widget (read its file + `///` docs)
- Architecture and the component-authoring flow (see [ARCHITECTURE.md](ARCHITECTURE.md))
- Code conventions and validation (see [CLAUDE.md](CLAUDE.md))
- Component status / roadmap (see [PLAN.md](PLAN.md))
