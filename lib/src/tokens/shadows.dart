import 'package:flutter/widgets.dart';

/// Primitive shadow tokens — raw `BoxShadow` stacks.
///
/// Low-level values consumed by the semantic theme layer (`GHAppShadows`).
/// Mirror the **Finesse UI Kit** shadow effect styles (see `figma/shadows.md`).
/// Each token is a `DROP_SHADOW` stack in Figma layer order; colors are literal
/// `0xAARRGGBB` ARGB values matching the design. The tints reuse the palette:
/// `0x..676E76` = Gray/500, `0x..F34141` = Error/600, `0x..E9A23B` =
/// Warning/600, `0x..53B483` = Success/600.
abstract final class ShadowTokens {
  // Normal styles — components at rest (buttons, cards, dropdowns) -----------

  /// Small — subtle resting elevation.
  static const List<BoxShadow> small = [
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 2), blurRadius: 5),
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
  ];

  /// Medium — resting elevation with a hairline ring.
  static const List<BoxShadow> medium = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
    BoxShadow(color: Color(0x29676E76), spreadRadius: 1),
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 2), blurRadius: 5),
  ];

  /// Large — prominent floating elevation (modals, popovers).
  static const List<BoxShadow> large = [
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 15), blurRadius: 35),
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 5), blurRadius: 15),
  ];

  // Hover styles — pointer inside the component -----------------------------

  /// Hover, primary (dark ring).
  static const List<BoxShadow> hoverPrimary = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
    BoxShadow(color: Color(0xA3000000), spreadRadius: 1),
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 2), blurRadius: 5),
  ];

  /// Hover, secondary (neutral ring).
  static const List<BoxShadow> hoverSecondary = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
    BoxShadow(color: Color(0x3D676E76), spreadRadius: 1),
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 2), blurRadius: 5),
  ];

  /// Hover, error (red ring).
  static const List<BoxShadow> hoverError = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
    BoxShadow(color: Color(0x66F34141), spreadRadius: 2),
    BoxShadow(color: Color(0x14F34141), offset: Offset(0, 2), blurRadius: 5),
  ];

  /// Hover, warning (amber ring).
  static const List<BoxShadow> hoverWarning = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
    BoxShadow(color: Color(0x66E9A23B), spreadRadius: 2),
    BoxShadow(color: Color(0x14E9A23B), offset: Offset(0, 2), blurRadius: 5),
  ];

  /// Hover, success (green ring).
  static const List<BoxShadow> hoverSuccess = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
    BoxShadow(color: Color(0x6653B483), spreadRadius: 2),
    BoxShadow(color: Color(0x1453B483), offset: Offset(0, 2), blurRadius: 5),
  ];

  // Focus styles — hover ring plus an outer halo (spread 4) -----------------

  /// Focus, primary (dark ring + neutral halo).
  static const List<BoxShadow> focusPrimary = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
    BoxShadow(color: Color(0xA3000000), spreadRadius: 1),
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 2), blurRadius: 5),
    BoxShadow(color: Color(0x29676E76), spreadRadius: 4),
  ];

  /// Focus, secondary (neutral ring + neutral halo).
  static const List<BoxShadow> focusSecondary = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
    BoxShadow(color: Color(0x29676E76), spreadRadius: 1),
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 2), blurRadius: 5),
    BoxShadow(color: Color(0x29676E76), spreadRadius: 4),
  ];

  /// Focus, error (red ring + red halo).
  static const List<BoxShadow> focusError = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
    BoxShadow(color: Color(0x29F34141), spreadRadius: 1),
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 2), blurRadius: 5),
    BoxShadow(color: Color(0x29F34141), spreadRadius: 4),
  ];

  /// Focus, warning (amber ring + amber halo).
  static const List<BoxShadow> focusWarning = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
    BoxShadow(color: Color(0x29E9A23B), spreadRadius: 1),
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 2), blurRadius: 5),
    BoxShadow(color: Color(0x29E9A23B), spreadRadius: 4),
  ];

  /// Focus, success (green ring + green halo).
  static const List<BoxShadow> focusSuccess = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 1), blurRadius: 1),
    BoxShadow(color: Color(0x2953B483), spreadRadius: 1),
    BoxShadow(color: Color(0x14676E76), offset: Offset(0, 2), blurRadius: 5),
    BoxShadow(color: Color(0x2953B483), spreadRadius: 4),
  ];
}
