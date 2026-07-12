import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// The shared screen shell for every Explorer screen: a back button, a title,
/// an optional trailing action (e.g. "Reset" or a metadata label), and a
/// scrollable body.
class ExplorerScaffold extends StatelessWidget {
  const ExplorerScaffold({required this.title, required this.body, this.trailing, super.key});

  /// The screen's title, shown next to the back button.
  final String title;

  /// The scrollable screen content.
  final Widget body;

  /// An optional trailing widget shown at the end of the header row.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final textStyles = context.textStyles;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(spacing.md, spacing.sm, spacing.md, spacing.smd),
              child: Row(
                children: [
                  _BackButton(onTap: () => Navigator.of(context).pop()),
                  SizedBox(width: spacing.smd),
                  Expanded(
                    child: Text(
                      title,
                      style: textStyles.titleLarge.copyWith(color: colors.onBackground, fontWeight: FontWeight.w700),
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

/// A muted, monospace metadata label shown in an [ExplorerScaffold]'s
/// trailing slot, e.g. "8 tokens".
class ExplorerMeta extends StatelessWidget {
  const ExplorerMeta(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.jetBrainsMono(fontSize: 11, color: context.colors.onSurfaceVariant),
    );
  }
}

/// The eyebrow section header used above grouped lists ("COMPONENTS",
/// "VARIANT", "SIZE", ...).
class ExplorerEyebrow extends StatelessWidget {
  const ExplorerEyebrow(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.jetBrainsMono(
        fontSize: 10.5,
        letterSpacing: 1.4,
        color: context.colors.onSurfaceVariant.withValues(alpha: 0.8),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.surface,
      borderRadius: context.radii.borderRadiusMd,
      child: InkWell(
        onTap: onTap,
        borderRadius: context.radii.borderRadiusMd,
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: context.radii.borderRadiusMd,
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Icon(Icons.chevron_left, color: colors.onSurfaceVariant),
        ),
      ),
    );
  }
}
