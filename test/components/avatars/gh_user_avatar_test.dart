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

  group('GHAvatarSize', () {
    test('dimension values match the Finesse spec', () {
      expect(GHAvatarSize.xs.dimension, 24);
      expect(GHAvatarSize.sm.dimension, 32);
      expect(GHAvatarSize.md.dimension, 40);
      expect(GHAvatarSize.lg.dimension, 48);
      expect(GHAvatarSize.xl.dimension, 56);
      expect(GHAvatarSize.xxl.dimension, 64);
    });

    test('online dot diameters scale with avatar size', () {
      expect(GHAvatarSize.xs.onlineDotDiameter, 6);
      expect(GHAvatarSize.xxl.onlineDotDiameter, 16);
    });

    test('badge diameters scale with avatar size', () {
      expect(GHAvatarSize.xs.badgeDiameter, 8);
      expect(GHAvatarSize.xxl.badgeDiameter, 18);
    });
  });

  group('GHUserAvatar — image variant', () {
    testWidgets('renders at the requested size', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar(GHAvatarVariant.v01, size: GHAvatarSize.xxl)));

      final box = tester.renderObject<RenderBox>(find.byType(GHUserAvatar));
      expect(box.size, const Size(64, 64));
    });

    testWidgets('defaults to md (40 dp)', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar(GHAvatarVariant.v02)));

      final box = tester.renderObject<RenderBox>(find.byType(GHUserAvatar));
      expect(box.size, const Size(40, 40));
    });

    testWidgets('clips the image with ClipOval', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar(GHAvatarVariant.v05)));

      expect(find.byType(ClipOval), findsOneWidget);
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
  });

  group('GHUserAvatar.initials', () {
    testWidgets('renders a Text widget with the initials', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar.initials('AB')));

      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('uppercases the initials', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar.initials('jd')));

      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('truncates to two characters', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar.initials('ABC')));

      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('renders at the requested size', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar.initials('AB', size: GHAvatarSize.lg)));

      final box = tester.renderObject<RenderBox>(find.byType(GHUserAvatar));
      expect(box.size, const Size(48, 48));
    });

    testWidgets('has a semantic label containing the initials', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar.initials('CD')));

      expect(
        tester.getSemantics(find.byType(GHUserAvatar)),
        matchesSemantics(label: 'Avatar: CD', isImage: true),
      );
    });
  });

  group('GHUserAvatar — status indicators', () {
    testWidgets('online indicator appears in the tree', (tester) async {
      await tester.pumpWidget(
        _wrap(const GHUserAvatar(GHAvatarVariant.v01, status: GHAvatarStatusOnline())),
      );

      // Stack has clip.none to allow indicator overflow; verify it exists.
      expect(
        find.byWidgetPredicate((w) => w is Stack && w.clipBehavior == Clip.none),
        findsOneWidget,
      );
    });

    testWidgets('no indicator: Stack still renders', (tester) async {
      await tester.pumpWidget(_wrap(const GHUserAvatar(GHAvatarVariant.v02)));

      expect(find.byType(GHUserAvatar), findsOneWidget);
    });

    testWidgets('number badge renders for GHAvatarStatusNumber', (tester) async {
      await tester.pumpWidget(
        _wrap(const GHUserAvatar(GHAvatarVariant.v03, status: GHAvatarStatusNumber(count: 5))),
      );

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('counts above 9 render as "9+"', (tester) async {
      await tester.pumpWidget(
        _wrap(const GHUserAvatar(GHAvatarVariant.v03, status: GHAvatarStatusNumber(count: 10))),
      );

      expect(find.text('9+'), findsOneWidget);
    });
  });
}
