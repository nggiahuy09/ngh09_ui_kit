import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

const List<({String label, GHIconData icon})> _trail = [
  (label: 'Home', icon: GHIcons.home),
  (label: 'Settings', icon: GHIcons.cog6Tooth),
  (label: 'Account', icon: GHIcons.userCircle),
  (label: 'Address Management', icon: GHIcons.map),
  (label: 'Edit Address', icon: GHIcons.pencilSquare),
  (label: 'Delete Address', icon: GHIcons.trash),
  (label: 'Confirm', icon: GHIcons.checkCircle),
  (label: 'Done', icon: GHIcons.flag),
];

/// A live playground for [GHBreadcrumbs]: pick a crumb type and an item
/// count (2 through 8) to demonstrate the trail's auto-collapse-at-5
/// behavior, with a spec string reflecting the choice.
class BreadcrumbsPlaygroundScreen extends StatefulWidget {
  const BreadcrumbsPlaygroundScreen({super.key});

  @override
  State<BreadcrumbsPlaygroundScreen> createState() => _BreadcrumbsPlaygroundScreenState();
}

class _BreadcrumbsPlaygroundScreenState extends State<BreadcrumbsPlaygroundScreen> {
  BreadcrumbType _type = BreadcrumbType.textAndIcon;
  int _itemCount = 3;

  void _reset() {
    setState(() {
      _type = BreadcrumbType.textAndIcon;
      _itemCount = 3;
    });
  }

  List<GHBreadcrumbItem> get _items {
    return [
      for (final entry in _trail.take(_itemCount)) GHBreadcrumbItem(label: entry.label, icon: GHHeroIcon(entry.icon), onTap: () {}),
    ];
  }

  String get _spec {
    final parts = <String>['items: <${_itemCount} items>'];
    if (_type != BreadcrumbType.textAndIcon) parts.add('type: ${_type.name}');
    return 'GHBreadcrumbs(${parts.join(', ')})';
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Breadcrumbs',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(child: GHBreadcrumbs(items: _items, type: _type)),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('TYPE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<BreadcrumbType>(
            selected: _type,
            onSelected: (v) => setState(() => _type = v),
            options: const [
              SegmentedPickerOption(value: BreadcrumbType.textAndIcon, label: 'Text & Icon'),
              SegmentedPickerOption(value: BreadcrumbType.onlyText, label: 'Only Text'),
              SegmentedPickerOption(value: BreadcrumbType.onlyIcon, label: 'Only Icon'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('ITEM COUNT'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<int>(
            pill: true,
            selected: _itemCount,
            onSelected: (v) => setState(() => _itemCount = v),
            options: [
              for (var i = 2; i <= _trail.length; i++) SegmentedPickerOption(value: i, label: '$i'),
            ],
          ),
        ],
      ),
    );
  }
}
