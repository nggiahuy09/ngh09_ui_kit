import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Rounded boxes for each radius step.
class RadiiShowcase extends StatelessWidget {
  const RadiiShowcase({super.key});

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
