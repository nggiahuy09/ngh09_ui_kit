import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppInputDropdown].
WidgetbookComponent buildAppInputDropdownComponent() {
  return WidgetbookComponent(
    name: 'GHAppInputDropdown',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
    ],
  );
}

const List<GHDropdownMenuItem<String>> _workAreas = [
  GHDropdownMenuItem(value: 'healthcare', label: 'Healthcare'),
  GHDropdownMenuItem(value: 'fintech', label: 'Fintech'),
  GHDropdownMenuItem(value: 'agriculture', label: 'Agriculture'),
  GHDropdownMenuItem(value: 'sports', label: 'Sports'),
  GHDropdownMenuItem(value: 'news', label: 'News'),
  GHDropdownMenuItem(value: 'tourism', label: 'Tourism'),
];

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;
  final searchable = knobs.boolean(label: 'Searchable', initialValue: true);
  final disabled = knobs.boolean(label: 'Disabled');

  return Center(
    child: SizedBox(
      width: 280,
      child: GHAppInputDropdown<String>(
        placeholder: 'Select Work Area',
        items: _workAreas,
        searchable: searchable,
        onChanged: disabled ? null : (_) {},
      ),
    ),
  );
}
