import 'package:flutter/material.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../modules/moyasar/core/services/uni_moyasar.dart';
import '../../providers/uni_pay_provider.dart';

class UniPayServices {
  UniPayServices._();

  ///* Initalize the UniPay with the order details, and
  ///
  ///* payment gateway credentials before making Apple pay request
  static initUniPay(
      {required UniPayData uniPayData, required BuildContext context}) {
    return UniPayControllers.setUniPayData(uniPayData, context);
  }

  ///* Capture tamara order, if your product is subscription based then you can use this method to capture the order instantly
  static Future<TamaraCaptureOrderResponse> captureTamaraOrder(
      {required TamaraCaptureOrder tamaraCaptureOrder}) async {
    return await UniTamara.captureOrder(tamaraCaptureOrder);
  }

  ///* Get the payment by meta-data, this specific method is used for Moyasar payment gateway only
  static Future<UniPayResponse> getPaymentDetailsByMetaDataOrderId({
    required MoyasarCredential credential,
    required String orderId,
  }) async {
    return UniPayMoyasarGateway.searchPaymentByMetaData(
        credential: credential, orderId: orderId);
  }

  ///* Get tamara order transaction information
  static Future<UniPayResponse> getTamaraPaymentDetails(
      {required TamaraApiData tamaraApiData}) async {
    return await UniTamara.getTransactionInfo(tamaraApiData);
  }
}
