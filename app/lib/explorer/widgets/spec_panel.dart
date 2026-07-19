import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// A monospace panel showing the constructor call that reproduces the
/// current playground selection, e.g. `GHAppButton(variant: filled, ...)`.
class SpecPanel extends StatelessWidget {
  const SpecPanel({required this.spec, super.key});

  /// The spec string to display.
  final String spec;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: spacing.sm),
      padding: EdgeInsets.symmetric(horizontal: spacing.smd, vertical: spacing.sm),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: context.radii.borderRadiusMd,
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Text(
        spec,
        style: GoogleFonts.jetBrainsMono(fontSize: 11, height: 1.5, color: colors.onSurfaceVariant),
      ),
    );
  }
}
