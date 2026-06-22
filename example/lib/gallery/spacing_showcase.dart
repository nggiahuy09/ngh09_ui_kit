import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Visual bars for each spacing step.
class SpacingShowcase extends StatelessWidget {
  const SpacingShowcase({super.key});

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
