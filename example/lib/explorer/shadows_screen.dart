import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';

class _ShadowStep {
  const _ShadowStep(this.name, this.value);

  final String name;
  final List<BoxShadow> value;
}

/// A static reference grid of the kit's shadow roles, read live from
/// [GHAppShadows].
class ShadowsScreen extends StatelessWidget {
  const ShadowsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final shadows = context.shadows;

    final steps = [
      _ShadowStep('small', shadows.small),
      _ShadowStep('medium', shadows.medium),
      _ShadowStep('large', shadows.large),
      _ShadowStep('hoverPrimary', shadows.hoverPrimary),
      _ShadowStep('hoverSecondary', shadows.hoverSecondary),
      _ShadowStep('hoverError', shadows.hoverError),
      _ShadowStep('hoverWarning', shadows.hoverWarning),
      _ShadowStep('hoverSuccess', shadows.hoverSuccess),
      _ShadowStep('focusPrimary', shadows.focusPrimary),
      _ShadowStep('focusSecondary', shadows.focusSecondary),
      _ShadowStep('focusError', shadows.focusError),
      _ShadowStep('focusWarning', shadows.focusWarning),
      _ShadowStep('focusSuccess', shadows.focusSuccess),
    ];

    return ExplorerScaffold(
      title: 'Shadows',
      trailing: ExplorerMeta('${steps.length} tokens'),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.05),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          final step = steps[index];

          return Container(
            padding: EdgeInsets.all(spacing.smd),
            decoration: BoxDecoration(
              color: colors.background,
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
                    color: colors.surface,
                    borderRadius: context.radii.borderRadiusMd,
                    boxShadow: step.value,
                  ),
                ),
                SizedBox(height: spacing.smd),
                Text(
                  step.name,
                  style: context.textStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: colors.onSurface),
                ),
                SizedBox(height: spacing.xxs),
                Text(
                  '${step.value.length} layer${step.value.length == 1 ? '' : 's'}',
                  style: GoogleFonts.jetBrainsMono(fontSize: 10.5, color: colors.onSurfaceVariant),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
