import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/uni_pay.dart';

class UniPayMoyasarGateway {
  UniPayMoyasarGateway._();

  ///* Process the moyasar payment
  static Future processMoyasarPayment(BuildContext context,
      {required dynamic result}) async {
    if (result is! PaymentCanceledError) {
      UniPayResponse uniPayResponse = UniPayResponse();
      if (result is PaymentResponse) {
        uniLog(result.status);
        if (result.status == PaymentStatus.paid) {
          uniPayResponse.transactionId = result.id;
          uniPayResponse.amount = result.amount;
          uniPayResponse.fee = result.fee;
          uniPayResponse.status = UniPayStatus.success;
          uniPayResponse.amountFormatted = result.amountFormat;
          uniPayResponse.ip = result.ip;
          uniPayResponse.createdAt = result.createdAt;
          uniPayResponse.invoiceId = result.invoiceId ?? "N/A";
          uniPayResponse.description = result.description ?? "N/A";
        } else {
          uniPayResponse.status = UniPayStatus.failed;
          uniPayResponse.errorMessage = UniPayText.paymentFailed;
        }
      } else if (result is ValidationError) {
        uniPayResponse.status = UniPayStatus.failed;
        uniPayResponse.transactionDetails.message = result.message;
        uniPayResponse.errorMessage = UniPayText.paymentFailed;
      }

      UniPayControllers.handlePaymentsResponseAndCallback(context,
          response: uniPayResponse);
    }
  }
}
