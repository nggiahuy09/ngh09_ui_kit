import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ngh09_ui_kit_example/explorer/about_sheet.dart';
import 'package:ngh09_ui_kit_example/explorer/breakpoints_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/colors_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/durations_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/flags_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/icons_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/logos_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/payment_icons_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_alert_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_avatar_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_badge_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_breadcrumbs_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_button_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_checkbox_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_chip_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_dropdown_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_icon_button_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_input_dropdown_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_pagination_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_progress_bar_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_progress_stepper_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_radio_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_range_slider_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_segmented_control_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_slider_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_snackbar_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_text_area_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_text_field_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_toggle_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/playground_tooltip_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/radii_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/shadows_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/spacing_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/typography_screen.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/component_list_tile.dart';

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
              'Design system explorer · 12 categories',
              style: textStyles.bodySmall.copyWith(color: colors.onSurfaceVariant),
            ),
            SizedBox(height: spacing.md),

            const ExplorerEyebrow('COMPONENTS'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Buttons',
              subtitle: '5 variants · 5 sizes · icons & states',
              leading: _ButtonPreview(colors: colors),
              onTap: () => _push(context, const ButtonPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Icon buttons',
              subtitle: '7 sizes · sharp & smooth',
              leading: _IconSwatch(colors: colors, icon: Icons.favorite),
              onTap: () => _push(context, const IconButtonPlaygroundScreen()),
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
              subtitle: 'input · filter · choice',
              leading: _ChipPreview(colors: colors),
              onTap: () => _push(context, const ChipPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Avatars',
              subtitle: '14 variants · initials · status',
              leading: _IconSwatch(colors: colors, icon: Icons.person),
              onTap: () => _push(context, const AvatarPlaygroundScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('FEEDBACK'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Alerts',
              subtitle: 'active · error · warning · success',
              leading: _IconSwatch(colors: colors, icon: Icons.info_outline),
              onTap: () => _push(context, const AlertPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Snackbars',
              subtitle: 'states · CTA · live overlay',
              leading: _IconSwatch(colors: colors, icon: Icons.chat_bubble_outline),
              onTap: () => _push(context, const SnackbarPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Tooltips',
              subtitle: 'arrow · size · corner',
              leading: _IconSwatch(colors: colors, icon: Icons.help_outline),
              onTap: () => _push(context, const TooltipPlaygroundScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('INPUTS'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Checkbox',
              subtitle: '3 sizes · checked & disabled',
              leading: _IconSwatch(colors: colors, icon: Icons.check_box_outlined),
              onTap: () => _push(context, const CheckboxPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Radio',
              subtitle: '3 sizes · checked & disabled',
              leading: _IconSwatch(colors: colors, icon: Icons.radio_button_checked),
              onTap: () => _push(context, const RadioPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Toggle',
              subtitle: '3 sizes · on/off & disabled',
              leading: _IconSwatch(colors: colors, icon: Icons.toggle_on_outlined),
              onTap: () => _push(context, const TogglePlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Slider',
              subtitle: 'min · max · step · value label',
              leading: _IconSwatch(colors: colors, icon: Icons.tune),
              onTap: () => _push(context, const SliderPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Range slider',
              subtitle: 'dual handles · indicator styles',
              leading: _IconSwatch(colors: colors, icon: Icons.linear_scale),
              onTap: () => _push(context, const RangeSliderPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Text field',
              subtitle: 'status · obscure · leading icon',
              leading: _IconSwatch(colors: colors, icon: Icons.text_fields),
              onTap: () => _push(context, const TextFieldPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Text area',
              subtitle: 'status · min/max lines',
              leading: _IconSwatch(colors: colors, icon: Icons.notes),
              onTap: () => _push(context, const TextAreaPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Dropdown',
              subtitle: 'sections · leading & trailing types',
              leading: _IconSwatch(colors: colors, icon: Icons.arrow_drop_down_circle_outlined),
              onTap: () => _push(context, const DropdownPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Input dropdown',
              subtitle: 'searchable · placeholder',
              leading: _IconSwatch(colors: colors, icon: Icons.search),
              onTap: () => _push(context, const InputDropdownPlaygroundScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('NAVIGATION'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Segmented control',
              subtitle: '2-4 segments · label & icon',
              leading: _IconSwatch(colors: colors, icon: Icons.view_column_outlined),
              onTap: () => _push(context, const SegmentedControlPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Breadcrumbs',
              subtitle: 'text · icon · auto-collapse',
              leading: _IconSwatch(colors: colors, icon: Icons.more_horiz),
              onTap: () => _push(context, const BreadcrumbsPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Pagination',
              subtitle: 'numbered · simple · collapsing',
              leading: _IconSwatch(colors: colors, icon: Icons.last_page),
              onTap: () => _push(context, const PaginationPlaygroundScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('PROGRESS'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Progress bar',
              subtitle: 'value · indicator styles',
              leading: _IconSwatch(colors: colors, icon: Icons.horizontal_rule),
              onTap: () => _push(context, const ProgressBarPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Progress stepper',
              subtitle: 'chip · number · icon indicators',
              leading: _IconSwatch(colors: colors, icon: Icons.linear_scale_outlined),
              onTap: () => _push(context, const ProgressStepperPlaygroundScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('MEDIA'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Flags',
              subtitle: '215 countries · searchable',
              leading: _IconSwatch(colors: colors, icon: Icons.flag_outlined),
              onTap: () => _push(context, const FlagsScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Icons',
              subtitle: '293 Heroicons · mini/outline/solid',
              leading: _IconSwatch(colors: colors, icon: Icons.emoji_symbols_outlined),
              onTap: () => _push(context, const IconsScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Logos',
              subtitle: '137 companies · searchable',
              leading: _IconSwatch(colors: colors, icon: Icons.business_outlined),
              onTap: () => _push(context, const LogosScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Payment icons',
              subtitle: 'cards & wallets · 3 sizes',
              leading: _IconSwatch(colors: colors, icon: Icons.credit_card),
              onTap: () => _push(context, const PaymentIconsScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('FOUNDATIONS'),
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
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Shadows',
              subtitle: '13 tokens · elevation & focus',
              leading: _IconSwatch(colors: colors, icon: Icons.blur_on),
              onTap: () => _push(context, const ShadowsScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Breakpoints',
              subtitle: 'mobile · tablet · desktop',
              leading: _IconSwatch(colors: colors, icon: Icons.devices),
              onTap: () => _push(context, const BreakpointsScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Durations',
              subtitle: 'fast · normal · slow',
              leading: _IconSwatch(colors: colors, icon: Icons.timer_outlined),
              onTap: () => _push(context, const DurationsScreen()),
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

/// A generic leading-icon swatch used by every new component tile: a single
/// Material icon centered in the same 46x46 rounded surface the bespoke
/// previews use.
class _IconSwatch extends StatelessWidget {
  const _IconSwatch({required this.colors, required this.icon});

  final GHAppColors colors;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return _swatch(colors, child: Icon(icon, size: 20, color: colors.onSurfaceVariant));
  }
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
