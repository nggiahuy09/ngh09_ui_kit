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
      expect(theme.useMaterial3, isTrue);
    });

    test('dark theme uses the dark color set', () {
      final theme = AppTheme.dark();
      expect(theme.brightness, Brightness.dark);
      expect(
        theme.extension<AppColors>()!.background,
        ColorTokens.neutral900,
      );
    });

    test('projects semantic colors onto the Material ColorScheme', () {
      final theme = AppTheme.light();
      final colors = theme.extension<AppColors>()!;
      expect(theme.colorScheme.primary, colors.primary);
      expect(theme.colorScheme.surface, colors.surface);
      expect(theme.colorScheme.error, colors.danger);
      expect(theme.scaffoldBackgroundColor, colors.background);
    });

    test('projects semantic typography onto the Material TextTheme', () {
      final theme = AppTheme.light();
      final typography = theme.extension<AppTypography>()!;
      // ThemeData merges defaults (color, family) onto the styles, so compare
      // the metrics the kit actually controls rather than identity.
      expect(
        theme.textTheme.bodyMedium!.fontSize,
        typography.bodyMedium.fontSize,
      );
      expect(
        theme.textTheme.bodyMedium!.fontWeight,
        typography.bodyMedium.fontWeight,
      );
      expect(
        theme.textTheme.titleLarge!.fontSize,
        typography.titleLarge.fontSize,
      );
    });

    test('accepts a custom color set for branding', () {
      const branded = AppColors.light();
      final custom = branded.copyWith(primary: const Color(0xFF00FF00));
      final theme = AppTheme.light(colors: custom);
      expect(theme.extension<AppColors>()!.primary, const Color(0xFF00FF00));
      expect(theme.colorScheme.primary, const Color(0xFF00FF00));
    });
  });

  group('AppColors', () {
    test('light and dark sets carry the correct brightness', () {
      expect(const AppColors.light().brightness, Brightness.light);
      expect(const AppColors.dark().brightness, Brightness.dark);
    });

    test('toColorScheme maps semantic roles', () {
      const colors = AppColors.light();
      final scheme = colors.toColorScheme();
      expect(scheme.brightness, Brightness.light);
      expect(scheme.primary, colors.primary);
      expect(scheme.onPrimary, colors.onPrimary);
      expect(scheme.outline, colors.outline);
    });

    test('lerp returns the endpoints at t=0 and t=1', () {
      const a = AppColors.light();
      const b = AppColors.dark();
      expect(a.lerp(b, 0).background, a.background);
      expect(a.lerp(b, 1).background, b.background);
    });

    test('copyWith overrides only the given roles', () {
      const base = AppColors.light();
      final next = base.copyWith(danger: const Color(0xFF112233));
      expect(next.danger, const Color(0xFF112233));
      expect(next.primary, base.primary);
    });
  });

  group('Token scales', () {
    test('spacing follows a 4pt-based progression', () {
      expect(SpacingTokens.xs, 4);
      expect(SpacingTokens.sm, 8);
      expect(SpacingTokens.md, 16);
      expect(SpacingTokens.lg, 24);
      expect(SpacingTokens.xl, 32);
      expect(SpacingTokens.xxl, 48);
    });

    test('AppSpacing.standard mirrors the primitive tokens', () {
      const s = AppSpacing.standard();
      expect(s.xs, SpacingTokens.xs);
      expect(s.md, SpacingTokens.md);
      expect(s.xxl, SpacingTokens.xxl);
    });

    test('AppRadii exposes BorderRadius getters', () {
      const r = AppRadii.standard();
      expect(r.borderRadiusMd, BorderRadius.circular(RadiusTokens.md));
      expect(r.borderRadiusFull, BorderRadius.circular(RadiusTokens.full));
    });
  });

  group('ScreenType', () {
    test('maps widths to the correct size class', () {
      expect(ScreenType.fromWidth(320), ScreenType.mobile);
      expect(ScreenType.fromWidth(800), ScreenType.tablet);
      expect(ScreenType.fromWidth(1500), ScreenType.desktop);
    });

    test('boundaries are inclusive on the lower edge', () {
      expect(
        ScreenType.fromWidth(BreakpointTokens.mobile),
        ScreenType.tablet,
      );
      expect(
        ScreenType.fromWidth(BreakpointTokens.tablet),
        ScreenType.desktop,
      );
    });
  });

  group('context extensions', () {
    testWidgets('resolve theme extensions and screen helpers', (tester) async {
      late AppSpacing spacing;
      late AppColors colors;
      late AppTypography typography;
      late bool isDark;
      late ScreenType screenType;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Builder(
            builder: (context) {
              spacing = context.spacing;
              colors = context.colors;
              typography = context.textStyles;
              isDark = context.isDarkMode;
              screenType = ScreenType.fromWidth(context.screenWidth);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(spacing.md, SpacingTokens.md);
      expect(colors.background, ColorTokens.neutral50);
      expect(typography.bodyMedium.fontSize, TypographyTokens.sizeBodyMedium);
      expect(isDark, isFalse);
      expect(screenType, isA<ScreenType>());
    });

    testWidgets('responsiveValue picks by width with fallback', (tester) async {
      late int columns;

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(320, 800)),
            child: Builder(
              builder: (context) {
                columns = context.responsiveValue(
                  mobile: 1,
                  tablet: 2,
                  desktop: 4,
                );
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(columns, 1);
    });
  });

  group('ResponsiveBuilder', () {
    testWidgets('builds the mobile subtree at narrow widths', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: SizedBox(
              width: 320,
              child: ResponsiveBuilder(
                mobile: (_) => const Text('mobile'),
                tablet: (_) => const Text('tablet'),
                desktop: (_) => const Text('desktop'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('mobile'), findsOneWidget);
      expect(find.text('tablet'), findsNothing);
    });

    testWidgets('falls back to mobile when tablet builder is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: SizedBox(
              width: 800,
              child: ResponsiveBuilder(
                mobile: (_) => const Text('mobile'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('mobile'), findsOneWidget);
    });
  });
}
