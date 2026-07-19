import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// The text input a playground screen uses to edit its live component's
/// label.
class LabelField extends StatelessWidget {
  const LabelField({required this.controller, required this.onChanged, super.key});

  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return TextField(
      controller: controller,
      onChanged: (_) => onChanged(),
      style: context.textStyles.bodyMedium.copyWith(color: colors.onSurface),
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: context.radii.borderRadiusMd,
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: context.radii.borderRadiusMd,
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: context.radii.borderRadiusMd,
          borderSide: BorderSide(color: colors.primary),
        ),
      ),
    );
  }
}
