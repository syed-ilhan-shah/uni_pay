import '../../../../../uni_pay.dart';

class TamaraCaptureOrderResponse {
  late String captureId;
  late String status;
  late String orderId;
  late TotalAmount capturedAmount;
  late UniPayStatus paymentStatus;
  late String message;

  TamaraCaptureOrderResponse({
    this.captureId = "",
    this.status = "",
    this.orderId = "",
    TotalAmount? capturedAmount,
    this.paymentStatus = UniPayStatus.failed,
    this.message = "",
  }) : capturedAmount = capturedAmount ?? TotalAmount(amount: 0);

  TamaraCaptureOrderResponse.fromJson(
      Map<String, dynamic> json, bool isSuccess) {
    captureId = json['capture_id'];
    status = json['status'];
    orderId = json['order_id'];
    capturedAmount = TotalAmount.fromJson(json['captured_amount']);
    paymentStatus = isSuccess ? UniPayStatus.success : UniPayStatus.failed;
    message = json['message'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['capture_id'] = captureId;
    data['status'] = status;
    data['order_id'] = orderId;
    data['captured_amount'] = capturedAmount.toJson();
    data['paymentStatus'] = paymentStatus.index;
    data['message'] = message;

    return data;
  }
}
