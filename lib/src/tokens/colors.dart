import 'package:flutter/widgets.dart';

/// Primitive color palette (raw, non-semantic values).
///
/// These are the lowest-level tokens. Do not consume them directly in widgets;
/// use the semantic theme layer (`AppColors`) instead. Filled in during the
/// foundation phase (Phase A).
abstract final class ColorTokens {
  /// Pure white.
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black.
  static const Color black = Color(0xFF000000);
}
