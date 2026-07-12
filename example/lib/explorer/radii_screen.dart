import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';

class _RadiusStep {
  const _RadiusStep(this.name, this.value, this.label);

  final String name;
  final double value;
  final String label;
}

/// A static reference grid of the kit's radius scale, read live from
/// [GHAppRadii].
class RadiiScreen extends StatelessWidget {
  const RadiiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final radii = context.radii;

    final steps = [
      _RadiusStep('sm', radii.sm, '${radii.sm.toStringAsFixed(0)}px'),
      _RadiusStep('md', radii.md, '${radii.md.toStringAsFixed(0)}px'),
      _RadiusStep('lg', radii.lg, '${radii.lg.toStringAsFixed(0)}px'),
      _RadiusStep('full', radii.full, '∞'),
    ];

    return ExplorerScaffold(
      title: 'Radii',
      trailing: const ExplorerMeta('4 steps'),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.05),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          final step = steps[index];

          return Container(
            padding: EdgeInsets.all(spacing.smd),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: context.radii.borderRadiusLg,
              border: Border.all(color: colors.outlineVariant),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(step.value),
                    border: Border.all(color: colors.onSurfaceVariant.withValues(alpha: 0.6), width: 1.5),
                  ),
                ),
                SizedBox(height: spacing.smd),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      step.name,
                      style: context.textStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: colors.onSurface),
                    ),
                    SizedBox(width: spacing.xs),
                    Text(
                      step.label,
                      style: GoogleFonts.jetBrainsMono(fontSize: 10.5, color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
