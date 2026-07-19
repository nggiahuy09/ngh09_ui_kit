import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_app/explorer/explorer_scaffold.dart';

class _TypeRole {
  const _TypeRole(this.name, this.style);

  final String name;
  final TextStyle style;
}

/// A static reference list of the kit's 15 typography roles, read live from
/// [GHAppTypography] rather than fixed pixel values.
class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final t = context.textStyles;

    final roles = [
      _TypeRole('Display Large', t.displayLarge),
      _TypeRole('Display Medium', t.displayMedium),
      _TypeRole('Display Small', t.displaySmall),
      _TypeRole('Headline Large', t.headlineLarge),
      _TypeRole('Headline Medium', t.headlineMedium),
      _TypeRole('Headline Small', t.headlineSmall),
      _TypeRole('Title Large', t.titleLarge),
      _TypeRole('Title Medium', t.titleMedium),
      _TypeRole('Title Small', t.titleSmall),
      _TypeRole('Body Large', t.bodyLarge),
      _TypeRole('Body Medium', t.bodyMedium),
      _TypeRole('Body Small', t.bodySmall),
      _TypeRole('Label Large', t.labelLarge),
      _TypeRole('Label Medium', t.labelMedium),
      _TypeRole('Label Small', t.labelSmall),
    ];

    return ExplorerScaffold(
      title: 'Typography',
      trailing: const ExplorerMeta('15 styles'),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        itemCount: roles.length,
        separatorBuilder: (context, index) => Divider(height: 1, color: colors.outlineVariant),
        itemBuilder: (context, index) {
          final role = roles[index];
          final size = role.style.fontSize!.clamp(0, 34).toDouble();
          final weight = role.style.fontWeight!.value;

          return Padding(
            padding: EdgeInsets.symmetric(vertical: spacing.smd),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Text(
                    role.name,
                    overflow: TextOverflow.ellipsis,
                    style: role.style.copyWith(fontSize: size, color: colors.onBackground),
                  ),
                ),
                Text(
                  '${role.style.fontSize!.toStringAsFixed(0)} · $weight',
                  style: GoogleFonts.jetBrainsMono(fontSize: 10.5, color: colors.onSurfaceVariant),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
