import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHAppTextField].
WidgetbookComponent buildAppTextFieldComponent() {
  return WidgetbookComponent(
    name: 'GHAppTextField',
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
  final showLeadingIcon = knobs.boolean(label: 'Leading icon', initialValue: true);
  final showHelperText = knobs.boolean(label: 'Helper text', initialValue: true);

  return Center(
    child: SizedBox(
      width: 320,
      child: GHAppTextField(
        label: 'Email',
        placeholder: 'you@example.com',
        leadingIcon: showLeadingIcon ? const Icon(Icons.email_outlined) : null,
        helperText: showHelperText ? 'We will never share your email.' : null,
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
            GHAppTextField(
              label: 'Email',
              placeholder: 'you@example.com',
              status: status,
              helperText: switch (status) {
                GHAlertState.active => 'We will never share your email.',
                GHAlertState.error => 'Enter a valid email address.',
                GHAlertState.warning => 'This email looks unusual.',
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
          const GHAppTextField(label: 'Email', placeholder: 'you@example.com'),
          GHAppTextField(
            label: 'Email',
            leadingIcon: const Icon(Icons.email_outlined),
            controller: TextEditingController(text: 'hussain@finesse.com'),
          ),
          const GHAppTextField(label: 'Email', placeholder: 'you@example.com', enabled: false),
          GHAppTextField(
            label: 'Email',
            readOnly: true,
            controller: TextEditingController(text: 'hussain@finesse.com'),
          ),
        ],
      ),
    ),
  );
}
