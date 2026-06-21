import 'dart:async';

import 'package:alchemist/alchemist.dart';

/// Global test configuration, executed automatically before every test file in
/// this package (Flutter's `flutter_test_config.dart` mechanism).
///
/// It wraps the test run in an [AlchemistConfig] so all golden tests share the
/// same settings. Alchemist loads the real font files at startup, so golden
/// snapshots render actual glyphs instead of the default "boxy" Ahem font.
///
/// We only compare *CI goldens* (deterministic, pixel-exact). Platform goldens
/// — which can differ between local machines and CI — are disabled, keeping the
/// suite stable regardless of where it runs.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      // Disable platform goldens so results are identical on every machine;
      // only the deterministic CI goldens are generated and compared.
      platformGoldensConfig: PlatformGoldensConfig(enabled: false),
    ),
    run: testMain,
  );
}
