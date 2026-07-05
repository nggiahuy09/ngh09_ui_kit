import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHCrumb].
WidgetbookComponent buildCrumbComponent() {
  return WidgetbookComponent(
    name: 'GHCrumb',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'Types & states', builder: _typesAndStatesUseCase),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;

  final label = knobs.string(label: 'Label', initialValue: 'Home');
  final showLabel = knobs.boolean(label: 'Show label', initialValue: true);
  final showIcon = knobs.boolean(label: 'Show icon', initialValue: true);
  final showTrailingIcon = knobs.boolean(label: 'Show trailing icon');
  final active = knobs.boolean(label: 'Active', initialValue: true);

  return Center(
    child: GHCrumb(
      label: showLabel ? label : null,
      icon: showIcon ? const GHHeroIcon(GHIcons.home) : null,
      trailingIcon: showTrailingIcon ? const GHHeroIcon(GHIcons.arrowRight) : null,
      active: active,
      onTap: () {},
    ),
  );
}

Widget _typesAndStatesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 24,
      children: [
        for (final active in [true, false])
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 48,
            children: [
              GHCrumb(
                label: 'Home',
                icon: const GHHeroIcon(GHIcons.home),
                trailingIcon: const GHHeroIcon(GHIcons.arrowRight),
                active: active,
              ),
              GHCrumb(icon: const GHHeroIcon(GHIcons.home), active: active),
              GHCrumb(label: '...', active: active),
            ],
          ),
      ],
    ),
  );
}
