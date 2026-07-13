import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';

class _BreakpointStep {
  const _BreakpointStep(this.name, this.value);

  final String name;
  final double value;
}

/// A static reference display of the kit's responsive breakpoints, read
/// live from [BreakpointTokens].
class BreakpointsScreen extends StatelessWidget {
  const BreakpointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    final steps = [
      _BreakpointStep('mobile', BreakpointTokens.mobile),
      _BreakpointStep('tablet', BreakpointTokens.tablet),
      _BreakpointStep('desktop', BreakpointTokens.desktop),
    ];

    final maxValue = steps.map((s) => s.value).reduce((a, b) => a > b ? a : b);

    return ExplorerScaffold(
      title: 'Breakpoints',
      trailing: const ExplorerMeta('3 tokens'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      step.name,
                      style: context.textStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: colors.onSurface),
                    ),
                    const Spacer(),
                    Text(
                      '${step.value.toStringAsFixed(0)}px',
                      style: GoogleFonts.jetBrainsMono(fontSize: 12, color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
                SizedBox(height: spacing.smd),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth * (step.value / maxValue);
                    return Container(
                      width: width,
                      height: 12,
                      decoration: BoxDecoration(color: colors.onSurface, borderRadius: BorderRadius.circular(3)),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
