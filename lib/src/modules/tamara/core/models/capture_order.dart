import 'package:uni_pay/uni_pay.dart';

class TamaraCaptureOrder {
  late String tamaraToken;
  late String orderId;
  late TotalAmount totalAmount;
  late ShippingInfo shippingInfo;
  late UniPayEnvironment environment;

  TamaraCaptureOrder({
    required this.tamaraToken,
    required this.orderId,
    required this.totalAmount,
    required this.shippingInfo,
    required this.environment,
  });

  TamaraCaptureOrder.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    totalAmount = TotalAmount.fromJson(json['total_amount']);
    shippingInfo = ShippingInfo.fromJson(json['shipping_info']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['total_amount'] = totalAmount.toJson();
    data['shipping_info'] = shippingInfo.toJson();
    return data;
  }
}

class ShippingInfo {
  late DateTime shippedAt;
  late String shippingCompany;

  ShippingInfo({
    required this.shippedAt,
    required this.shippingCompany,
  });

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    shippedAt = DateTime.parse(json['shipped_at']);
    shippingCompany = json['shipping_company'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['shipped_at'] = shippedAt.toIso8601String();
    data['shipping_company'] = shippingCompany;

    return data;
  }
}
