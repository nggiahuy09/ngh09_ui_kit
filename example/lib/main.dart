import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

void main() => runApp(const ExampleApp());

/// Minimal example demonstrating the ngh09_ui_kit theme and tokens.
class ExampleApp extends StatelessWidget {
  /// Creates the example app.
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ngh09_ui_kit example',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(title: const Text('ngh09_ui_kit')),
      body: Padding(
        padding: EdgeInsets.all(context.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Display', style: context.textStyles.display),
            SizedBox(height: context.spacing.sm),
            Text('Title', style: context.textStyles.title),
            SizedBox(height: context.spacing.sm),
            Text('Body text', style: context.textStyles.body),
          ],
        ),
      ),
    );
  }
}
