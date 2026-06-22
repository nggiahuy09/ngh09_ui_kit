import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHHeroIcon] and the [GHIcons] catalog.
///
/// Declared by hand (no code generation) so the catalog stays a plain Dart
/// project that anyone can read and extend. Mirrors the Finesse "Icons" page:
/// a documentation header followed by the full Heroicons set rendered in all
/// three styles.
WidgetbookComponent buildHeroIconComponent() {
  return WidgetbookComponent(
    name: 'GHHeroIcon',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: _playgroundUseCase,
      ),
      WidgetbookUseCase(
        name: 'Catalog',
        builder: _catalogUseCase,
      ),
      WidgetbookUseCase(
        name: 'Styles & sizes',
        builder: _stylesUseCase,
      ),
    ],
  );
}

/// Selectable semantic color roles for the playground color knob.
enum _IconColor { onSurface, primary, danger, success, warning, info }

Color _resolve(_IconColor role, GHAppColors colors) => switch (role) {
  _IconColor.onSurface => colors.onSurface,
  _IconColor.primary => colors.primary,
  _IconColor.danger => colors.danger,
  _IconColor.success => colors.success,
  _IconColor.warning => colors.warning,
  _IconColor.info => colors.info,
};

/// Interactive use case driven by knobs for every public prop.
Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;

  final icon = knobs.object.dropdown<GHIconData>(
    label: 'Icon',
    options: GHIcons.values,
    initialOption: GHIcons.bell,
    labelBuilder: (value) => value.name,
  );
  final style = knobs.object.dropdown<HeroIconStyle>(
    label: 'Style',
    options: HeroIconStyle.values,
    initialOption: HeroIconStyle.outline,
    labelBuilder: (value) => value.name,
  );
  final size = knobs.double.slider(
    label: 'Size',
    initialValue: 48,
    min: 12,
    max: 120,
  );
  final colorRole = knobs.object.dropdown<_IconColor>(
    label: 'Color',
    options: _IconColor.values,
    labelBuilder: (value) => value.name,
  );

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GHHeroIcon(
          icon,
          style: style,
          size: size,
          color: _resolve(colorRole, context.colors),
          semanticLabel: icon.name,
        ),
        const SizedBox(height: 16),
        Text(icon.name, style: context.textStyles.labelMedium),
      ],
    ),
  );
}

/// The full Heroicons catalog: the Finesse "Icons" doc header (design 1) over a
/// searchable grid that shows every icon in all three styles (design 2).
Widget _catalogUseCase(BuildContext context) {
  final query = context.knobs
      .string(label: 'Search')
      .trim()
      .toLowerCase();

  final icons = query.isEmpty
      ? GHIcons.values
      : GHIcons.values.where((i) => i.name.contains(query)).toList();

  return ColoredBox(
    color: context.colors.background,
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _IconsDocHeader(),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final icon in icons) _IconRowTile(icon: icon),
            ],
          ),
        ],
      ),
    ),
  );
}

/// A single representative icon shown across all three styles at several sizes,
/// mirroring the per-icon rows of the Finesse design.
Widget _stylesUseCase(BuildContext context) {
  const sizes = [16.0, 20.0, 24.0, 32.0, 48.0];
  const sampleIcons = [
    GHIcons.bell,
    GHIcons.heart,
    GHIcons.cog6Tooth,
    GHIcons.trash,
    GHIcons.user,
  ];

  return ColoredBox(
    color: context.colors.background,
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final style in HeroIconStyle.values) ...[
            Text(style.name, style: context.textStyles.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 24,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (final icon in sampleIcons)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final size in sizes) ...[
                        GHHeroIcon(icon, style: style, size: size),
                        const SizedBox(width: 8),
                      ],
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ],
      ),
    ),
  );
}

/// One catalog tile: the [icon] in mini, outline and solid, then its name.
class _IconRowTile extends StatelessWidget {
  const _IconRowTile({required this.icon});

  final GHIconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Row(
        children: [
          GHHeroIcon(icon, style: HeroIconStyle.mini),
          const SizedBox(width: 12),
          GHHeroIcon(icon),
          const SizedBox(width: 12),
          GHHeroIcon(icon, style: HeroIconStyle.solid),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              icon.name,
              style: context.textStyles.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Reproduces the Finesse "Icons" documentation header (Figma design 1).
class _IconsDocHeader extends StatelessWidget {
  const _IconsDocHeader();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final styles = context.textStyles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: ColorTokens.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '❖ FINESSE',
                style: styles.labelLarge.copyWith(
                  color: ColorTokens.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'finesseui.com',
                style: styles.bodySmall.copyWith(
                  color: ColorTokens.white,
                  decoration: TextDecoration.underline,
                  decorationColor: ColorTokens.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Icons',
          style: styles.headlineMedium.copyWith(color: colors.onBackground),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Text(
            'Icons are a set of visual representations of actions, objects, or '
            'concepts that are used to communicate information quickly and '
            'efficiently to users. Icons can be used to improve the usability '
            'and accessibility of an interface, by providing a visual '
            'shorthand for common tasks and functions.\n\n'
            'Our design system makes use of Heroicons which is a collection of '
            '880+ polished and beautiful hand-crafted SVG icons, by the makers '
            'of Tailwind CSS.',
            style: styles.bodyLarge.copyWith(color: colors.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
