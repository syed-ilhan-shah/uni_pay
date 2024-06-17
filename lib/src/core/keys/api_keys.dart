import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:moyasar/moyasar.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/uni_pay.dart';

class ApiKeys {
  ///* Keys -------------------------------
  static String get tamaraBaseUrl =>
      UniPayControllers.uniPayData.environment.tamaraBaseUrl;

  static String tamaraProductionBaseUrl = "https://api.tamara.co";
  static String tamaraBaseUrlForDev = "https://api-sandbox.tamara.co";
  static String tamaraVerifyOrder = "$tamaraBaseUrl/orders";

  //* Merchant Urls
  static const String uniBaseURl = "https://unicode-moyasar.web.app";
  static const String successUrl = "$uniBaseURl/success";
  static const String failedUrl = "$uniBaseURl/failed";
  static const String cancelUrl = "$uniBaseURl/cancelled";
  static String approved = "approved";
  static String get tamaraCheckoutUrl => "$tamaraBaseUrl/checkout";

  static Map<String, String> get tamaraHeaders => UniPayControllers
      .uniPayData.credentials.tamaraCredential!.token.tamaraHeaders;

  ///* Process payment --------------------------------
  static PaymentConfig get moyasarPaymentConfig => PaymentConfig(
        publishableApiKey: UniPayControllers
            .uniPayData.credentials.moyasarCredential!.publishableKey,
        amount: UniPayControllers
            .uniPayData.orderInfo.transactionAmount.totalAmount.amountInHalala,
        description: UniPayControllers.uniPayData.orderInfo.description,
        applePay: ApplePayConfig(
          manual: true,
          label: UniPayControllers.uniPayData.appName,
          merchantId: UniPayControllers
                  .uniPayData.credentials.applePayMerchantIdentifier ??
              "",
        ),
        metadata: {"orderId": UniPayControllers.uniPayData.orderInfo.orderId},
      );

  ///* Web view options
  static InAppWebViewGroupOptions webViewGroupOptions =
      InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true, cacheEnabled: false),
    android: AndroidInAppWebViewOptions(disableDefaultErrorPage: true),
    ios: IOSInAppWebViewOptions(
        applePayAPIEnabled: true, allowsInlineMediaPlayback: true),
  );

  ///* Moyasar
  static String moyasarBaseUrl = "https://api.moyasar.com/v1";
  static String moyasarPaymentsUrl = "$moyasarBaseUrl/payments";
}
