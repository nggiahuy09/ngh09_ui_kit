import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppAlert].
WidgetbookComponent buildAppAlertComponent() {
  return WidgetbookComponent(
    name: 'GHAppAlert',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'All states', builder: _allStatesUseCase),
      WidgetbookUseCase(
        name: 'Smooth corners',
        builder: _smoothCornersUseCase,
      ),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;

  final state = knobs.object.dropdown<GHAlertState>(
    label: 'State',
    options: GHAlertState.values,
    labelBuilder: (s) => s.name,
  );
  final headline = knobs.string(label: 'Headline', initialValue: 'Alert headline text');
  final supporting = knobs.string(
    label: 'Supporting text',
    initialValue:
        'Here is some supporting text for the user to better understand '
        'what the alert is all about.',
  );
  final showSupporting = knobs.boolean(label: 'Show supporting text', initialValue: true);
  final showAction = knobs.boolean(label: 'Show action', initialValue: true);
  final showDismiss = knobs.boolean(label: 'Show dismiss', initialValue: true);
  final showIcon = knobs.boolean(label: 'Show icon', initialValue: true);
  final smooth = knobs.boolean(label: 'Smooth corners');

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: GHAppAlert(
        headline: headline,
        state: state,
        supportingText: showSupporting ? supporting : null,
        onAction: showAction ? () {} : null,
        onDismiss: showDismiss ? () {} : null,
        showLeadingIcon: showIcon,
        smooth: smooth,
      ),
    ),
  );
}

Widget _allStatesUseCase(BuildContext context) {
  const supporting =
      'Here is some supporting text for the user to better understand '
      'what the alert is all about. Describe what has happened.';

  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      spacing: 16,
      children: [
        for (final state in GHAlertState.values)
          GHAppAlert(
            headline: 'Alert headline text',
            state: state,
            supportingText: supporting,
            onAction: () {},
            onDismiss: () {},
          ),
      ],
    ),
  );
}

Widget _smoothCornersUseCase(BuildContext context) {
  const supporting =
      'Here is some supporting text for the user to better understand '
      'what the alert is all about. Describe what has happened.';

  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      spacing: 16,
      children: [
        for (final state in GHAlertState.values)
          GHAppAlert(
            headline: 'Alert headline text',
            state: state,
            supportingText: supporting,
            onAction: () {},
            onDismiss: () {},
            smooth: true,
          ),
      ],
    ),
  );
}
