import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_app/explorer/explorer_scaffold.dart';

class _SpacingStep {
  const _SpacingStep(this.name, this.value);

  final String name;
  final double value;
}

/// A static reference list of the kit's spacing scale, read live from
/// [GHAppSpacing].
class SpacingScreen extends StatelessWidget {
  const SpacingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    final steps = [
      _SpacingStep('xxs', spacing.xxs),
      _SpacingStep('xs', spacing.xs),
      _SpacingStep('sm', spacing.sm),
      _SpacingStep('smd', spacing.smd),
      _SpacingStep('md', spacing.md),
      _SpacingStep('lg', spacing.lg),
      _SpacingStep('xl', spacing.xl),
      _SpacingStep('xxl', spacing.xxl),
    ];

    return ExplorerScaffold(
      title: 'Spacing',
      trailing: const ExplorerMeta('8 steps'),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        itemCount: steps.length,
        separatorBuilder: (context, index) => SizedBox(height: spacing.sm),
        itemBuilder: (context, index) {
          final step = steps[index];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: spacing.md, vertical: spacing.smd),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: context.radii.borderRadiusMd,
              border: Border.all(color: colors.outlineVariant),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 34,
                  child: Text(
                    step.name,
                    style: GoogleFonts.jetBrainsMono(fontSize: 12, color: colors.onSurfaceVariant),
                  ),
                ),
                SizedBox(width: spacing.md),
                Container(
                  width: step.value * 3.4,
                  height: 12,
                  decoration: BoxDecoration(color: colors.onSurface, borderRadius: BorderRadius.circular(3)),
                ),
                const Spacer(),
                Text(
                  step.value.toStringAsFixed(0),
                  style: GoogleFonts.jetBrainsMono(fontSize: 12, color: colors.onSurface),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
