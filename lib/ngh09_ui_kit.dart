/// ngh09_ui_kit — a Material 3 based Flutter UI kit and design system.
///
/// This barrel file is the single public entry point of the package.
/// Consumers import it as:
///
/// ```dart
/// import 'package:ngh09_ui_kit/ngh09_ui_kit.dart';
/// ```
///
/// Everything under `lib/src/` is private to the package; only the symbols
/// re-exported here form the public API.
library;

// Foundation — semantic theme layer.
export 'src/theme/app_colors.dart';
export 'src/theme/app_radii.dart';
export 'src/theme/app_spacing.dart';
export 'src/theme/app_theme.dart';
export 'src/theme/app_typography.dart';
// Foundation — design tokens (primitive values).
export 'src/tokens/breakpoints.dart';
export 'src/tokens/colors.dart';
export 'src/tokens/durations.dart';
export 'src/tokens/elevation.dart';
export 'src/tokens/radii.dart';
export 'src/tokens/spacing.dart';
export 'src/tokens/typography.dart';
// Utilities.
export 'src/utils/context_extensions.dart';

// Components are exported here as they are implemented (Phase B onward).
