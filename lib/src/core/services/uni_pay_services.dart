import 'package:flutter/material.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../modules/moyasar/core/services/uni_moyasar.dart';
import '../../modules/tamara/views/widget/tamara_campaign.dart';
import '../../core/controllers/uni_pay_controller.dart';
import '../controllers/web_view_controller.dart';

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

  ///* Get the Product page snippet from Tamara
  static Widget tamaraProductPageSnippet({required TamaraSnippet snippet}) {
    return TamaraCampaign(campaign: snippet);
  }

  ///* Get the Checkout page campaign from Tamara
  static Widget tamaraCheckoutPageSnippet({required TamaraSnippet snippet}) {
    return TamaraCampaign(campaign: snippet, isFromProductPage: false);
  }

  ///* View the Checkout page campaign from Tamara
  static Future openTamaraCheckoutPopUp({required TamaraSnippet snippet}) {
    return WebViewController.openBrowserPopUp(
        url: snippet.checkoutPageCampaignCDN);
  }
}
