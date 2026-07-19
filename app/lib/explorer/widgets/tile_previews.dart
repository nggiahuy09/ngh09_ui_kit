import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

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
class IconSwatch extends StatelessWidget {
  const IconSwatch({required this.colors, required this.icon, super.key});

  final GHAppColors colors;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return _swatch(colors, child: Icon(icon, size: 20, color: colors.onSurfaceVariant));
  }
}

/// Leading preview for the Buttons tile.
class ButtonPreview extends StatelessWidget {
  const ButtonPreview({required this.colors, super.key});
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

/// Leading preview for the Badges tile.
class BadgePreview extends StatelessWidget {
  const BadgePreview({required this.colors, super.key});
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

/// Leading preview for the Chips tile.
class ChipPreview extends StatelessWidget {
  const ChipPreview({required this.colors, super.key});
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

/// Leading preview for the Colors tile.
class ColorsPreview extends StatelessWidget {
  const ColorsPreview({required this.colors, super.key});
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

/// Leading preview for the Typography tile.
class TypePreview extends StatelessWidget {
  const TypePreview({required this.colors, required this.textStyles, super.key});
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

/// Leading preview for the Spacing tile.
class SpacingPreview extends StatelessWidget {
  const SpacingPreview({required this.colors, super.key});
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

/// Leading preview for the Radii tile.
class RadiiPreview extends StatelessWidget {
  const RadiiPreview({required this.colors, super.key});
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
