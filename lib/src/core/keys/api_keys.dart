import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:moyasar/moyasar.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/uni_pay.dart';

class ApiKeys {
  static String get tamaraBaseUrl =>
      UniPayControllers.uniPayData.environment.isProduction
          ? tamaraProductionBaseUrl
          : tamaraBaseUrlForDev;

  static String tamaraProductionBaseUrl = "https://api.tamara.co";
  static String tamaraBaseUrlForDev = "https://api-sandbox.tamara.co";

  //* Merchant Urls
  static const String uniBaseURl = "https://unicode-moyasar.web.app";
  static const String successUrl = "$uniBaseURl/success";
  static const String failedUrl = "$uniBaseURl/failed";
  static const String cancelUrl = "$uniBaseURl/cancelled";

  static String get tamaraCheckoutUrl =>
      "https://api-sandbox.tamara.co/checkout";

  static Map<String, String> get tamaraHeaders => {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            UniPayControllers.uniPayData.credentials.tamaraCredential!.token,
      };

  ///* Process payment --------------------------------
  static PaymentConfig get moyasarPaymentConfig => PaymentConfig(
      publishableApiKey: UniPayControllers
          .uniPayData.credentials.moyasarCredential!.publishableKey,
      amount: UniPayControllers
          .uniPayData.orderInfo.transactionAmount.totalAmount.amountInHalala,
      description: UniPayControllers.uniPayData.orderInfo.description,
      applePay: ApplePayConfig(
        label: UniPayControllers.uniPayData.appName,
        merchantId: UniPayControllers
                .uniPayData.credentials.applePayMerchantIdentifier ??
            "",
      ));

  ///* Web view options
  static InAppWebViewGroupOptions webViewGroupOptions =
      InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true, cacheEnabled: false),
    android: AndroidInAppWebViewOptions(disableDefaultErrorPage: true),
    ios: IOSInAppWebViewOptions(
        applePayAPIEnabled: true, allowsInlineMediaPlayback: true),
  );
}
