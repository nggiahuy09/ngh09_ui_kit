import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Swatches for every semantic color role.
class ColorsShowcase extends StatelessWidget {
  const ColorsShowcase({super.key});

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
