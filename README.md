# ngh09_ui_kit

A Material 3 based Flutter **UI kit & design system**: design tokens, a semantic
theme layer built on `ThemeExtension`, themeable components, and a Widgetbook
catalog.

## Features

- **Two-tier design tokens** — primitive tokens (`ColorTokens`, `SpacingTokens`, …)
  mapped to a semantic layer (`AppColors`, `AppSpacing`, …) so re-theming touches
  one place.
- **Material 3** — light & dark `ThemeData` via `AppTheme.light()` / `AppTheme.dark()`.
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
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
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

See the [`example/`](example/) app for a runnable demo and `PLAN.md` for the
full architecture and roadmap.

## Development

```bash
flutter pub get
dart format .
flutter analyze
flutter test
```

## License

MIT — see [LICENSE](LICENSE).
