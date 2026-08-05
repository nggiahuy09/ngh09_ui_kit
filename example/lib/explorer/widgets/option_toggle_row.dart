import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// A row with a title/subtitle pair and a trailing switch, used for the icon/expanded/selected/dismissible toggles in the playground screens.
class OptionToggleRow extends StatelessWidget {
  const OptionToggleRow({required this.title, required this.subtitle, required this.value, required this.onChanged, super.key});

  /// The toggle's title, e.g. "Leading icon".
  final String title;

  /// The toggle's description, e.g. "Icons.check before the label".
  final String subtitle;

  /// The current on/off state.
  final bool value;

  /// Called with the next state when tapped.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final textStyles = context.textStyles;

    return Material(
      color: colors.surface,
      borderRadius: context.radii.borderRadiusMd,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: context.radii.borderRadiusMd,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spacing.smd, vertical: spacing.sm),
          decoration: BoxDecoration(
            borderRadius: context.radii.borderRadiusMd,
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: textStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: colors.onSurface),
                    ),
                    SizedBox(height: spacing.xxs),
                    Text(subtitle, style: textStyles.bodySmall.copyWith(color: colors.onSurfaceVariant)),
                  ],
                ),
              ),
              Switch(value: value, onChanged: onChanged, activeTrackColor: colors.success),
            ],
          ),
        ),
      ),
    );
  }
}
