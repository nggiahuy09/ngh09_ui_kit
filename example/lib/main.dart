import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

void main() => runApp(const ExampleApp());

/// Minimal example demonstrating the ngh09_ui_kit foundation: design tokens,
/// the semantic theme layer, and light/dark theming.
class ExampleApp extends StatefulWidget {
  /// Creates the example app.
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ngh09_ui_kit example',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: _FoundationGallery(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

/// A scrollable gallery showcasing the foundation tokens.
class _FoundationGallery extends StatelessWidget {
  const _FoundationGallery({
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: const Text('ngh09_ui_kit'),
        actions: [
          IconButton(
            tooltip: isDark ? 'Switch to light' : 'Switch to dark',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
          SizedBox(width: spacing.sm),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(spacing.md),
        children: const [
          _Section(title: 'Buttons', child: _ButtonsShowcase()),
          _Section(title: 'Badges', child: _BadgesShowcase()),
          _Section(title: 'Chips', child: _ChipsShowcase()),
          _Section(title: 'Colors', child: _ColorsShowcase()),
          _Section(title: 'Typography', child: _TypographyShowcase()),
          _Section(title: 'Spacing', child: _SpacingShowcase()),
          _Section(title: 'Radii', child: _RadiiShowcase()),
        ],
      ),
    );
  }
}

/// A titled section wrapper with consistent vertical rhythm.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    return Padding(
      padding: EdgeInsets.only(bottom: spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textStyles.headlineSmall.copyWith(
              color: context.colors.onBackground,
            ),
          ),
          SizedBox(height: spacing.sm),
          Divider(color: context.colors.outlineVariant),
          SizedBox(height: spacing.md),
          child,
        ],
      ),
    );
  }
}

/// Every [AppButton] variant, size and state.
class _ButtonsShowcase extends StatelessWidget {
  const _ButtonsShowcase();

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: [
            for (final variant in ButtonVariant.values)
              AppButton(
                label: variant.name,
                variant: variant,
                onPressed: () {},
              ),
          ],
        ),
        SizedBox(height: spacing.md),
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final size in ButtonSize.values)
              AppButton(label: size.name, size: size, onPressed: () {}),
          ],
        ),
        SizedBox(height: spacing.md),
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: [
            AppButton(
              label: 'With icons',
              leading: const Icon(Icons.check),
              trailing: const Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
            const AppButton(label: 'Disabled'),
            AppButton(label: 'Loading', isLoading: true, onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

/// Every [AppBadge] status and shape.
class _BadgesShowcase extends StatelessWidget {
  const _BadgesShowcase();

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final status in BadgeStatus.values)
              AppBadge(label: status.name, status: status),
          ],
        ),
        SizedBox(height: spacing.md),
        Wrap(
          spacing: spacing.md,
          runSpacing: spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const AppBadge(label: 'New', status: BadgeStatus.info),
            AppBadge.count(count: 128, max: 99, status: BadgeStatus.danger),
            const AppBadge.dot(status: BadgeStatus.success),
          ],
        ),
        SizedBox(height: spacing.md),
        const AppBadge(
          label: 'Expanded',
          status: BadgeStatus.warning,
          expanded: true,
        ),
      ],
    );
  }
}

/// Every [AppChip] variant with live selection / deletion.
class _ChipsShowcase extends StatefulWidget {
  const _ChipsShowcase();

  @override
  State<_ChipsShowcase> createState() => _ChipsShowcaseState();
}

class _ChipsShowcaseState extends State<_ChipsShowcase> {
  final List<String> _tags = ['design', 'flutter', 'ui-kit'];
  final Set<String> _filters = {'Unread'};
  String _choice = 'Medium';

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    const filters = ['Unread', 'Starred', 'Archived'];
    const choices = ['Low', 'Medium', 'High'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input chips — deletable tags.
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: [
            for (final tag in _tags)
              AppChip.input(
                label: tag,
                leading: const Icon(Icons.tag),
                onDeleted: () => setState(() => _tags.remove(tag)),
              ),
          ],
        ),
        SizedBox(height: spacing.md),
        // Filter chips — multi-select.
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: [
            for (final filter in filters)
              AppChip.filter(
                label: filter,
                selected: _filters.contains(filter),
                onSelected: (selected) => setState(() {
                  if (selected) {
                    _filters.add(filter);
                  } else {
                    _filters.remove(filter);
                  }
                }),
              ),
          ],
        ),
        SizedBox(height: spacing.md),
        // Choice chips — single-select.
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: [
            for (final choice in choices)
              AppChip.choice(
                label: choice,
                selected: _choice == choice,
                onSelected: (_) => setState(() => _choice = choice),
              ),
          ],
        ),
        SizedBox(height: spacing.md),
        // Expanded chip — stretches to the full available width.
        AppChip.filter(
          label: 'Expanded',
          selected: true,
          expanded: true,
          onSelected: (_) {},
        ),
      ],
    );
  }
}

/// Swatches for every semantic color role.
class _ColorsShowcase extends StatelessWidget {
  const _ColorsShowcase();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final swatches = <({String name, Color bg, Color fg})>[
      (name: 'primary', bg: c.primary, fg: c.onPrimary),
      (
        name: 'primaryContainer',
        bg: c.primaryContainer,
        fg: c.onPrimaryContainer,
      ),
      (name: 'surface', bg: c.surface, fg: c.onSurface),
      (name: 'surfaceVariant', bg: c.surfaceVariant, fg: c.onSurfaceVariant),
      (name: 'success', bg: c.success, fg: c.onSuccess),
      (name: 'warning', bg: c.warning, fg: c.onWarning),
      (name: 'danger', bg: c.danger, fg: c.onDanger),
      (name: 'info', bg: c.info, fg: c.onInfo),
    ];

    return Wrap(
      spacing: context.spacing.sm,
      runSpacing: context.spacing.sm,
      children: [
        for (final s in swatches)
          _Swatch(name: s.name, background: s.bg, foreground: s.fg),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.name,
    required this.background,
    required this.foreground,
  });

  final String name;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 72,
      padding: EdgeInsets.all(context.spacing.sm),
      decoration: BoxDecoration(
        color: background,
        borderRadius: context.radii.borderRadiusMd,
        border: Border.all(color: context.colors.outlineVariant),
      ),
      alignment: Alignment.bottomLeft,
      child: Text(
        name,
        style: context.textStyles.labelLarge.copyWith(color: foreground),
      ),
    );
  }
}

/// One line per Material 3 type role.
class _TypographyShowcase extends StatelessWidget {
  const _TypographyShowcase();

  @override
  Widget build(BuildContext context) {
    final t = context.textStyles;
    final color = context.colors.onBackground;
    final samples = <({String label, TextStyle style})>[
      (label: 'Display Large', style: t.displayLarge),
      (label: 'Display Medium', style: t.displayMedium),
      (label: 'Display Small', style: t.displaySmall),
      (label: 'Headline Large', style: t.headlineLarge),
      (label: 'Headline Medium', style: t.headlineMedium),
      (label: 'Headline Small', style: t.headlineSmall),
      (label: 'Title Large', style: t.titleLarge),
      (label: 'Title Medium', style: t.titleMedium),
      (label: 'Title Small', style: t.titleSmall),
      (label: 'Body Large', style: t.bodyLarge),
      (label: 'Body Medium', style: t.bodyMedium),
      (label: 'Body Small', style: t.bodySmall),
      (label: 'Label Large', style: t.labelLarge),
      (label: 'Label Medium', style: t.labelMedium),
      (label: 'Label Small', style: t.labelSmall),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final s in samples)
          Padding(
            padding: EdgeInsets.only(bottom: context.spacing.xs),
            child: Text(s.label, style: s.style.copyWith(color: color)),
          ),
      ],
    );
  }
}

/// Visual bars for each spacing step.
class _SpacingShowcase extends StatelessWidget {
  const _SpacingShowcase();

  @override
  Widget build(BuildContext context) {
    final s = context.spacing;
    final steps = <({String name, double value})>[
      (name: 'xxs', value: s.xxs),
      (name: 'xs', value: s.xs),
      (name: 'sm', value: s.sm),
      (name: 'smd', value: s.smd),
      (name: 'md', value: s.md),
      (name: 'lg', value: s.lg),
      (name: 'xl', value: s.xl),
      (name: 'xxl', value: s.xxl),
    ];

    return Column(
      children: [
        for (final step in steps)
          Padding(
            padding: EdgeInsets.only(bottom: context.spacing.xs),
            child: Row(
              children: [
                SizedBox(
                  width: 48,
                  child: Text(
                    step.name,
                    style: context.textStyles.labelMedium.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ),
                Container(
                  width: step.value,
                  height: 16,
                  color: context.colors.primary,
                ),
                SizedBox(width: context.spacing.sm),
                Text(
                  '${step.value.toInt()}',
                  style: context.textStyles.bodySmall.copyWith(
                    color: context.colors.onBackground,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Rounded boxes for each radius step.
class _RadiiShowcase extends StatelessWidget {
  const _RadiiShowcase();

  @override
  Widget build(BuildContext context) {
    final r = context.radii;
    final steps = <({String name, double value})>[
      (name: 'sm', value: r.sm),
      (name: 'md', value: r.md),
      (name: 'lg', value: r.lg),
      (name: 'full', value: r.full),
    ];

    return Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        for (final step in steps)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: context.colors.primaryContainer,
                  borderRadius: BorderRadius.circular(step.value),
                  border: Border.all(color: context.colors.outline),
                ),
              ),
              SizedBox(height: context.spacing.xs),
              Text(
                step.name,
                style: context.textStyles.labelMedium.copyWith(
                  color: context.colors.onBackground,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
