import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

void main() {
  group('AppTheme', () {
    test('light theme attaches all semantic extensions', () {
      final theme = AppTheme.light();
      expect(theme.extension<AppColors>(), isNotNull);
      expect(theme.extension<AppSpacing>(), isNotNull);
      expect(theme.extension<AppRadii>(), isNotNull);
      expect(theme.extension<AppTypography>(), isNotNull);
      expect(theme.brightness, Brightness.light);
    });

    test('dark theme uses the dark color set', () {
      final theme = AppTheme.dark();
      expect(theme.brightness, Brightness.dark);
      expect(theme.extension<AppColors>()!.background, ColorTokens.black);
    });
  });

  testWidgets('context accessors resolve theme extensions', (tester) async {
    late AppSpacing spacing;
    late AppColors colors;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) {
            spacing = context.spacing;
            colors = context.colors;
            return const SizedBox();
          },
        ),
      ),
    );

    expect(spacing.md, SpacingTokens.md);
    expect(colors.background, ColorTokens.white);
  });
}
