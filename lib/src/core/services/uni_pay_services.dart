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

  // ----------------- Tamara related sevices ----------------- //

  ///* Capture tamara order, if your product is subscription based then you can use this method to capture the order instantly
  static Future<TamaraCaptureOrderResponse> captureTamaraOrder(
      {required TamaraCaptureOrder tamaraCaptureOrder}) async {
    return await UniTamara.captureOrder(tamaraCaptureOrder);
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

  // ----------------- Tabby related sevices ----------------- //

  /// Get the transaction details from [Tabby] gateway by providing the required data.
  static Future<TabbyTransaction> getTabbyTransactionDetails(
      {required TabbyDto tabbyDto}) {
    return UniTabbyServices.getTabbyTransactionDetails(tabbyDto: tabbyDto);
  }

  /// Capture the transaction to Tabby, so that they will complete the payment for your merchant.
  static Future<TabbyTransaction> captureTabbyPayment(
      {required TabbyDto tabbyDto}) {
    return UniTabbyServices.captureTabbyPayment(tabbyDto: tabbyDto);
  }

  /// Initialize the Tabby SDK to prepare for payment.
  ///
  /// Don't use this method if you aren't aware of what you're doing ^_^
  static void initializeTabbySDK({TabbyCredential? credentials}) {
    return UniTabbyServices.initTabbySDK(credentials);
  }

  // ----------------- Moyasar related sevices ----------------- //

  /// Get the payment by [transaction id] from the `moyasar` gateway.
  static Future<UniPayResponse> getMoyasarPaymentByTransactionId({
    required MoyasarCredential credential,
    required String transactionId,
  }) async {
    return UniPayMoyasarGateway.getTrxnById(
        credential: credential, trxnId: transactionId);
  }

  ///* Get the payment by meta-data, this specific method is used for Moyasar payment gateway only
  static Future<UniPayResponse> getMoyasarPaymentByMetaDataOrderId({
    required MoyasarCredential credential,
    required String orderId,
  }) async {
    return UniPayMoyasarGateway.searchPaymentByMetaData(
        credential: credential, orderId: orderId);
  }
}
