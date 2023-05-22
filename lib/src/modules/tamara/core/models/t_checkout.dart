import 'package:uni_pay/src/constant/uni_text.dart';

class TamaraCheckoutData {
  late bool isSuccess;
  late String orderId;
  late String checkoutId;
  late String checkoutUrl;
  late String status;
  String errorMessage = UniPayText.somethingWentWrong;
  dynamic errors;

  TamaraCheckoutData({
    this.isSuccess = false,
    this.orderId = "",
    this.checkoutId = "",
    this.checkoutUrl = "",
    this.status = "",
  });

  TamaraCheckoutData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'] ?? "";
    checkoutId = json['checkout_id'] ?? "";
    checkoutUrl = json['checkout_url'] ?? "";
    status = json['status'] ?? "";
    isSuccess = checkoutUrl.isNotEmpty && orderId.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['order_id'] = orderId;
    data['checkout_id'] = checkoutId;
    data['checkout_url'] = checkoutUrl;
    data['status'] = status;
    data['errorMessage'] = errorMessage;

    return data;
  }
}
