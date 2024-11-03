import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:uni_pay/src/core/keys/api_keys.dart';
import 'package:uni_pay/src/utils/uni_enums.dart';

class TamaraSnippet {
  /// Public secret key for Tamara
  final String psKey;

  /// Locale of the campaign, default is `UniPayLocale.ar`
  final UniPayLocale locale;

  /// Transaction amount
  final num transactionAmount;

  /// Country code, default is `SA - (Saudi Arabia)`
  final String countryCode;

  const TamaraSnippet({
    required this.psKey,
    this.locale = UniPayLocale.ar,
    this.transactionAmount = 100,
    this.countryCode = "SA",
  });

  /// Get the product page campaign CDN URL
  WebUri get productPageCampaignCDN => ApiKeys.tamaraCampaignCDN(this);

  /// Get the checkout page campaign CDN URL
  WebUri get checkoutPageCampaignCDN => ApiKeys.tamaraCampaignCDN(this, true);
}
