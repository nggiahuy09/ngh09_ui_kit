import 'package:flutter/foundation.dart';

/// A single absolutely-positioned SVG layer within a company logo.
///
/// All positions are fractions (0.0–1.0) of the logo's natural size.
/// The SVG asset fills the positioned bounds with [BoxFit.fill].
@immutable
class GHLogoLayer {
  /// Creates a logo layer.
  const GHLogoLayer(this._hash, this.top, this.right, this.bottom, this.left);

  final String _hash;

  /// Top inset as a fraction of the logo height.
  final double top;

  /// Right inset as a fraction of the logo width.
  final double right;

  /// Bottom inset as a fraction of the logo height.
  final double bottom;

  /// Left inset as a fraction of the logo width.
  final double left;

  /// The bundled asset path for this SVG layer.
  String get assetPath => 'packages/ngh09_ui_kit/assets/images/logos/$_hash.svg';
}
