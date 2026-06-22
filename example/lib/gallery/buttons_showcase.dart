import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Every [GHAppButton] variant, size and state.
class ButtonsShowcase extends StatelessWidget {
  const ButtonsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: [
            for (final variant in ButtonVariant.values)
              GHAppButton(
                label: variant.name,
                variant: variant,
                onPressed: () {},
              ),
          ],
        ),
        SizedBox(height: spacing.md),
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final size in ButtonSize.values)
              GHAppButton(label: size.name, size: size, onPressed: () {}),
          ],
        ),
        SizedBox(height: spacing.md),
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: [
            GHAppButton(
              label: 'With icons',
              leading: const Icon(Icons.check),
              trailing: const Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
            const GHAppButton(label: 'Disabled'),
            GHAppButton(label: 'Loading', isLoading: true, onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
