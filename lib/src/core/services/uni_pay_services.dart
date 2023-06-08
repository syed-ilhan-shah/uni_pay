import 'package:uni_pay/uni_pay.dart';

import '../../modules/moyasar/core/services/uni_moyasar.dart';

class UniPayServices {
  UniPayServices._();

  ///* Capture tamara order
  static Future<TamaraCaptureOrderResponse> captureTamaraOrder(
      {required TamaraCaptureOrder tamaraCaptureOrder}) async {
    return await UniTamara.captureOrder(tamaraCaptureOrder);
  }

  ///* Get the payment by meta-data
  static Future<UniPayResponse> getPaymentDetailsByMetaDataOrderId({
    required MoyasarCredential credential,
    required String orderId,
  }) async {
    return UniPayMoyasarGateway.searchPaymentByMetaData(
        credential: credential, orderId: orderId);
  }

  ///* Get tamara order transaction information
  static Future getTamaraPaymentDetails(
      {required TamaraApiData tamaraApiData}) async {
    return await UniTamara.getTransactionInfo(tamaraApiData);
  }
}
