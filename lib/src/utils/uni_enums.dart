import 'package:flutter/material.dart';
import 'package:uni_pay/src/core/keys/api_keys.dart';

import '../constant/locale.dart';

///* State of payment

enum UniPayPaymentMethods { applepay, card, stcpay, tamara, notSpecified }

enum UniPayLocale {
  ar,
  en;

  /// Get current locale `ar_SA` or `en_US`
  Locale get currentLocale => this == UniPayLocale.ar
      ? LocalizationsData.supportLocale.first
      : LocalizationsData.supportLocale.last;
}

enum UniPayCountry { sa }

enum UniPayCurrency { sar }

enum UniPayItemType { product, service, notSpecified }

enum UniPayEnvironment { production, development }

enum UniPayStatus { success, failed, cancelled, notSpecified, notFound }

enum UniPayCurrentState { loading, success, failed, notSpecified }

enum UniPayCardType {
  mada,
  visa,
  mastercard,
  amex,
  tamara,
  notSpecified;

  bool get isMada => this == UniPayCardType.mada;
  bool get isVisa => this == UniPayCardType.visa;
  bool get isMastercard => this == UniPayCardType.mastercard;
  bool get isAmex => this == UniPayCardType.amex;
  bool get isTamara => this == UniPayCardType.tamara;
  bool get isNotSpecified => this == UniPayCardType.notSpecified;
}

///* Below section responsible  above enums extentions

extension UniPayLocaleExt on UniPayLocale {
  bool get isArabic => this == UniPayLocale.ar;
  bool get isEnglish => this == UniPayLocale.en;
  String get localeCode {
    switch (this) {
      case UniPayLocale.ar:
        return "ar_SA";
      case UniPayLocale.en:
        return "en_US";
      default:
        return "en_US";
    }
  }
}

extension UniPayCountryExt on UniPayCountry {
  String get countryCode {
    switch (this) {
      case UniPayCountry.sa:
        return "SA";
    }
  }
}

extension UniPayCurrencyExt on UniPayCurrency {
  String get currencyCode {
    switch (this) {
      case UniPayCurrency.sar:
        return "SAR";
    }
  }
}

extension UniPayEnvExt on UniPayEnvironment {
  bool get isProduction => this == UniPayEnvironment.production;
  bool get isDevelopement => this == UniPayEnvironment.development;

  String get tamaraBaseUrl => isProduction
      ? ApiKeys.tamaraProductionBaseUrl
      : ApiKeys.tamaraBaseUrlForDev;

  String get tamaraCapturePayment => "$tamaraBaseUrl/payments/capture";
  String tamaraTransactionApi(String referenceId) =>
      "$tamaraBaseUrl/merchants/orders/reference-id/$referenceId";
}

extension UniPayCurrentStateExt on UniPayCurrentState {
  bool get isLoading => this == UniPayCurrentState.loading;
  bool get isSuccess => this == UniPayCurrentState.success;
  bool get isFailed => this == UniPayCurrentState.failed;
  bool get isNotSpecified => this == UniPayCurrentState.notSpecified;
}

extension UniPayStatusExt on UniPayStatus {
  bool get isSuccess => this == UniPayStatus.success;
  bool get isFailed => this == UniPayStatus.failed;
  bool get isCancelled => this == UniPayStatus.cancelled;
  bool get isNotSpecified => this == UniPayStatus.notSpecified;
  bool get isNotFound => this == UniPayStatus.notFound;
}

extension UniPayPaymentMethodsExt on UniPayPaymentMethods {
  bool get isApplePay => this == UniPayPaymentMethods.applepay;
  bool get isCard => this == UniPayPaymentMethods.card;
  bool get isStcPay => this == UniPayPaymentMethods.stcpay;
  bool get isTamara => this == UniPayPaymentMethods.tamara;
  bool get isNotSpecified => this == UniPayPaymentMethods.notSpecified;

  bool get isMoyasar => isApplePay || isCard || isStcPay;
}

extension UniPayPaymentMethodsItr on List<UniPayPaymentMethods> {
  bool get isMoyasarGateway => any((gateway) => gateway.isMoyasar);
  bool get isTamaraGateway => any((gateway) => gateway.isTamara);
  bool get isApplePay => any((gateway) => gateway.isApplePay);
}
