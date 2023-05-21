import 'package:flutter/material.dart';

import '../../utils/uni_enums.dart';
import 'uni_credentials.dart';
import 'uni_order.dart';
import 'uni_pay_customer.dart';
import 'uni_pay_res.dart';

///* `UniPayData` is all we need to make a payment request to your desired payment gateway
class UniPayData {
  ///* Name of your application
  late String appName;

  ///* Locale of gateway
  late UniPayLocale locale;

  ///* Customer information with order shipping/delivery address
  late UniPayCustomerInfo customerInfo;

  ///* Credentials of payment gateway
  late UniPayCredentials credentials;

  ///* Order information
  late UniPayOrder orderInfo;

  ///* Unipay enivronment
  late UniPayEnvironment environment;

  ///* Listen to response when payment request is successfully completed
  late ValueChanged<UniPayResponse> onPaymentSucess;

  ///* Get response callback when payment request is failed
  late ValueChanged<UniPayResponse> onPaymentFailed;

  UniPayData({
    required this.appName,
    required this.locale,
    required this.customerInfo,
    required this.credentials,
    required this.orderInfo,
    this.environment = UniPayEnvironment.production,
    required this.onPaymentSucess,
    required this.onPaymentFailed,
  });

  UniPayData.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    locale = UniPayLocale.values[json['locale']];
    customerInfo = UniPayCustomerInfo.fromJson(json['customerInfo']);
    credentials = UniPayCredentials.fromJson(json['credentials']);
    orderInfo = UniPayOrder.fromJson(json['orderInfo']);
    environment = UniPayEnvironment.values[json['environment']];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appName'] = appName;
    data['locale'] = locale;
    data['customerInfo'] = customerInfo.toJson();
    data['credentials'] = credentials.toJson();
    data['orderInfo'] = orderInfo.toJson();
    data['environment'] = environment.index;
    return data;
  }
}
