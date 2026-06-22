import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

/// Every [GHAppChip] variant with live selection / deletion.
class ChipsShowcase extends StatefulWidget {
  const ChipsShowcase({super.key});

  @override
  State<ChipsShowcase> createState() => _ChipsShowcaseState();
}

class _ChipsShowcaseState extends State<ChipsShowcase> {
  final List<String> _tags = ['design', 'flutter', 'ui-kit'];
  final Set<String> _filters = {'Unread'};
  String _choice = 'Medium';

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    const filters = ['Unread', 'Starred', 'Archived'];
    const choices = ['Low', 'Medium', 'High'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input chips — deletable tags.
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: [
            for (final tag in _tags)
              GHAppChip.input(
                label: tag,
                leading: const Icon(Icons.tag),
                onDeleted: () => setState(() => _tags.remove(tag)),
              ),
          ],
        ),
        SizedBox(height: spacing.md),
        // Filter chips — multi-select.
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: [
            for (final filter in filters)
              GHAppChip.filter(
                label: filter,
                selected: _filters.contains(filter),
                onSelected: (selected) => setState(() {
                  if (selected) {
                    _filters.add(filter);
                  } else {
                    _filters.remove(filter);
                  }
                }),
              ),
          ],
        ),
        SizedBox(height: spacing.md),
        // Choice chips — single-select.
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: [
            for (final choice in choices)
              GHAppChip.choice(
                label: choice,
                selected: _choice == choice,
                onSelected: (_) => setState(() => _choice = choice),
              ),
          ],
        ),
        SizedBox(height: spacing.md),
        // Expanded chip — stretches to the full available width.
        GHAppChip.filter(
          label: 'Expanded',
          selected: true,
          expanded: true,
          onSelected: (_) {},
        ),
      ],
    );
  }
}
