import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHSnackbar].
WidgetbookComponent buildSnackbarComponent() {
  return WidgetbookComponent(
    name: 'GHSnackbar',
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

  final state = knobs.object.dropdown<GHSnackbarState>(label: 'State', options: GHSnackbarState.values, labelBuilder: (s) => s.name);
  final message = knobs.string(label: 'Message', initialValue: 'Assist text for the user');
  final showLeadingIcon = knobs.boolean(label: 'Show leading icon', initialValue: true);
  final ctaButton = knobs.boolean(label: 'Show CTA button');
  final smooth = knobs.boolean(label: 'Smooth corners');

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        width: 343,
        child: GHSnackbar(
          message: message,
          state: state,
          showLeadingIcon: showLeadingIcon,
          ctaButton: ctaButton,
          smooth: smooth,
          onDismiss: () {},
        ),
      ),
    ),
  );
}

Widget _allStatesUseCase(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      spacing: 16,
      children: [
        for (final ctaButton in [false, true])
          for (final state in GHSnackbarState.values)
            SizedBox(
              width: 343,
              child: GHSnackbar(
                message: 'Assist text for the user',
                state: state,
                ctaButton: ctaButton,
                onDismiss: () {},
              ),
            ),
      ],
    ),
  );
}

Widget _smoothCornersUseCase(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      spacing: 16,
      children: [
        for (final state in GHSnackbarState.values)
          SizedBox(
            width: 343,
            child: GHSnackbar(
              message: 'Assist text for the user',
              state: state,
              smooth: true,
              onDismiss: () {},
            ),
          ),
      ],
    ),
  );
}
