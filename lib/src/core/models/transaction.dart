import 'package:uni_pay/src/utils/extension.dart';

import '../../utils/uni_enums.dart';

class TransactionAmount {
  ///* Amount of transaction
  late num totalAmount;

  ///* 15% TAX amount
  late num taxAmount;

  ///* Currency of transaction
  late UniPayCurrency currency;

  TransactionAmount({
    required this.totalAmount,
    num? taxAmount,
    this.currency = UniPayCurrency.sar,
  }) : taxAmount = taxAmount ?? totalAmount.formattedValue;

  TransactionAmount.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    taxAmount = json['tax_amount'];
    currency = UniPayCurrency.values[json['currency']];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalAmount'] = totalAmount;
    data['tax_amount'] = taxAmount;
    data['currency'] = currency.toString();
    return data;
  }
}
