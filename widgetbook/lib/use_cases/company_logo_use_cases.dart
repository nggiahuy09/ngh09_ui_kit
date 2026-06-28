import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

/// The Widgetbook component entry for [GHCompanyLogo].
WidgetbookComponent buildCompanyLogoComponent() {
  return WidgetbookComponent(
    name: 'GHCompanyLogo',
    useCases: [
      WidgetbookUseCase(name: 'Playground', builder: _playgroundUseCase),
      WidgetbookUseCase(name: 'All logos', builder: _allLogosUseCase),
      WidgetbookUseCase(name: 'Sizes', builder: _sizesUseCase),
    ],
  );
}

Widget _playgroundUseCase(BuildContext context) {
  final company = context.knobs.object.dropdown<GHCompany>(
    label: 'Company',
    options: GHCompany.values,
    initialOption: GHCompany.stripe,
    labelBuilder: (c) => c.name,
  );
  final height = context.knobs.double.slider(label: 'Height', initialValue: 24, min: 12, max: 96);

  return Center(child: GHCompanyLogo(company, height: height));
}

Widget _allLogosUseCase(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      spacing: 32,
      runSpacing: 24,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final company in GHCompany.values) GHCompanyLogo(company, height: 24),
      ],
    ),
  );
}

Widget _sizesUseCase(BuildContext context) {
  const sizes = <double>[12, 16, 24, 32, 48];
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        for (final size in sizes)
          Row(
            spacing: 32,
            children: [
              SizedBox(
                width: 40,
                child: Text(
                  '${size.toInt()}px',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
              GHCompanyLogo(GHCompany.stripe, height: size),
              GHCompanyLogo(GHCompany.google, height: size),
              GHCompanyLogo(GHCompany.slack, height: size),
              GHCompanyLogo(GHCompany.gitHub, height: size),
              GHCompanyLogo(GHCompany.notion, height: size),
            ],
          ),
      ],
    ),
  );
}
