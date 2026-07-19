import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/about_sheet.dart';
import 'package:ngh09_ui_kit_example/explorer/colors_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_badge_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_button_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_chip_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/radii_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/spacing_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/typography_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/component_list_tile.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// The Explorer's home screen: a list of components and foundation tokens,
/// each navigating to its own detail screen.
class ExplorerHomeScreen extends StatelessWidget {
  const ExplorerHomeScreen({required this.isDark, required this.onToggleTheme, super.key});

  /// Whether the app is currently showing its dark theme.
  final bool isDark;

  /// Called to switch between the light and dark themes.
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final textStyles = context.textStyles;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(top: spacing.sm, bottom: spacing.xl),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'ngh09 UI',
                  style: textStyles.headlineSmall.copyWith(color: colors.onBackground, fontWeight: FontWeight.w800),
                ),
                SizedBox(width: spacing.sm),
                const _AppVersionLabel(),
                const Spacer(),
                Row(
                  spacing: spacing.xs,
                  children: [
                    GHAppIconButton(
                      icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                      size: IconButtonSize.extraSmall,
                      corner: IconButtonCorner.smooth,
                      semanticLabel: isDark ? 'Switch to light theme' : 'Switch to dark theme',
                      onPressed: onToggleTheme,
                    ),
                    GHAppIconButton(
                      icon: const GHHeroIcon(GHIcons.informationCircle),
                      size: IconButtonSize.extraSmall,
                      corner: IconButtonCorner.smooth,
                      semanticLabel: 'About this app',
                      onPressed: () => showAboutAppSheet(context),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: spacing.xxs),
            Text(
              'Design system explorer · 7 categories',
              style: textStyles.bodySmall.copyWith(color: colors.onSurfaceVariant),
            ),
            SizedBox(height: spacing.md),
            Text(
              'COMPONENTS',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 10.5,
                letterSpacing: 1.4,
                color: colors.onSurfaceVariant.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Buttons',
              subtitle: '5 variants · 5 sizes · icons & states',
              leading: _ButtonPreview(colors: colors),
              onTap: () => _push(context, const ButtonPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Badges',
              subtitle: '4 colors · 2 shapes · dot & icon',
              leading: _BadgePreview(colors: colors),
              onTap: () => _push(context, const BadgePlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Chips',
              subtitle: 'input · filter',
              leading: _ChipPreview(colors: colors),
              onTap: () => _push(context, const ChipPlaygroundScreen()),
            ),
            SizedBox(height: spacing.lg),
            Text(
              'FOUNDATIONS',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 10.5,
                letterSpacing: 1.4,
                color: colors.onSurfaceVariant.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Colors',
              subtitle: '8 tokens · surface & semantic',
              leading: _ColorsPreview(colors: colors),
              onTap: () => _push(context, const ColorsScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Typography',
              subtitle: '15 styles · display → label',
              leading: _TypePreview(colors: colors, textStyles: textStyles),
              onTap: () => _push(context, const TypographyScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Spacing',
              subtitle: '8 steps · 2 → 48',
              leading: _SpacingPreview(colors: colors),
              onTap: () => _push(context, const SpacingScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Radii',
              subtitle: '4 steps · sm → full',
              leading: _RadiiPreview(colors: colors),
              onTap: () => _push(context, const RadiiScreen()),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _push(BuildContext context, Widget screen) => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
}

/// The version chip shown next to the app title, read from the bundle at
/// runtime. Falls back to a blank chip until the async read resolves.
class _AppVersionLabel extends StatefulWidget {
  const _AppVersionLabel();

  @override
  State<_AppVersionLabel> createState() => _AppVersionLabelState();
}

class _AppVersionLabelState extends State<_AppVersionLabel> {
  String? _version;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _version = 'v${info.version}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Text(
      _version ?? '',
      style: GoogleFonts.jetBrainsMono(fontSize: 11, color: colors.onSurfaceVariant),
    );
  }
}

Widget _swatch(GHAppColors colors, {required Widget child}) {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: colors.surfaceVariant,
      borderRadius: BorderRadius.circular(13),
    ),
    child: Center(child: child),
  );
}

class _ButtonPreview extends StatelessWidget {
  const _ButtonPreview({required this.colors});
  final GHAppColors colors;

  @override
  Widget build(BuildContext context) {
    return _swatch(
      colors,
      child: Container(
        width: 28,
        height: 15,
        decoration: BoxDecoration(
          color: colors.onSurface,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class _BadgePreview extends StatelessWidget {
  const _BadgePreview({required this.colors});
  final GHAppColors colors;

  @override
  Widget build(BuildContext context) {
    return _swatch(
      colors,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final c in [colors.success, colors.warning, colors.danger])
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(color: c, shape: BoxShape.circle),
              ),
            ),
        ],
      ),
    );
  }
}

class _ChipPreview extends StatelessWidget {
  const _ChipPreview({required this.colors});
  final GHAppColors colors;

  @override
  Widget build(BuildContext context) {
    return _swatch(
      colors,
      child: Container(
        width: 30,
        height: 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: colors.onSurfaceVariant, width: 1.5),
        ),
      ),
    );
  }
}

class _ColorsPreview extends StatelessWidget {
  const _ColorsPreview({required this.colors});
  final GHAppColors colors;

  @override
  Widget build(BuildContext context) {
    return _swatch(
      colors,
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (final c in [colors.success, colors.warning, colors.danger, colors.info])
              DecoratedBox(
                decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(3)),
              ),
          ],
        ),
      ),
    );
  }
}

class _TypePreview extends StatelessWidget {
  const _TypePreview({required this.colors, required this.textStyles});
  final GHAppColors colors;
  final GHAppTypography textStyles;

  @override
  Widget build(BuildContext context) {
    return _swatch(
      colors,
      child: Text(
        'Aa',
        style: textStyles.titleMedium.copyWith(fontWeight: FontWeight.w700, color: colors.onSurface),
      ),
    );
  }
}

class _SpacingPreview extends StatelessWidget {
  const _SpacingPreview({required this.colors});
  final GHAppColors colors;

  @override
  Widget build(BuildContext context) {
    return _swatch(
      colors,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final w in [8.0, 14.0, 22.0])
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              child: Container(
                width: w,
                height: 3.5,
                decoration: BoxDecoration(color: colors.onSurface, borderRadius: BorderRadius.circular(2)),
              ),
            ),
        ],
      ),
    );
  }
}

class _RadiiPreview extends StatelessWidget {
  const _RadiiPreview({required this.colors});
  final GHAppColors colors;

  @override
  Widget build(BuildContext context) {
    return _swatch(
      colors,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.onSurfaceVariant, width: 1.5),
        ),
      ),
    );
  }
}
