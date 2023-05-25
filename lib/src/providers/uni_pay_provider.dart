// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/uni_pay.dart';

import '../views/widgets/payment_result_view.dart';

class UniPayControllers {
  UniPayControllers._();
  static late BuildContext context;

  ///* Uni Pay Data to be used for payment request
  static late UniPayData uniPayData;

  ///* Set UniPayData
  static void setUniPayData(UniPayData data, BuildContext appContext) {
    uniPayData = data;
    context = appContext;
  }

  ///* Initialize Tamara all payment methods
  static ValueNotifier<UniPayCurrentState> tamaraNotifier =
      ValueNotifier<UniPayCurrentState>(UniPayCurrentState.notSpecified);

  ///* Tamara checkout data
  static TamaraCheckoutData tamaraCheckout = TamaraCheckoutData();
  static Future<TamaraCheckoutData?> initTamaraPay() async {
    tamaraNotifier.value = UniPayCurrentState.loading;

    //* Check for Tamara checkout
    tamaraCheckout = await UniTamara.generateTamaraCheckoutUrls(uniPayData);
    //* Check for Moyasar gateway
    tamaraNotifier.value = tamaraCheckout.isSuccess
        ? UniPayCurrentState.success
        : UniPayCurrentState.failed;
    return tamaraCheckout;
  }

  ///* State changes
  UniPayCurrentState uniPayCurrentState = UniPayCurrentState.notSpecified;

  ///* Uni Pay payment status
  static UniPayStatus uniPayStatus = UniPayStatus.failed;

  ///* Handle and call the callback function for payment status
  static Future handlePaymentsResponseAndCallback(BuildContext context,
      {required UniPayResponse response}) async {
    uniPayStatus = response.status;
    context.uniPushReplacement(const PaymentResultView());
    await Future.delayed(const Duration(seconds: 2));

    UniPayControllers.context.uniParentPop();
    //* Success
    if (response.status.isSuccess) {
      uniPayData.onPaymentSucess.call(response);
    }
    //* Failed
    else {
      uniPayData.onPaymentFailed.call(response);
    }
  }

  ///* Payment Methods
  static ValueNotifier<UniPayPaymentMethods> uniPayPaymentMethods =
      ValueNotifier(UniPayPaymentMethods.notSpecified);
  static void changePaymentMethod(UniPayPaymentMethods paymentMethod) {
    uniPayPaymentMethods.value = paymentMethod;
  }
}
