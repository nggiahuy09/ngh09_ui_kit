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
  group('GHAvatarVariant', () {
    test('assetPath includes the padded variant number', () {
      expect(GHAvatarVariant.v01.assetPath, contains('avatar_01.png'));
      expect(GHAvatarVariant.v14.assetPath, contains('avatar_14.png'));
    });

    test('all 14 variants have distinct asset paths', () {
      final paths = GHAvatarVariant.values.map((v) => v.assetPath).toSet();
      expect(paths.length, GHAvatarVariant.values.length);
    });
  });

  group('GHUserAvatar', () {
    testWidgets('renders a SizedBox of the requested size', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar(GHAvatarVariant.v01, size: 64)));

      final box = tester.renderObject<RenderBox>(find.byType(GHUserAvatar));
      expect(box.size, const Size(64, 64));
    });

    testWidgets('defaults to 40 px when no size is supplied', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar(GHAvatarVariant.v02)));

      final box = tester.renderObject<RenderBox>(find.byType(GHUserAvatar));
      expect(box.size, const Size(40, 40));
    });

    testWidgets('exposes a semantic label', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar(GHAvatarVariant.v03, semanticLabel: 'Profile picture')));

      expect(
        tester.getSemantics(find.byType(GHUserAvatar)),
        matchesSemantics(label: 'Profile picture', isImage: true),
      );
    });

    testWidgets('defaults semantic label to "User avatar"', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar(GHAvatarVariant.v04)));

      expect(
        tester.getSemantics(find.byType(GHUserAvatar)),
        matchesSemantics(label: 'User avatar', isImage: true),
      );
    });

    testWidgets('clips the image to a circle via ClipOval', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar(GHAvatarVariant.v05)));

      expect(find.byType(ClipOval), findsOneWidget);
    });
  });
}
