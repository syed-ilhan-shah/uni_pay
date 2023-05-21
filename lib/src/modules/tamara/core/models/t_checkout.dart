class TamaraCheckoutData {
  late String orderId;
  late String checkoutId;
  late String checkoutUrl;
  late String status;

  TamaraCheckoutData({
    required this.orderId,
    required this.checkoutId,
    required this.checkoutUrl,
    required this.status,
  });

  TamaraCheckoutData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'] ?? "";
    checkoutId = json['checkout_id'] ?? "";
    checkoutUrl = json['checkout_url'] ?? "";
    status = json['status'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['checkout_id'] = checkoutId;
    data['checkout_url'] = checkoutUrl;
    data['status'] = status;
    return data;
  }
}
