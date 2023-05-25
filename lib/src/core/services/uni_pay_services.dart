import 'package:uni_pay/src/modules/tamara/core/models/capture_order.dart';
import 'package:uni_pay/src/modules/tamara/core/models/capture_response.dart';
import 'package:uni_pay/src/modules/tamara/core/services/uni_tamara.dart';

class UniPayServices {
  UniPayServices._();

  ///* Capture tamara order
  static Future<TamaraCaptureOrderResponse> captureTamaraOrder(
      {required TamaraCaptureOrder tamaraCaptureOrder}) async {
    return await UniTamara.captureOrder(tamaraCaptureOrder);
  }
}
