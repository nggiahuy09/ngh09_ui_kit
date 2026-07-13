import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/home_screen.dart';

void main() => runApp(const ExampleApp());

/// Design System Explorer: a navigable showcase of the ngh09_ui_kit's
/// components (buttons, inputs, navigation, feedback, media and more) and
/// foundation tokens (colors, typography, spacing, radii, shadows,
/// breakpoints, durations), built entirely on the kit's real widgets and
/// theme layer.
class ExampleApp extends StatefulWidget {
  /// Creates the example app.
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() => _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GH09 UI Kit',
      theme: GHAppTheme.light(),
      darkTheme: GHAppTheme.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: ExplorerHomeScreen(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}
