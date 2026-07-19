import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:ngh09_ui_kit_example/explorer/explorer_scaffold.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/preview_card.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/segmented_picker.dart';
import 'package:ngh09_ui_kit_example/explorer/widgets/spec_panel.dart';

enum _LeadingTrailingCombo { iconChevron, avatarCheckmark, flagLabel, checkboxNone, iconToggle }

/// A live playground for the [GHAppDropdown] family: a composed
/// [GHAppDropdownList] with a header and several [GHAppDropdownListItem]
/// entries, where one sample item's leading/trailing combo and size can be
/// swapped live, with a spec string reflecting the sample item's choice.
class DropdownPlaygroundScreen extends StatefulWidget {
  const DropdownPlaygroundScreen({super.key});

  @override
  State<DropdownPlaygroundScreen> createState() => _DropdownPlaygroundScreenState();
}

class _DropdownPlaygroundScreenState extends State<DropdownPlaygroundScreen> {
  _LeadingTrailingCombo _combo = _LeadingTrailingCombo.iconChevron;
  GHDropdownItemSize _size = GHDropdownItemSize.medium;
  bool _sampleSelected = false;
  bool _sampleToggleValue = true;

  void _reset() {
    setState(() {
      _combo = _LeadingTrailingCombo.iconChevron;
      _size = GHDropdownItemSize.medium;
      _sampleSelected = false;
      _sampleToggleValue = true;
    });
  }

  String get _spec {
    final parts = <String>["label: 'Sample Item'", 'size: ${_size.name}'];
    switch (_combo) {
      case _LeadingTrailingCombo.iconChevron:
        parts.add('leadingType: icon, leadingIcon: GHIcons.userCircle');
        parts.add('trailingType: chevron');
      case _LeadingTrailingCombo.avatarCheckmark:
        parts.add('leadingType: avatar, leading: GHUserAvatar.initials(...)');
        parts.add('trailingType: checkmark, selected: $_sampleSelected');
      case _LeadingTrailingCombo.flagLabel:
        parts.add('leadingType: flag, leading: GHCountryFlag(...)');
        parts.add("trailingType: label, trailingLabel: 'New'");
      case _LeadingTrailingCombo.checkboxNone:
        parts.add('leadingType: checkbox, selected: $_sampleSelected');
      case _LeadingTrailingCombo.iconToggle:
        parts.add('leadingType: icon, leadingIcon: GHIcons.bell');
        parts.add('trailingType: toggle, toggleValue: $_sampleToggleValue');
    }
    return 'GHAppDropdownListItem(${parts.join(', ')})';
  }

  GHAppDropdownListItem get _sampleItem {
    switch (_combo) {
      case _LeadingTrailingCombo.iconChevron:
        return GHAppDropdownListItem(
          label: 'Sample Item',
          leadingType: GHDropdownLeadingType.icon,
          leadingIcon: GHIcons.userCircle,
          trailingType: GHDropdownTrailingType.chevron,
          size: _size,
          onTap: () {},
        );
      case _LeadingTrailingCombo.avatarCheckmark:
        return GHAppDropdownListItem(
          label: 'Sample Item',
          leadingType: GHDropdownLeadingType.avatar,
          leading: const GHUserAvatar.initials('SI', size: GHAvatarSize.sm),
          trailingType: GHDropdownTrailingType.checkmark,
          selected: _sampleSelected,
          size: _size,
          onTap: () => setState(() => _sampleSelected = !_sampleSelected),
        );
      case _LeadingTrailingCombo.flagLabel:
        return GHAppDropdownListItem(
          label: 'Sample Item',
          leadingType: GHDropdownLeadingType.flag,
          leading: const GHCountryFlag(GHCountry.japan, size: 20),
          trailingType: GHDropdownTrailingType.label,
          trailingLabel: 'New',
          size: _size,
          onTap: () {},
        );
      case _LeadingTrailingCombo.checkboxNone:
        return GHAppDropdownListItem(
          label: 'Sample Item',
          leadingType: GHDropdownLeadingType.checkbox,
          selected: _sampleSelected,
          size: _size,
          onTap: () => setState(() => _sampleSelected = !_sampleSelected),
        );
      case _LeadingTrailingCombo.iconToggle:
        return GHAppDropdownListItem(
          label: 'Sample Item',
          leadingType: GHDropdownLeadingType.icon,
          leadingIcon: GHIcons.bell,
          trailingType: GHDropdownTrailingType.toggle,
          toggleValue: _sampleToggleValue,
          onToggleChanged: (v) => setState(() => _sampleToggleValue = v),
          size: _size,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ExplorerScaffold(
      title: 'Dropdown',
      trailing: TextButton(onPressed: _reset, child: const Text('Reset')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing.md).copyWith(bottom: spacing.xl),
        children: [
          PreviewCard(
            child: GHAppDropdown(
              width: 300,
              sections: [
                GHAppDropdownList(
                  header: 'Account',
                  showDivider: true,
                  items: [
                    _sampleItem,
                    GHAppDropdownListItem(
                      label: 'Security',
                      leadingType: GHDropdownLeadingType.icon,
                      leadingIcon: GHIcons.shieldCheck,
                      trailingType: GHDropdownTrailingType.chevron,
                      size: _size,
                      onTap: () {},
                    ),
                  ],
                ),
                GHAppDropdownList(
                  header: 'Help',
                  items: [
                    GHAppDropdownListItem(
                      label: 'FAQs',
                      leadingType: GHDropdownLeadingType.icon,
                      leadingIcon: GHIcons.questionMarkCircle,
                      trailingType: GHDropdownTrailingType.chevron,
                      size: _size,
                      onTap: () {},
                    ),
                    GHAppDropdownListItem(
                      label: 'Contact Us',
                      leadingType: GHDropdownLeadingType.icon,
                      leadingIcon: GHIcons.chatBubbleLeftRight,
                      size: _size,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          SpecPanel(spec: _spec),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('SAMPLE ITEM COMBO'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<_LeadingTrailingCombo>(
            pill: true,
            selected: _combo,
            onSelected: (v) => setState(() => _combo = v),
            options: const [
              SegmentedPickerOption(value: _LeadingTrailingCombo.iconChevron, label: 'Icon / Chevron'),
              SegmentedPickerOption(value: _LeadingTrailingCombo.avatarCheckmark, label: 'Avatar / Checkmark'),
              SegmentedPickerOption(value: _LeadingTrailingCombo.flagLabel, label: 'Flag / Label'),
              SegmentedPickerOption(value: _LeadingTrailingCombo.checkboxNone, label: 'Checkbox / None'),
              SegmentedPickerOption(value: _LeadingTrailingCombo.iconToggle, label: 'Icon / Toggle'),
            ],
          ),
          SizedBox(height: spacing.lg),
          const ExplorerEyebrow('ITEM SIZE'),
          SizedBox(height: spacing.sm),
          SegmentedPicker<GHDropdownItemSize>(
            selected: _size,
            onSelected: (v) => setState(() => _size = v),
            options: const [
              SegmentedPickerOption(value: GHDropdownItemSize.small, label: 'Small'),
              SegmentedPickerOption(value: GHDropdownItemSize.medium, label: 'Medium'),
              SegmentedPickerOption(value: GHDropdownItemSize.large, label: 'Large'),
            ],
          ),
        ],
      ),
    );
  }
}
