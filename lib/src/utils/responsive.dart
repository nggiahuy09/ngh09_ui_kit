import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/tokens/breakpoints.dart';
import 'package:ngh09_ui_kit/src/utils/context_extensions.dart';

/// The discrete responsive size class derived from the layout width.
enum ScreenType {
  /// Width below the mobile breakpoint.
  mobile,

  /// Width in the tablet range.
  tablet,

  /// Width at or above the tablet breakpoint.
  desktop;

  /// Resolves the [ScreenType] for a given logical [width] using
  /// [BreakpointTokens].
  static ScreenType fromWidth(double width) {
    if (width < BreakpointTokens.mobile) return ScreenType.mobile;
    if (width < BreakpointTokens.tablet) return ScreenType.tablet;
    return ScreenType.desktop;
  }
}

/// Picks a value based on the current [ScreenType].
///
/// `tablet` and `desktop` fall back to smaller breakpoints when omitted, so
/// only `mobile` is required:
///
/// ```dart
/// final columns = context.responsiveValue(mobile: 1, tablet: 2, desktop: 4);
/// ```
extension ResponsiveValueContext on BuildContext {
  /// Returns the value matching the current [ScreenType], falling back to the
  /// next-smaller breakpoint's value when a larger one is not provided.
  T responsiveValue<T>({required T mobile, T? tablet, T? desktop}) {
    switch (ScreenType.fromWidth(screenWidth)) {
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.mobile:
        return mobile;
    }
  }
}

/// Builds different widget subtrees per [ScreenType].
///
/// [tablet] and [desktop] are optional and fall back to the next-smaller
/// builder, so a single [mobile] builder is always sufficient.
class ResponsiveBuilder extends StatelessWidget {
  /// Creates a responsive builder. Only [mobile] is required.
  const ResponsiveBuilder({
    required this.mobile,
    this.tablet,
    this.desktop,
    super.key,
  });

  /// Builder used for the [ScreenType.mobile] range (and the default fallback).
  final WidgetBuilder mobile;

  /// Builder used for the [ScreenType.tablet] range.
  final WidgetBuilder? tablet;

  /// Builder used for the [ScreenType.desktop] range.
  final WidgetBuilder? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (ScreenType.fromWidth(constraints.maxWidth)) {
          case ScreenType.desktop:
            return (desktop ?? tablet ?? mobile)(context);
          case ScreenType.tablet:
            return (tablet ?? mobile)(context);
          case ScreenType.mobile:
            return mobile(context);
        }
      },
    );
  }
}
