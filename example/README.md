# ngh09_ui_kit_example

Minimal example for [`ngh09_ui_kit`](../) — a single screen that themes a
`MaterialApp` with `GHAppTheme.light()` / `GHAppTheme.dark()` and composes the
kit's `GH*` widgets (buttons, badges, chips, avatars, inputs, alerts).

Because every widget reads its colors, spacing, radii and type from the
semantic theme layer, the ☀/☾ app-bar toggle re-styles the whole screen with no
per-widget changes.

## Run

```sh
cd example
flutter run
```

See [`lib/main.dart`](lib/main.dart) for the whole example.
