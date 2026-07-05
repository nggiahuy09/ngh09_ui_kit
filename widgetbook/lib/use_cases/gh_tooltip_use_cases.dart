import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHTooltip].
WidgetbookComponent buildTooltipComponent() {
  return WidgetbookComponent(
    name: 'GHTooltip',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'Sizes', builder: _sizesUseCase),
      WidgetbookUseCase(name: 'Arrows', builder: _arrowsUseCase),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;

  final headline = knobs.string(
    label: 'Headline',
    initialValue: 'Here is a tooltip',
  );
  final supporting = knobs.string(
    label: 'Supporting text',
    initialValue:
        'Here is some helpful explainer text to assist or guide the user '
        'in understanding how a certain feature works.',
  );
  final showSupporting = knobs.boolean(label: 'Show supporting text');
  final size = knobs.object.dropdown<TooltipSize>(
    label: 'Size',
    options: TooltipSize.values,
    labelBuilder: (s) => s.name,
  );
  final corner = knobs.object.dropdown<TooltipCorner>(
    label: 'Corner',
    options: TooltipCorner.values,
    labelBuilder: (c) => c.name,
  );
  final arrow = knobs.object.dropdown<TooltipArrow>(
    label: 'Arrow',
    options: TooltipArrow.values,
    labelBuilder: (a) => a.name,
  );
  final showCloseButton = knobs.boolean(
    label: 'Show close button',
    initialValue: true,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: GHTooltip(
        headline: headline,
        supportingText: showSupporting ? supporting : null,
        size: size,
        corner: corner,
        arrow: arrow,
        showCloseButton: showCloseButton,
        onDismiss: () {},
      ),
    ),
  );
}

Widget _sizesUseCase(BuildContext context) {
  const supporting =
      'Here is some helpful explainer text to assist or guide the user in '
      'understanding how a certain feature works.';

  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final size in TooltipSize.values) ...[
          GHTooltip(
            headline: 'Here is a tooltip',
            size: size,
            onDismiss: () {},
          ),
          GHTooltip(
            headline: 'Here is a tooltip',
            supportingText: supporting,
            size: size,
            onDismiss: () {},
          ),
        ],
      ],
    ),
  );
}

Widget _arrowsUseCase(BuildContext context) {
  const supporting =
      'Here is some helpful explainer text to assist or guide the user in '
      'understanding how a certain feature works.';

  return SingleChildScrollView(
    padding: const EdgeInsets.all(48),
    child: Wrap(
      spacing: 32,
      runSpacing: 32,
      children: [
        for (final arrow in TooltipArrow.values)
          GHTooltip(
            headline: 'Here is a tooltip',
            supportingText: supporting,
            arrow: arrow,
            corner: TooltipCorner.smooth,
            onDismiss: () {},
          ),
      ],
    ),
  );
}
