import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ngh09_ui_kit_example/explorer/about_sheet.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_screens.dart';

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
              leading: ButtonPreview(colors: colors),
              onTap: () => _push(context, const ButtonPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Icon buttons',
              subtitle: '7 sizes · sharp & smooth',
              leading: IconSwatch(colors: colors, icon: Icons.favorite),
              onTap: () => _push(context, const IconButtonPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Badges',
              subtitle: '4 colors · 2 shapes · dot & icon',
              leading: BadgePreview(colors: colors),
              onTap: () => _push(context, const BadgePlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Chips',
              subtitle: 'input · filter · choice',
              leading: ChipPreview(colors: colors),
              onTap: () => _push(context, const ChipPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Avatars',
              subtitle: '14 variants · initials · status',
              leading: IconSwatch(colors: colors, icon: Icons.person),
              onTap: () => _push(context, const AvatarPlaygroundScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('FEEDBACK'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Alerts',
              subtitle: 'active · error · warning · success',
              leading: IconSwatch(colors: colors, icon: Icons.info_outline),
              onTap: () => _push(context, const AlertPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Snackbars',
              subtitle: 'states · CTA · live overlay',
              leading: IconSwatch(colors: colors, icon: Icons.chat_bubble_outline),
              onTap: () => _push(context, const SnackbarPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Tooltips',
              subtitle: 'arrow · size · corner',
              leading: IconSwatch(colors: colors, icon: Icons.help_outline),
              onTap: () => _push(context, const TooltipPlaygroundScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('INPUTS'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Checkbox',
              subtitle: '3 sizes · checked & disabled',
              leading: IconSwatch(colors: colors, icon: Icons.check_box_outlined),
              onTap: () => _push(context, const CheckboxPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Radio',
              subtitle: '3 sizes · checked & disabled',
              leading: IconSwatch(colors: colors, icon: Icons.radio_button_checked),
              onTap: () => _push(context, const RadioPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Toggle',
              subtitle: '3 sizes · on/off & disabled',
              leading: IconSwatch(colors: colors, icon: Icons.toggle_on_outlined),
              onTap: () => _push(context, const TogglePlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Slider',
              subtitle: 'min · max · step · value label',
              leading: IconSwatch(colors: colors, icon: Icons.tune),
              onTap: () => _push(context, const SliderPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Range slider',
              subtitle: 'dual handles · indicator styles',
              leading: IconSwatch(colors: colors, icon: Icons.linear_scale),
              onTap: () => _push(context, const RangeSliderPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Text field',
              subtitle: 'status · obscure · leading icon',
              leading: IconSwatch(colors: colors, icon: Icons.text_fields),
              onTap: () => _push(context, const TextFieldPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Text area',
              subtitle: 'status · min/max lines',
              leading: IconSwatch(colors: colors, icon: Icons.notes),
              onTap: () => _push(context, const TextAreaPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Dropdown',
              subtitle: 'sections · leading & trailing types',
              leading: IconSwatch(colors: colors, icon: Icons.arrow_drop_down_circle_outlined),
              onTap: () => _push(context, const DropdownPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Input dropdown',
              subtitle: 'searchable · placeholder',
              leading: IconSwatch(colors: colors, icon: Icons.search),
              onTap: () => _push(context, const InputDropdownPlaygroundScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('NAVIGATION'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Segmented control',
              subtitle: '2-4 segments · label & icon',
              leading: IconSwatch(colors: colors, icon: Icons.view_column_outlined),
              onTap: () => _push(context, const SegmentedControlPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Breadcrumbs',
              subtitle: 'text · icon · auto-collapse',
              leading: IconSwatch(colors: colors, icon: Icons.more_horiz),
              onTap: () => _push(context, const BreadcrumbsPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Pagination',
              subtitle: 'numbered · simple · collapsing',
              leading: IconSwatch(colors: colors, icon: Icons.last_page),
              onTap: () => _push(context, const PaginationPlaygroundScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('PROGRESS'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Progress bar',
              subtitle: 'value · indicator styles',
              leading: IconSwatch(colors: colors, icon: Icons.horizontal_rule),
              onTap: () => _push(context, const ProgressBarPlaygroundScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Progress stepper',
              subtitle: 'chip · number · icon indicators',
              leading: IconSwatch(colors: colors, icon: Icons.linear_scale_outlined),
              onTap: () => _push(context, const ProgressStepperPlaygroundScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('MEDIA'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Flags',
              subtitle: '215 countries · searchable',
              leading: IconSwatch(colors: colors, icon: Icons.flag_outlined),
              onTap: () => _push(context, const FlagsScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Icons',
              subtitle: '293 Heroicons · mini/outline/solid',
              leading: IconSwatch(colors: colors, icon: Icons.emoji_symbols_outlined),
              onTap: () => _push(context, const IconsScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Logos',
              subtitle: '137 companies · searchable',
              leading: IconSwatch(colors: colors, icon: Icons.business_outlined),
              onTap: () => _push(context, const LogosScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Payment icons',
              subtitle: 'cards & wallets · 3 sizes',
              leading: IconSwatch(colors: colors, icon: Icons.credit_card),
              onTap: () => _push(context, const PaymentIconsScreen()),
            ),
            SizedBox(height: spacing.lg),

            const ExplorerEyebrow('FOUNDATIONS'),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Colors',
              subtitle: '8 tokens · surface & semantic',
              leading: ColorsPreview(colors: colors),
              onTap: () => _push(context, const ColorsScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Typography',
              subtitle: '15 styles · display → label',
              leading: TypePreview(colors: colors, textStyles: textStyles),
              onTap: () => _push(context, const TypographyScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Spacing',
              subtitle: '8 steps · 2 → 48',
              leading: SpacingPreview(colors: colors),
              onTap: () => _push(context, const SpacingScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Radii',
              subtitle: '4 steps · sm → full',
              leading: RadiiPreview(colors: colors),
              onTap: () => _push(context, const RadiiScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Shadows',
              subtitle: '13 tokens · elevation & focus',
              leading: IconSwatch(colors: colors, icon: Icons.blur_on),
              onTap: () => _push(context, const ShadowsScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Breakpoints',
              subtitle: 'mobile · tablet · desktop',
              leading: IconSwatch(colors: colors, icon: Icons.devices),
              onTap: () => _push(context, const BreakpointsScreen()),
            ),
            SizedBox(height: spacing.sm),
            ComponentListTile(
              title: 'Durations',
              subtitle: 'fast · normal · slow',
              leading: IconSwatch(colors: colors, icon: Icons.timer_outlined),
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
