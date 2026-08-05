import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// The dotted-grid preview card a playground screen renders its live component inside of.
class PreviewCard extends StatelessWidget {
  const PreviewCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 180),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: context.spacing.xl, horizontal: context.spacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: context.radii.borderRadiusLg,
        border: Border.all(color: colors.outlineVariant),
      ),
      child: child,
    );
  }
}
