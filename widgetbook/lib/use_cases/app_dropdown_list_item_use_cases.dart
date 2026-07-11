import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppDropdownListItem].
WidgetbookComponent buildAppDropdownListItemComponent() {
  return WidgetbookComponent(
    name: 'GHAppDropdownListItem',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'Leading types', builder: _leadingTypesUseCase),
      WidgetbookUseCase(name: 'Trailing types', builder: _trailingTypesUseCase),
      WidgetbookUseCase(name: 'States', builder: _statesUseCase),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;
  final leadingType = knobs.object.dropdown<GHDropdownLeadingType>(
    label: 'Leading type',
    options: GHDropdownLeadingType.values,
    initialOption: GHDropdownLeadingType.icon,
    labelBuilder: (v) => v.name,
  );
  final trailingType = knobs.object.dropdown<GHDropdownTrailingType>(
    label: 'Trailing type',
    options: GHDropdownTrailingType.values,
    initialOption: GHDropdownTrailingType.chevron,
    labelBuilder: (v) => v.name,
  );
  final size = knobs.object.dropdown<GHDropdownItemSize>(
    label: 'Size',
    options: GHDropdownItemSize.values,
    initialOption: GHDropdownItemSize.medium,
    labelBuilder: (v) => v.name,
  );
  final showSupportingText = knobs.boolean(
    label: 'Supporting text',
    initialValue: true,
  );
  final selected = knobs.boolean(label: 'Selected');
  final disabled = knobs.boolean(label: 'Disabled');

  return Center(
    child: SizedBox(
      width: 320,
      child: GHAppDropdownListItem(
        label: 'Hussain Imtiaz',
        supportingText: showSupportingText ? '@finesse' : null,
        leadingType: leadingType,
        leadingIcon: leadingType == GHDropdownLeadingType.icon ? GHIcons.userCircle : null,
        leading: switch (leadingType) {
          GHDropdownLeadingType.avatar => const GHUserAvatar.initials('HI', size: GHAvatarSize.sm),
          GHDropdownLeadingType.flag => const GHCountryFlag(GHCountry.unitedStates, size: 20),
          _ => null,
        },
        trailingType: trailingType,
        trailingLabel: trailingType == GHDropdownTrailingType.label ? '1' : null,
        selected: selected,
        size: size,
        onTap: disabled ? null : () {},
      ),
    ),
  );
}

Widget _leadingTypesUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GHAppDropdownListItem(label: 'No leading', onTap: () {}),
          GHAppDropdownListItem(
            label: 'Icon leading',
            leadingType: GHDropdownLeadingType.icon,
            leadingIcon: GHIcons.userCircle,
            onTap: () {},
          ),
          GHAppDropdownListItem(
            label: 'Hussain Imtiaz',
            supportingText: '@finesse',
            leadingType: GHDropdownLeadingType.avatar,
            leading: const GHUserAvatar.initials('HI', size: GHAvatarSize.sm),
            onTap: () {},
          ),
          GHAppDropdownListItem(
            label: 'United States',
            leadingType: GHDropdownLeadingType.flag,
            leading: const GHCountryFlag(GHCountry.unitedStates, size: 20),
            onTap: () {},
          ),
          GHAppDropdownListItem(
            label: 'Checklist item',
            leadingType: GHDropdownLeadingType.checkbox,
            selected: true,
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}

Widget _trailingTypesUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GHAppDropdownListItem(label: 'No trailing', onTap: () {}),
          GHAppDropdownListItem(
            label: 'Address',
            trailingType: GHDropdownTrailingType.chevron,
            onTap: () {},
          ),
          GHAppDropdownListItem(
            label: 'Ali Osama',
            trailingType: GHDropdownTrailingType.checkmark,
            selected: true,
            onTap: () {},
          ),
          GHAppDropdownListItem(
            label: 'Biometric Authentication',
            trailingType: GHDropdownTrailingType.toggle,
            toggleValue: true,
            onToggleChanged: (_) {},
            onTap: () {},
          ),
          GHAppDropdownListItem(
            label: 'Notifications',
            trailingType: GHDropdownTrailingType.label,
            trailingLabel: '1',
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}

Widget _statesUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GHAppDropdownListItem(label: 'Active', onTap: () {}),
          GHAppDropdownListItem(
            label: 'Selected',
            selected: true,
            onTap: () {},
          ),
          const GHAppDropdownListItem(label: 'Disabled'),
        ],
      ),
    ),
  );
}
