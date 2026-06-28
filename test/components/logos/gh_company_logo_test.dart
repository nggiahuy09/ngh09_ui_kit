import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: GHAppTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('GHCompany', () {
    test('all 136 companies have at least one layer', () {
      for (final company in GHCompany.values) {
        expect(company.layers, isNotEmpty, reason: '${company.name} has no layers');
      }
    });

    test('all layer asset paths reference a valid hash', () {
      final hashPattern = RegExp(r'^packages/ngh09_ui_kit/assets/images/logos/[a-f0-9]{40}\.svg$');
      for (final company in GHCompany.values) {
        for (final layer in company.layers) {
          expect(
            layer.assetPath,
            matches(hashPattern),
            reason: '${company.name} has invalid asset path: ${layer.assetPath}',
          );
        }
      }
    });

    test('all companies have a positive natural width', () {
      for (final company in GHCompany.values) {
        expect(company.naturalWidth, greaterThan(0), reason: '${company.name} has non-positive width');
      }
    });
  });

  group('GHCompanyLogo', () {
    testWidgets('renders at the requested height', (tester) async {
      await tester.pumpWidget(_wrap(const GHCompanyLogo(GHCompany.stripe, height: 48)));

      final box = tester.renderObject<RenderBox>(find.byType(GHCompanyLogo));
      expect(box.size.height, 48);
    });

    testWidgets('defaults to 24 px height', (tester) async {
      await tester.pumpWidget(_wrap(const GHCompanyLogo(GHCompany.gitHub)));

      final box = tester.renderObject<RenderBox>(find.byType(GHCompanyLogo));
      expect(box.size.height, 24);
    });

    testWidgets('width scales proportionally with height', (tester) async {
      const company = GHCompany.notion;

      await tester.pumpWidget(_wrap(const GHCompanyLogo(company, height: 24)));
      final box24 = tester.renderObject<RenderBox>(find.byType(GHCompanyLogo));
      final width24 = box24.size.width;

      await tester.pumpWidget(_wrap(const GHCompanyLogo(company, height: 48)));
      final box48 = tester.renderObject<RenderBox>(find.byType(GHCompanyLogo));
      final width48 = box48.size.width;

      expect(width48, closeTo(width24 * 2, 0.5));
    });

    testWidgets('exposes a semantic image label', (tester) async {
      await tester.pumpWidget(_wrap(const GHCompanyLogo(GHCompany.slack, semanticLabel: 'Slack logo')));

      expect(
        tester.getSemantics(find.byType(GHCompanyLogo)),
        matchesSemantics(label: 'Slack logo', isImage: true),
      );
    });

    testWidgets('defaults semantic label to the company enum name', (tester) async {
      await tester.pumpWidget(_wrap(const GHCompanyLogo(GHCompany.google)));

      expect(
        tester.getSemantics(find.byType(GHCompanyLogo)),
        matchesSemantics(label: 'google', isImage: true),
      );
    });
  });
}
