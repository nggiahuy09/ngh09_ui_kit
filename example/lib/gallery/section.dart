import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// A titled section wrapper with consistent vertical rhythm.
class Section extends StatelessWidget {
  const Section({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    return Padding(
      padding: EdgeInsets.only(bottom: spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textStyles.headlineSmall.copyWith(
              color: context.colors.onBackground,
            ),
          ),
          SizedBox(height: spacing.sm),
          Divider(color: context.colors.outlineVariant),
          SizedBox(height: spacing.md),
          child,
        ],
      ),
    );
  }
}
