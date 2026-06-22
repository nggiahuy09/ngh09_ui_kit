import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Every [GHAppBadge] status and shape.
class BadgesShowcase extends StatelessWidget {
  const BadgesShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final status in BadgeStatus.values)
              GHAppBadge(label: status.name, status: status),
          ],
        ),
        SizedBox(height: spacing.md),
        Wrap(
          spacing: spacing.md,
          runSpacing: spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const GHAppBadge(label: 'New', status: BadgeStatus.info),
            GHAppBadge.count(count: 128, max: 99, status: BadgeStatus.danger),
            const GHAppBadge.dot(status: BadgeStatus.success),
          ],
        ),
        SizedBox(height: spacing.md),
        const GHAppBadge(
          label: 'Expanded',
          status: BadgeStatus.warning,
          expanded: true,
        ),
      ],
    );
  }
}
