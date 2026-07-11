import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppDropdownButton].
WidgetbookComponent buildAppDropdownButtonComponent() {
  return WidgetbookComponent(
    name: 'GHAppDropdownButton',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
    ],
  );
}

const List<GHDropdownMenuItem<String>> _countries = [
  GHDropdownMenuItem(value: 'us', label: 'United States'),
  GHDropdownMenuItem(value: 'uk', label: 'United Kingdom'),
  GHDropdownMenuItem(value: 'ca', label: 'Canada'),
  GHDropdownMenuItem(value: 'au', label: 'Australia'),
];

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;
  final disabled = knobs.boolean(label: 'Disabled');

  return _StatefulPlayground(disabled: disabled);
}

class _StatefulPlayground extends StatefulWidget {
  const _StatefulPlayground({required this.disabled});

  final bool disabled;

  @override
  State<_StatefulPlayground> createState() => _StatefulPlaygroundState();
}

class _StatefulPlaygroundState extends State<_StatefulPlayground> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 280,
        child: GHAppDropdownButton<String>(
          placeholder: 'Select a country',
          items: _countries,
          value: _value,
          onChanged: widget.disabled ? null : (v) => setState(() => _value = v),
        ),
      ),
    );
  }
}
