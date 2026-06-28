import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHUserAvatar].
WidgetbookComponent buildUserAvatarComponent() {
  return WidgetbookComponent(
    name: 'GHUserAvatar',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'All variants', builder: _allVariantsUseCase),
      WidgetbookUseCase(name: 'Sizes', builder: _sizesUseCase),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final variant = context.knobs.object.dropdown<GHAvatarVariant>(
    label: 'Variant',
    options: GHAvatarVariant.values,
    initialOption: GHAvatarVariant.v01,
    labelBuilder: (v) => v.name,
  );
  final size = context.knobs.double.slider(label: 'Size', initialValue: 40, min: 24, max: 128);

  return Center(child: GHUserAvatar(variant, size: size));
}

Widget _allVariantsUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final variant in GHAvatarVariant.values) GHUserAvatar(variant, size: 48),
      ],
    ),
  );
}

Widget _sizesUseCase(BuildContext context) {
  const sizes = <double>[24, 32, 40, 48, 64, 96];
  return Center(
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final size in sizes) GHUserAvatar(GHAvatarVariant.v01, size: size),
      ],
    ),
  );
}
