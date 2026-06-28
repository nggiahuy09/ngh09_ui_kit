import 'package:flutter/painting.dart';

/// A payment method supported by the Finesse UI payment icon catalog.
///
/// Each case bundles the brand colors and a short display label used by
/// `GHPaymentIcon` to render a recognisable badge without requiring external
/// SVG assets.
///
/// ```dart
/// GHPaymentIcon(GHPaymentMethod.visa)
/// GHPaymentIcon(GHPaymentMethod.mastercard, size: GHPaymentIconSize.lg)
/// ```
enum GHPaymentMethod {
  /// American Express.
  amex(Color(0xFF2E77BC), Color(0xFFFFFFFF), 'AMEX', 'American Express'),

  /// Affirm.
  affirm(Color(0xFF4A4AFF), Color(0xFFFFFFFF), 'Affirm', 'Affirm'),

  /// Alipay.
  alipay(Color(0xFF00A1E9), Color(0xFFFFFFFF), 'Alipay', 'Alipay'),

  /// Amazon Pay.
  amazon(Color(0xFF232F3E), Color(0xFFFF9900), 'Pay', 'Amazon Pay'),

  /// Apple Pay.
  applePay(Color(0xFF000000), Color(0xFFFFFFFF), 'Pay', 'Apple Pay'),

  /// Bancontact.
  bancontact(Color(0xFF005498), Color(0xFFFFFFFF), 'BC', 'Bancontact'),

  /// Bitpay.
  bitpay(Color(0xFF1A3B8B), Color(0xFFFFFFFF), 'Bitpay', 'Bitpay'),

  /// Bitcoin.
  bitcoin(Color(0xFFF7931A), Color(0xFFFFFFFF), 'BTC', 'Bitcoin'),

  /// Bitcoin Cash.
  bitcoinCash(Color(0xFF0AC18E), Color(0xFFFFFFFF), 'BCH', 'Bitcoin Cash'),

  /// Citadele.
  citadele(Color(0xFFC8102E), Color(0xFFFFFFFF), 'Cit', 'Citadele'),

  /// Diners Club.
  dinersClub(Color(0xFFEB0029), Color(0xFFFFFFFF), 'DC', 'Diners Club'),

  /// Discover.
  discover(Color(0xFFFFFFFF), Color(0xFF231F20), 'DISC', 'Discover'),

  /// Elo.
  elo(Color(0xFF00A0E0), Color(0xFFFFFFFF), 'elo', 'Elo'),

  /// Ethereum.
  ethereum(Color(0xFF627EEA), Color(0xFFFFFFFF), 'ETH', 'Ethereum'),

  /// Forbrugsforeningen.
  forbrugsforeningen(
    Color(0xFF003087),
    Color(0xFFFFFFFF),
    'FbF',
    'Forbrugsforeningen',
  ),

  /// Google Pay.
  googlePay(Color(0xFFFFFFFF), Color(0xFF3C4043), 'GPay', 'Google Pay'),

  /// iDEAL.
  ideal(Color(0xFFCC0066), Color(0xFFFFFFFF), 'iD', 'iDEAL'),

  /// Interac.
  interac(Color(0xFFFFB81C), Color(0xFF333333), 'INT', 'Interac'),

  /// JCB.
  jcb(Color(0xFF003087), Color(0xFFFFFFFF), 'JCB', 'JCB'),

  /// Klarna.
  klarna(Color(0xFFFFB3C7), Color(0xFF000000), 'K', 'Klarna'),

  /// Litecoin.
  litecoin(Color(0xFF345D9D), Color(0xFFFFFFFF), 'LTC', 'Litecoin'),

  /// Maestro.
  maestro(Color(0xFF007AC3), Color(0xFFFFFFFF), 'M', 'Maestro'),

  /// Mastercard.
  mastercard(Color(0xFFEB001B), Color(0xFFFFFFFF), 'MC', 'Mastercard'),

  /// Payoneer.
  payoneer(Color(0xFFFF4800), Color(0xFFFFFFFF), 'Payo', 'Payoneer'),

  /// PayPal.
  paypal(Color(0xFF003087), Color(0xFFFFFFFF), 'PP', 'PayPal'),

  /// Paysafe.
  paysafe(Color(0xFF0055A5), Color(0xFFFFFFFF), 'PSC', 'Paysafe'),

  /// QIWI.
  qiwi(Color(0xFFFF8C00), Color(0xFFFFFFFF), 'QIWI', 'QIWI'),

  /// SEPA.
  sepa(Color(0xFF003399), Color(0xFFFFFFFF), 'SEPA', 'SEPA'),

  /// Shop Pay.
  shopPay(Color(0xFF5A31F4), Color(0xFFFFFFFF), 'Shop', 'Shop Pay'),

  /// Skrill.
  skrill(Color(0xFF862165), Color(0xFFFFFFFF), 'Skrill', 'Skrill'),

  /// Sofort.
  sofort(Color(0xFFEF809F), Color(0xFF000000), 'Sofort', 'Sofort'),

  /// Stripe.
  stripe(Color(0xFF635BFF), Color(0xFFFFFFFF), 'S', 'Stripe'),

  /// UnionPay.
  unionPay(Color(0xFFE21836), Color(0xFFFFFFFF), 'UP', 'UnionPay'),

  /// Verifone.
  verifone(Color(0xFF003F8F), Color(0xFFFFFFFF), 'VFN', 'Verifone'),

  /// Visa.
  visa(Color(0xFF1A1F71), Color(0xFFFFFFFF), 'VISA', 'Visa'),

  /// WeChat Pay.
  weChat(Color(0xFF07C160), Color(0xFFFFFFFF), 'WPay', 'WeChat Pay'),

  /// WebMoney.
  webmoney(Color(0xFF005BAA), Color(0xFFFFFFFF), 'WM', 'WebMoney'),

  /// Yandex Pay.
  yandex(Color(0xFFFC3F1D), Color(0xFFFFFFFF), 'YPay', 'Yandex Pay'),

  /// Giropay.
  giropay(Color(0xFF0052B4), Color(0xFFFFFFFF), 'giro', 'Giropay');

  const GHPaymentMethod(this.backgroundColor, this.foregroundColor, this.label, this.displayName);

  /// The brand background color.
  final Color backgroundColor;

  /// The color for the label text drawn on [backgroundColor].
  final Color foregroundColor;

  /// Short abbreviation rendered inside the badge (e.g. `'VISA'`, `'MC'`).
  final String label;

  /// Full human-readable name used for accessibility (e.g. `'Mastercard'`).
  final String displayName;

  /// Whether [backgroundColor] is white, in which case the widget adds a
  /// subtle border to ensure the badge is visible on light surfaces.
  bool get hasLightBackground => backgroundColor == const Color(0xFFFFFFFF);
}
