import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Every [GHAppBadge] color, type, size and corner shape.
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
            for (final color in BadgeColor.values) GHAppBadge(label: color.name, color: color),
          ],
        ),
        SizedBox(height: spacing.md),
        Wrap(
          spacing: spacing.md,
          runSpacing: spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const GHAppBadge(label: 'Simple'),
            const GHAppBadge.dot(label: 'Live', color: BadgeColor.success),
            GHAppBadge.icon(label: 'Verified', leadingIcon: const Icon(Icons.check), color: BadgeColor.warning),
            const GHAppBadge.avatar(label: 'Avatar', avatar: FlutterLogo()),
            GHAppBadge.flag(label: 'US', country: GHCountry.unitedStates, color: BadgeColor.error),
            GHAppBadge.count(count: 128, max: 99, color: BadgeColor.error),
          ],
        ),
        SizedBox(height: spacing.md),
        const GHAppBadge(label: 'Expanded', color: BadgeColor.warning, expanded: true),
        SizedBox(height: spacing.md),
        Wrap(
          spacing: spacing.md,
          runSpacing: spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final corner in BadgeCorner.values) GHAppBadge(label: corner.name, corner: corner),
          ],
        ),
      ],
    );
  }
}
