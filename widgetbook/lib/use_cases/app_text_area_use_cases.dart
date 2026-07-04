import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppTextArea].
WidgetbookComponent buildAppTextAreaComponent() {
  return WidgetbookComponent(
    name: 'GHAppTextArea',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'Feedback', builder: _feedbackUseCase),
      WidgetbookUseCase(name: 'States', builder: _statesUseCase),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final knobs = context.knobs;
  final status = knobs.object.dropdown<GHAlertState>(
    label: 'Status',
    options: GHAlertState.values,
    initialOption: GHAlertState.active,
    labelBuilder: (v) => v.name,
  );
  final disabled = knobs.boolean(label: 'Disabled');
  final readOnly = knobs.boolean(label: 'Read only');
  final showHelperText = knobs.boolean(label: 'Helper text', initialValue: true);

  return Center(
    child: SizedBox(
      width: 320,
      child: GHAppTextArea(
        label: 'Message',
        placeholder: 'Write something…',
        helperText: showHelperText ? 'Maximum 500 characters.' : null,
        status: status,
        enabled: !disabled,
        readOnly: readOnly,
      ),
    ),
  );
}

Widget _feedbackUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        children: [
          for (final status in GHAlertState.values)
            GHAppTextArea(
              label: 'Message',
              placeholder: 'Write something…',
              status: status,
              helperText: switch (status) {
                GHAlertState.active => 'Maximum 500 characters.',
                GHAlertState.error => 'This field is required.',
                GHAlertState.warning => 'Your message is quite long.',
                GHAlertState.success => 'Looks good!',
              },
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
        spacing: 24,
        children: [
          const GHAppTextArea(label: 'Message', placeholder: 'Write something…'),
          GHAppTextArea(
            label: 'Message',
            controller: TextEditingController(text: 'Hi team, just checking in on the project status.'),
          ),
          const GHAppTextArea(label: 'Message', placeholder: 'Write something…', enabled: false),
          GHAppTextArea(
            label: 'Message',
            readOnly: true,
            controller: TextEditingController(text: 'Hi team, just checking in on the project status.'),
          ),
        ],
      ),
    ),
  );
}
