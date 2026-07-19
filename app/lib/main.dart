import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_app/explorer/explorer_home_screen.dart';

void main() => runApp(const ExampleApp());

/// Design System Explorer: a navigable showcase of the ngh09_ui_kit's
/// components (Buttons, Badges, Chips) and foundation tokens (Colors,
/// Typography, Spacing, Radii), built entirely on the kit's real widgets and
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
      title: 'ngh09 UI Kit',
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
