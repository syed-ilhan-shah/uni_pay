import 'transaction.dart';
import 'uni_pay_item.dart';

class UniPayOrder {
  ///* Transaction amount
  late TransactionAmount transactionAmount;

  ///* Order Id
  late String orderId;

  ///* Desacription of transaction
  late String description;

  ///* List of items in order
  late List<UniPayItem> items;

  UniPayOrder({
    required this.transactionAmount,
    required this.orderId,
    required this.description,
    required this.items,
  });

  UniPayOrder.fromJson(Map<String, dynamic> json) {
    transactionAmount = TransactionAmount.fromJson(json['transactionAmount']);
    orderId = json['orderId'];
    description = json['description'];
    items = json['items'].map((e) => UniPayItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transactionAmount'] = transactionAmount.toJson();
    data['orderId'] = orderId;
    data['description'] = description;
    data['items'] = items.map((e) => e.toJson()).toList();
    return data;
  }
}
