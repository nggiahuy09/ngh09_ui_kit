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

// Components (Phase B onward).
export 'src/components/avatars/gh_avatar_variant.dart';
export 'src/components/avatars/gh_user_avatar.dart';
export 'src/components/buttons/app_button.dart';
export 'src/components/buttons/button_variant.dart';
export 'src/components/display/app_badge.dart';
export 'src/components/display/app_chip.dart';
export 'src/components/display/badge_status.dart';
export 'src/components/display/chip_variant.dart';
export 'src/components/feedback/gh_alert_state.dart';
export 'src/components/feedback/gh_app_alert.dart';
export 'src/components/flags/gh_country.dart';
export 'src/components/flags/gh_country_flag.dart';
export 'src/components/icons/gh_hero_icon.dart';
export 'src/components/icons/gh_icon_data.dart';
export 'src/components/icons/gh_icons.dart';
export 'src/components/icons/heroicon_style.dart';
export 'src/components/logos/gh_company.dart';
export 'src/components/logos/gh_company_logo.dart';
export 'src/components/logos/gh_logo_layer.dart';
export 'src/components/payment/gh_payment_icon.dart';
export 'src/components/payment/gh_payment_icon_size.dart';
export 'src/components/payment/gh_payment_method.dart';
// Foundation — semantic theme layer.
export 'src/theme/app_colors.dart';
export 'src/theme/app_radii.dart';
export 'src/theme/app_shadows.dart';
export 'src/theme/app_spacing.dart';
export 'src/theme/app_theme.dart';
export 'src/theme/app_typography.dart';
// Foundation — design tokens (primitive values).
export 'src/tokens/breakpoints.dart';
export 'src/tokens/colors.dart';
export 'src/tokens/durations.dart';
export 'src/tokens/radii.dart';
export 'src/tokens/shadows.dart';
export 'src/tokens/spacing.dart';
export 'src/tokens/typography.dart';
// Utilities.
export 'src/utils/context_extensions.dart';
export 'src/utils/responsive.dart';
