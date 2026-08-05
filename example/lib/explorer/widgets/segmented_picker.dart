import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// A single option in a [SegmentedPicker].
class SegmentedPickerOption<T> {
  const SegmentedPickerOption({required this.value, required this.label});

  /// The value this option represents.
  final T value;

  /// The text shown for this option.
  final String label;
}

/// A row of mutually-exclusive pill options, used for VARIANT / SIZE / STATE / COLOR / SHAPE / KIND pickers in the playground screens.
///
/// [pill] renders each option as a standalone rounded pill (used for multi-row-wrapping choices like button variant); otherwise options are laid out as equal-width segments inside a single track (used for compact choices like size/state).
class SegmentedPicker<T> extends StatelessWidget {
  const SegmentedPicker({required this.options, required this.selected, required this.onSelected, this.pill = false, super.key});

  /// The options to render.
  final List<SegmentedPickerOption<T>> options;

  /// The currently-selected value.
  final T selected;

  /// Called with the newly-selected value.
  final ValueChanged<T> onSelected;

  /// Whether to render as wrapping standalone pills instead of a single
  /// equal-width track.
  final bool pill;

  @override
  Widget build(BuildContext context) {
    if (pill) {
      return Wrap(
        spacing: context.spacing.sm,
        runSpacing: context.spacing.sm,
        children: [
          for (final option in options)
            _Pill(
              label: option.label,
              active: option.value == selected,
              onTap: () => onSelected(option.value),
            ),
        ],
      );
    }

    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: context.radii.borderRadiusMd,
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          for (final option in options)
            Expanded(
              child: _Segment(label: option.label, active: option.value == selected, onTap: () => onSelected(option.value)),
            ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.active, required this.onTap});

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: active ? colors.primary : colors.surface,
      borderRadius: context.radii.borderRadiusFull,
      child: InkWell(
        onTap: onTap,
        borderRadius: context.radii.borderRadiusFull,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: context.radii.borderRadiusFull,
            border: Border.all(color: active ? colors.primary : colors.outlineVariant),
          ),
          child: Text(
            label,
            style: context.textStyles.labelMedium.copyWith(fontWeight: FontWeight.w600, color: active ? colors.onPrimary : colors.onSurfaceVariant),
          ),
        ),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.label, required this.active, required this.onTap});

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: active ? colors.primaryContainer : Colors.transparent,
      borderRadius: context.radii.borderRadiusSm,
      child: InkWell(
        onTap: onTap,
        borderRadius: context.radii.borderRadiusSm,
        child: Container(
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: context.radii.borderRadiusSm),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: context.textStyles.labelMedium.copyWith(fontWeight: FontWeight.w600, color: active ? colors.onPrimaryContainer : colors.onSurfaceVariant),
          ),
        ),
      ),
    );
  }
}
