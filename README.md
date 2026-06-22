# ngh09_ui_kit

A Material 3 based Flutter **UI kit & design system**: design tokens, a semantic
theme layer built on `ThemeExtension`, themeable components, and a Widgetbook
catalog.

## Features

- **Two-tier design tokens** — primitive tokens (`ColorTokens`, `SpacingTokens`, …)
  mapped to a semantic layer (`GHAppColors`, `GHAppSpacing`, …) so re-theming touches
  one place.
- **Material 3** — light & dark `ThemeData` via `GHAppTheme.light()` / `GHAppTheme.dark()`.
- **Ergonomic access** — read tokens with `context.colors`, `context.spacing`,
  `context.radii`, `context.textStyles`.
- Components are added incrementally (see the roadmap in `PLAN.md`).

## Getting started

Add the dependency:

```yaml
dependencies:
  ngh09_ui_kit: ^0.1.0
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GHAppTheme.light(),
      darkTheme: GHAppTheme.dark(),
      home: Builder(
        builder: (context) => Scaffold(
          backgroundColor: context.colors.background,
          body: Center(
            child: Text('Hello', style: context.textStyles.display),
          ),
        ),
      ),
    );
  }
}
```

See the [`example/`](example/) app for a runnable demo, [ARCHITECTURE.md](ARCHITECTURE.md)
for how the kit is structured and how to add/test a component, and [PLAN.md](PLAN.md)
for the full roadmap.

## Development

```bash
flutter pub get
dart format .
flutter analyze
flutter test
```

## License

MIT — see [LICENSE](LICENSE).
