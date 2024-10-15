import 'package:uni_pay/src/core/keys/api_keys.dart';
import 'package:uni_pay/uni_pay.dart';

class TabbyDto {
  /// Transaction ID from Tabby
  String transactionId;

  /// Amount of the transaction
  num amount;

  /// Credentials for Tabby, e.g: API Keys
  TabbyCredential credential;

  TabbyDto({
    required this.transactionId,
    this.amount = 0,
    required this.credential,
  });

  /// Convert Tabby DTO to JSON
  Map<String, dynamic> toTabbyJson() => {'amount': amount};

  @override
  String toString() {
    return 'TabbyDto(transactionId: $transactionId, amount: $amount, credential: $credential)';
  }

  /// Get the transaction details from Tabby API Endpoint
  Uri get transactionDetailsApi => ApiKeys.tabbyPaymentUrlById(transactionId);

  /// Get the tabby capture order API Endpoint
  Uri get captureOrderApi => ApiKeys.tabbyCaptureUrl(transactionId);
}
