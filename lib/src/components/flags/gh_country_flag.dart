import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/flags/gh_country.dart';

/// Renders a country flag as a Unicode emoji, sized and optionally clipped to
/// a circle.
///
/// Uses regional-indicator emoji derived from the country's ISO 3166-1 alpha-2
/// code — zero assets, zero extra dependencies, works offline on all platforms.
///
/// ```dart
/// GHCountryFlag(GHCountry.unitedStates)              // 24px circular
/// GHCountryFlag(GHCountry.unitedKingdom, size: 32)
/// GHCountryFlag(GHCountry.france, circular: false)   // square
/// ```
///
/// **Size.** Defaults to `24.0`, matching the Finesse design spec (24×24 px).
///
/// **Circular.** When `true` (default) the widget clips to an [ClipOval],
/// matching the circular flag symbols in the Figma catalog.
class GHCountryFlag extends StatelessWidget {
  /// Creates a flag widget for [country].
  const GHCountryFlag(this.country, {this.size = 24.0, this.circular = true, this.semanticLabel, super.key});

  /// The country whose flag to display.
  final GHCountry country;

  /// The width and height of the flag in logical pixels. Defaults to `24.0`.
  final double size;

  /// Whether to clip the flag to a circle. Defaults to `true`.
  final bool circular;

  /// An accessibility label announced for the flag. When `null`, defaults to
  /// the country's enum name (e.g. `"unitedStates"`).
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final flag = SizedBox.square(
      dimension: size,
      child: FittedBox(
        child: Text(
          country.flagEmoji,
          style: const TextStyle(fontSize: 32, height: 1),
          textScaler: TextScaler.noScaling,
        ),
      ),
    );

    return Semantics(
      label: semanticLabel ?? country.name,
      child: circular ? ClipOval(child: flag) : flag,
    );
  }
}
