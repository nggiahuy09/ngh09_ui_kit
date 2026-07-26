import 'package:flutter/material.dart';
import 'package:ngh09_ui_kit/src/components/payment/gh_payment_icon_size.dart';
import 'package:ngh09_ui_kit/src/components/payment/gh_payment_method.dart';

/// A payment-method badge rendered as a branded, rounded-rectangle container.
///
/// Sizes match the Finesse design spec exactly (sm: 34x24, md: 46x32,
/// lg: 58x40). Each badge uses official brand colors with a short label — no
/// SVG assets required.
///
/// ```dart
/// GHPaymentIcon(GHPaymentMethod.visa)                           // sm, 34x24
/// GHPaymentIcon(GHPaymentMethod.mastercard, size: GHPaymentIconSize.lg)
/// GHPaymentIcon(GHPaymentMethod.applePay, size: GHPaymentIconSize.md)
/// ```
class GHPaymentIcon extends StatelessWidget {
  /// Creates a payment icon badge for [method].
  const GHPaymentIcon(this.method, {this.size = GHPaymentIconSize.sm, this.semanticLabel, super.key});

  /// The payment method to render.
  final GHPaymentMethod method;

  /// The badge size. Defaults to [GHPaymentIconSize.sm] (34x24).
  final GHPaymentIconSize size;

  /// An accessibility label for the badge.
  ///
  /// Defaults to [GHPaymentMethod.displayName] when `null`.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? method.displayName,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: method.backgroundColor,
          borderRadius: BorderRadius.circular(4),
          border: method.hasLightBackground ? Border.all(color: const Color(0xFFE5E7EB), width: 0.5) : null,
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                method.label,
                style: TextStyle(color: method.foregroundColor, fontSize: size.fontSize, fontWeight: FontWeight.w700, height: 1, letterSpacing: -0.2),
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
