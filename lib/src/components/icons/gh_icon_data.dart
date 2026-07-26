import 'package:flutter/foundation.dart';

/// Identifies a single Heroicon by its Heroicons name (e.g. `academic-cap`).
///
/// This is the icon-agnostic descriptor consumed by `GHHeroIcon`: it names a
/// glyph but not a style. Pass one of the constants on `GHIcons` together with
/// a `HeroIconStyle` to render it.
///
/// ```dart
/// GHHeroIcon(GHIcons.academicCap, style: HeroIconStyle.solid);
/// ```
@immutable
class GHIconData {
  /// Creates an icon descriptor for the Heroicons glyph named [name].
  const GHIconData(this.name);

  /// The Heroicons file name in kebab-case, without extension or style — e.g.
  /// `arrow-down-circle`.
  ///
  /// Resolves to `assets/icons/heroicons/<style>/<name>.svg` for the requested
  /// `HeroIconStyle`.
  final String name;

  @override
  bool operator ==(Object other) => other is GHIconData && other.name == name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'GHIconData($name)';
}
