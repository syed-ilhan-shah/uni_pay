import 'package:uni_pay/src/core/keys/api_keys.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../../providers/uni_pay_provider.dart';

class TamaraCallBackResponse {
  late String orderId;
  late UniPayStatus paymentStatus;

  TamaraCallBackResponse({
    this.orderId = '',
    this.paymentStatus = UniPayStatus.notSpecified,
  });

  TamaraCallBackResponse.fromMap(Map<String, dynamic> json) {
    orderId = json['orderId'] ?? '';
    paymentStatus = json['paymentStatus'] == ApiKeys.approved
        ? UniPayStatus.success
        : UniPayStatus.failed;
  }

  Map<String, dynamic> toMap() => {
        "orderId": orderId,
        "paymentStatus": paymentStatus.index,
      };

  TamaraCaptureOrder get tamaraCaptureOrder {
    final uniPayData = UniPayControllers.uniPayData;
    final order = uniPayData.orderInfo;
    return TamaraCaptureOrder(
      environment: uniPayData.environment,
      tamaraToken: uniPayData.credentials.tamaraCredential!.token,
      orderId: orderId,
      totalAmount: TotalAmount(
        amount: order.transactionAmount.totalAmount,
        currency: order.transactionAmount.currency.currencyCode,
      ),
      shippingInfo: ShippingInfo(
        shippedAt: order.orderedAt ?? DateTime.now(),
        shippingCompany: uniPayData.appName,
      ),
    );
  }
}
