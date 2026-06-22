import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// One line per Material 3 type role.
class TypographyShowcase extends StatelessWidget {
  const TypographyShowcase({super.key});

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
