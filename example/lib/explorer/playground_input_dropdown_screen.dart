import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/label_field.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/option_toggle_row.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

const _fruits = [
  'Apple',
  'Banana',
  'Cherry',
  'Dragonfruit',
  'Elderberry',
  'Fig',
  'Grape',
  'Honeydew',
];

/// A live playground for [GHAppInputDropdown]: pick a fruit from a real
/// searchable list, toggle whether search is enabled, and edit the
/// placeholder, with a spec string reflecting the choice.
class InputDropdownPlaygroundScreen extends StatefulWidget {
  const InputDropdownPlaygroundScreen({super.key});

  @override
  State<InputDropdownPlaygroundScreen> createState() => _InputDropdownPlaygroundScreenState();
}

class _InputDropdownPlaygroundScreenState extends State<InputDropdownPlaygroundScreen> {
  bool _searchable = true;
  String? _value;
  final _placeholderController = TextEditingController(text: 'Search');

  @override
  void dispose() {
    _placeholderController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _searchable = true;
      _value = null;
      _placeholderController.text = 'Search';
    });
  }

  String get _placeholder => _placeholderController.text;

  List<GHDropdownMenuItem<String>> get _items => [
    for (final fruit in _fruits) GHDropdownMenuItem<String>(value: fruit, label: fruit),
  ];

  String get _spec {
    final parts = <String>['items: <8 fruits>'];
    if (_placeholder.isNotEmpty && _placeholder != 'Search') parts.add("placeholder: '$_placeholder'");
    if (!_searchable) parts.add('searchable: false');
    parts.add('onChanged: (v) => ...');
    return 'GHAppInputDropdown<String>(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Input Dropdown',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GHAppInputDropdown<String>(
                  items: _items,
                  placeholder: _placeholder.isEmpty ? 'Search' : _placeholder,
                  searchable: _searchable,
                  width: 280,
                  onChanged: (v) => setState(() => _value = v),
                ),
                if (_value != null) ...[
                  SizedBox(height: spacing.sm),
                  Text(
                    'Selected: $_value',
                    style: context.textStyles.bodySmall.copyWith(color: context.colors.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('OPTIONS'),
          SizedBox(height: spacing.sm),
          OptionToggleRow(
            title: 'Searchable',
            subtitle: 'Show a search field to filter items',
            value: _searchable,
            onChanged: (v) => setState(() => _searchable = v),
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('PLACEHOLDER'),
          SizedBox(height: spacing.sm),
          LabelField(
            controller: _placeholderController,
            onChanged: () => setState(() {}),
          ),
        ],
      ),
    );
  }
}
