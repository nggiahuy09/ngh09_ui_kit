import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// A tappable row on the Explorer home screen: a leading icon swatch, a
/// title/subtitle pair, and a trailing chevron.
class ComponentListTile extends StatelessWidget {
  const ComponentListTile({required this.title, required this.subtitle, required this.leading, required this.onTap, super.key});

  /// The row's title, e.g. "Buttons".
  final String title;

  /// The row's subtitle, e.g. "5 variants · 5 sizes · icons & states".
  final String subtitle;

  /// The 46x46 leading preview swatch.
  final Widget leading;

  /// Called when the row is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final textStyles = context.textStyles;

    return Material(
      color: colors.surface,
      borderRadius: context.radii.borderRadiusLg,
      child: InkWell(
        onTap: onTap,
        borderRadius: context.radii.borderRadiusLg,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spacing.md, vertical: spacing.smd),
          decoration: BoxDecoration(
            borderRadius: context.radii.borderRadiusLg,
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Row(
            children: [
              SizedBox(width: 46, height: 46, child: leading),
              SizedBox(width: spacing.smd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: textStyles.titleSmall.copyWith(fontWeight: FontWeight.w600, color: colors.onSurface),
                    ),
                    SizedBox(height: spacing.xxs),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(fontSize: 12, color: colors.onSurfaceVariant),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: colors.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
