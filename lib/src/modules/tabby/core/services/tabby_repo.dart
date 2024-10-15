import 'dart:convert';

import 'package:uni_pay/src/utils/extension.dart';

import '../../../../utils/utils.dart';
import '../models/tabby_dto.dart';
import '../models/tabby_trxn.dart';
import 'package:http/http.dart' as http_client;

abstract class ITamaraRepo {
  ///* Capture the order as soon as the payment is successful
  Future<TabbyTransaction> captureTabbyOrder({required TabbyDto tabbyDto});

  /// Get the transaction information, in the [TabbyTransaction] model
  Future<TabbyTransaction> getTransactionDetails({required TabbyDto tabbyDto});
}

class TabbyRepo implements ITamaraRepo {
  @override
  Future<TabbyTransaction> getTransactionDetails(
      {required TabbyDto tabbyDto}) async {
    TabbyTransaction trxn = TabbyTransaction();
    try {
      http_client.Response response = await http_client.get(
        tabbyDto.transactionDetailsApi,
        headers: tabbyDto.credential.tabbyHeaders,
      );
      uniLog("✔ Response from Tabby: ${response.body}");
      final data = json.decode(response.body);
      if (response.statusCode.isSuccess) {
        trxn = TabbyTransaction.fromMap(data);
      } else {
        trxn.errorMessage = data["error"] ?? "No transaction found!";
        trxn.status = TabbyResStatus.failed;
        uniLog("✘ Error in Tabby res: $data");
      }
    } catch (e) {
      uniLog("✘ Error in Tabby transaction: $e");
      trxn.errorMessage = e.toString();
    }

    uniLog("✔ Get Tabby transaction called: $trxn");
    return trxn;
  }

  @override
  Future<TabbyTransaction> captureTabbyOrder(
      {required TabbyDto tabbyDto}) async {
    TabbyTransaction trxn = TabbyTransaction();
    try {
      http_client.Response response = await http_client.post(
        tabbyDto.captureOrderApi,
        headers: tabbyDto.credential.tabbyHeaders,
        body: json.encode(tabbyDto.toTabbyJson()),
      );
      // uniLog("✔ Response from Tabby: ${response.body}");
      final data = json.decode(response.body);
      if (response.statusCode.isSuccess) {
        trxn = TabbyTransaction.fromMap(data);
      } else {
        trxn.errorMessage = data["error"] ?? "No transaction found!";
        trxn.status = TabbyResStatus.failed;
        uniLog("✘ Error in Tabby res: $data");
      }
    } catch (e) {
      uniLog("✘ Error in Tabby capture: $e");
      trxn.errorMessage = e.toString();
    }

    uniLog("✔ Capture Tabby transaction called: $trxn");
    return trxn;
  }
}
