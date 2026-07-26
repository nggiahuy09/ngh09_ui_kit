/// The three canonical sizes for a `GHPaymentIcon`, matching the Finesse
/// design spec (sm: 34x24, md: 46x32, lg: 58x40).
enum GHPaymentIconSize {
  /// Small -- 34x24 logical pixels.
  sm(width: 34, height: 24, fontSize: 7.5),

  /// Medium -- 46x32 logical pixels.
  md(width: 46, height: 32, fontSize: 9.5),

  /// Large -- 58x40 logical pixels.
  lg(width: 58, height: 40, fontSize: 11.5);

  const GHPaymentIconSize({required this.width, required this.height, required this.fontSize});

  /// Width of the icon in logical pixels.
  final double width;

  /// Height of the icon in logical pixels.
  final double height;

  /// Font size used for the abbreviated label inside the icon.
  final double fontSize;
}
