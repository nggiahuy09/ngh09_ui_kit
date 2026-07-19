import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';

class _ColorToken {
  const _ColorToken(this.name, this.background, this.foreground);
  final String name;
  final Color background;
  final Color foreground;
}

/// A static reference grid of the kit's semantic color roles, read live from
/// [GHAppColors] rather than hardcoded hex values.
class ColorsScreen extends StatelessWidget {
  const ColorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    final tokens = [
      _ColorToken('primary', colors.primary, colors.onPrimary),
      _ColorToken('primaryContainer', colors.primaryContainer, colors.onPrimaryContainer),
      _ColorToken('surface', colors.surface, colors.onSurface),
      _ColorToken('surfaceVariant', colors.surfaceVariant, colors.onSurfaceVariant),
      _ColorToken('success', colors.success, colors.onSuccess),
      _ColorToken('warning', colors.warning, colors.onWarning),
      _ColorToken('danger', colors.danger, colors.onDanger),
      _ColorToken('info', colors.info, colors.onInfo),
    ];

    return ExplorerScaffold(
      title: 'Colors',
      trailing: const ExplorerMeta('8 tokens'),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.4,
        ),
        itemCount: tokens.length,
        itemBuilder: (context, index) {
          final token = tokens[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: spacing.smd, vertical: spacing.sm),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              color: token.background,
              borderRadius: context.radii.borderRadiusLg,
              border: Border.all(color: colors.outlineVariant),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  token.name,
                  style: context.textStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: token.foreground),
                ),
                SizedBox(height: spacing.xxs),
                Text(
                  '#${_hex(token.background)}',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10.5,
                    color: token.foreground.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

String _hex(Color color) => color.toARGB32().toRadixString(16).substring(2).toUpperCase();
