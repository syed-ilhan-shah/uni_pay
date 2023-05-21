import 'package:uni_pay/src/utils/extension.dart';

import '../../utils/uni_enums.dart';

class UniPayResponse {
  late String transactionId;
  late UniPayStatus status;
  late num amount;
  late num fee;
  UniPayCurrency currency = UniPayCurrency.sar;
  late String description;
  late String amountFormatted;
  late String ip;
  late String createdAt;
  late String invoiceId;
  late UniPayTransactionDetails transactionDetails;
  late String errorMessage;

  UniPayResponse({
    this.transactionId = "",
    this.status = UniPayStatus.notSpecified,
    this.amount = 0,
    this.fee = 0,
    this.description = "",
    this.amountFormatted = "",
    this.ip = "",
    this.createdAt = "",
    this.invoiceId = "",
    this.errorMessage = "",
    UniPayTransactionDetails? transactionDetails,
  }) : transactionDetails = transactionDetails ?? UniPayTransactionDetails();

  UniPayResponse.fromMap(Map<String, dynamic> json) {
    transactionId = json['id'] ?? "";
    status = (json['status'] == 'paid' && transactionId.isNotEmpty)
        ? UniPayStatus.success
        : UniPayStatus.failed;

    amount = json['amount'] ?? 0;
    fee = json['fee'] ?? 0;
    currency = json['currency'] ?? "";
    description = json['description'] ?? "";
    amountFormatted = json['amount_format'] ?? "0 SAR";
    ip = json['ip'] ?? "N/A";
    createdAt = json['created_at'] ?? "";
    invoiceId = json['invoice_id'] ?? "";
    errorMessage = json['errorMessage'] ?? "";
    transactionDetails = UniPayTransactionDetails.fromMap(json['source'] ?? {});
  }

  Map<String, dynamic> toMap() => {
        'transaction_id': transactionId,
        'paymentStatus': status.index,
        'amount': amount,
        'fee': fee,
        'currency': currency,
        'description': description,
        'amount_format': amountFormatted,
        'ip': ip,
        'created_at': createdAt,
        'invoice_id': invoiceId,
        'errorMessage': errorMessage,
        'source': transactionDetails.toMap(),
      };
}

class UniPayTransactionDetails {
  late UniPayPaymentMethods type;
  late String company;
  late String name;
  late String cardNumber;

  late String message;
  late String gatewayId;
  late String referenceNumber;

  UniPayTransactionDetails({
    this.type = UniPayPaymentMethods.card,
    this.company = "",
    this.name = "",
    this.cardNumber = "",
    this.message = "",
    this.gatewayId = "",
    this.referenceNumber = "",
  });

  UniPayTransactionDetails.fromMap(Map<String, dynamic> json) {
    type = (json['type'] ?? "creditcard").toString().uniPayPaymentMethod;
    company = json['company'] ?? "";
    name = json['name'] ?? "N/A";
    cardNumber = json['number'] ?? "";
    message = json['message'] ?? "";

    gatewayId = json['gateway_id'] ?? "";
    referenceNumber = json['reference_number'] ?? "";
  }

  Map<String, dynamic> toMap() => {
        'type': type.index,
        'company': company,
        'name': name,
        'cardNumber': cardNumber,
        'message': message,
        'gateway_id': gatewayId,
        'reference_number': referenceNumber,
      };
}
