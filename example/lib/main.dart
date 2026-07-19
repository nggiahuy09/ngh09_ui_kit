/// ngh09_ui_kit — pub.dev example.
///
/// Minimal recommended usage: theme the app with [GHAppTheme.light] /
/// [GHAppTheme.dark], then compose the kit's `GH*` widgets. Every widget reads
/// its colors, spacing, radii and type from the active theme, so a light/dark
/// toggle re-styles the whole screen with no widget changes.
///
///   cd example && flutter run
library;

import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

void main() => runApp(const ExampleApp());

/// Root app wiring [GHAppTheme] into a [MaterialApp] and holding the
/// light/dark [ThemeMode] the home screen toggles.
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
      debugShowCheckedModeBanner: false,
      theme: GHAppTheme.light(),
      darkTheme: GHAppTheme.dark(),
      themeMode: _themeMode,
      home: _HomePage(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({required this.isDark, required this.onToggleTheme});

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final TextEditingController _emailController = TextEditingController();

  bool _subscribed = true;
  bool _unreadOnly = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  static const _sections = <_Section>[
    _Section(GHIcons.squares2x2, 'Buttons', 'GHAppButton · GHAppIconButton'),
    _Section(GHIcons.rectangleStack, 'Display', 'GHAppBadge · GHAppChip · GHUserAvatar'),
    _Section(GHIcons.bell, 'Feedback', 'GHAppAlert · GHSnackbar · GHTooltip'),
    _Section(GHIcons.cog6Tooth, 'Inputs', 'GHAppTextField · GHAppToggle · GHAppSlider'),
    _Section(GHIcons.square3Stack3d, 'Navigation', 'GHBreadcrumbs · GHPagination · GHSegmentedControl'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final textStyles = context.textStyles;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        title: Text('ngh09 UI Kit', style: textStyles.titleLarge),
        actions: [
          GHAppIconButton(
            icon: GHHeroIcon(widget.isDark ? GHIcons.sun : GHIcons.moon),
            onPressed: widget.onToggleTheme,
          ),
          SizedBox(width: spacing.sm),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(spacing.lg),
        children: [
          // ── Hero card ──
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Material 3 Design System', style: textStyles.headlineLarge),
                SizedBox(height: spacing.sm),
                Text(
                  'A two-tier token architecture with themeable widgets. Tap ☀/☾ to '
                  'toggle the theme — every widget below re-styles from the semantic layer.',
                  style: textStyles.bodyMedium.copyWith(color: colors.onSurfaceVariant),
                ),
                SizedBox(height: spacing.lg),
                Row(
                  children: [
                    GHAppButton.filled(
                      label: 'Get Started',
                      leading: const GHHeroIcon(GHIcons.play),
                      onPressed: () {},
                    ),
                    SizedBox(width: spacing.smd),
                    GHAppButton.outlined(
                      label: 'Docs',
                      trailing: const GHHeroIcon(GHIcons.arrowRight),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spacing.lg),

          // ── Display row: badges, chips, avatars ──
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Display', style: textStyles.titleMedium),
                SizedBox(height: spacing.md),
                Wrap(
                  spacing: spacing.sm,
                  runSpacing: spacing.sm,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const GHAppBadge(label: 'New'),
                    const GHAppBadge.dot(label: 'Live', color: BadgeColor.success),
                    GHAppBadge.count(count: 128, max: 99, color: BadgeColor.error),
                    GHAppChip.filter(
                      label: 'Unread',
                      selected: _unreadOnly,
                      onSelected: (value) => setState(() => _unreadOnly = value),
                    ),
                    const GHUserAvatar.initials('AB', size: GHAvatarSize.sm),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spacing.lg),

          // ── Inputs ──
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Inputs', style: textStyles.titleMedium),
                SizedBox(height: spacing.md),
                GHAppTextField(
                  label: 'Email',
                  placeholder: 'you@example.com',
                  controller: _emailController,
                  leadingIcon: const GHHeroIcon(GHIcons.user),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: spacing.md),
                Row(
                  children: [
                    Expanded(
                      child: Text('Subscribe to updates', style: textStyles.bodyLarge),
                    ),
                    GHAppToggle(
                      value: _subscribed,
                      onChanged: (value) => setState(() => _subscribed = value),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spacing.lg),

          // ── Feedback ──
          const GHAppAlert(
            headline: 'Your changes were saved.',
            state: GHAlertState.success,
            supportingText: 'The kit ships inline alerts, snackbars and tooltips.',
            smooth: true,
          ),
          SizedBox(height: spacing.lg),

          // ── Section list ──
          for (final section in _sections)
            Padding(
              padding: EdgeInsets.only(bottom: spacing.smd),
              child: _Card(
                child: Row(
                  children: [
                    GHHeroIcon(section.icon, color: colors.primary),
                    SizedBox(width: spacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(section.title, style: textStyles.bodyLarge),
                          SizedBox(height: spacing.xs),
                          Text(
                            section.widgets,
                            style: textStyles.bodyMedium.copyWith(color: colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    GHHeroIcon(GHIcons.arrowRight, size: 16, color: colors.onSurfaceVariant),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A rounded surface panel that frames a group of kit widgets, styled from the
/// active theme's semantic tokens.
class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radii = context.radii;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(radii.lg),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: child,
    );
  }
}

/// One row in the component index: an icon, a title and the widgets it groups.
class _Section {
  const _Section(this.icon, this.title, this.widgets);

  final GHIconData icon;
  final String title;
  final String widgets;
}
