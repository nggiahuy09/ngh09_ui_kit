import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngh09_ui_kit/src/components/logos/gh_company.dart';

/// Renders a company logo from the Finesse UI Kit at a configurable height.
///
/// Each logo is composed of one or more SVG layers absolutely positioned
/// within a bounding box. The bounding box scales proportionally: the
/// [height] you provide becomes the rendered height, and the width is
/// derived automatically from the logo's natural aspect ratio so the mark
/// never squishes or stretches.
///
/// ```dart
/// const GHCompanyLogo(GHCompany.stripe)               // 24 px tall
/// const GHCompanyLogo(GHCompany.google, height: 48)
/// const GHCompanyLogo(GHCompany.slack,  height: 16)
/// ```
///
/// **Height.** Defaults to `24.0`, a comfortable one-line display size.
/// The Figma source defines logos at 48 px tall — pass `height: 48` to
/// render at the design's native resolution.
///
/// **SVG layers.** Each logo is split into individual SVG vector paths
/// bundled under `assets/images/logos/`. They are rendered via
/// [SvgPicture.asset] and fill their positioned bounds with [BoxFit.fill],
/// matching the `preserveAspectRatio="none"` flag on every asset.
class GHCompanyLogo extends StatelessWidget {
  /// Creates a company logo widget for [company].
  const GHCompanyLogo(this.company, {this.height = 24.0, this.semanticLabel, super.key});

  /// Which company logo to display.
  final GHCompany company;

  /// The rendered height in logical pixels. Defaults to `24.0`.
  ///
  /// The width is derived from the company's natural width scaled to this height.
  final double height;

  /// An accessibility label announced by screen readers.
  ///
  /// Defaults to the company's enum name (e.g. `"stripe"`) when `null`.
  final String? semanticLabel;

  static const double _naturalHeight = 48;

  @override
  Widget build(BuildContext context) {
    final scale = height / _naturalHeight;
    final width = company.naturalWidth * scale;
    final layers = company.layers;

    return Semantics(
      label: semanticLabel ?? company.name,
      image: true,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            for (final layer in layers)
              Positioned(
                top: layer.top * height,
                right: layer.right * width,
                bottom: layer.bottom * height,
                left: layer.left * width,
                child: SvgPicture.asset(layer.assetPath, fit: BoxFit.fill, excludeFromSemantics: true),
              ),
          ],
        ),
      ),
    );
  }
}
