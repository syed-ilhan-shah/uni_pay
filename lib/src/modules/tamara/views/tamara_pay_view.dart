import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/modules/tamara/views/widget/tamara_checkout_view.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../views/design_system.dart';

class UniPayTamara extends StatefulWidget {
  const UniPayTamara({Key? key}) : super(key: key);

  @override
  State<UniPayTamara> createState() => _UniPayTamaraState();
}

class _UniPayTamaraState extends State<UniPayTamara> {
  @override
  Widget build(BuildContext context) {
    return UniPayScaffold(
      title: UniPayText.checkoutByTamara,
      builder: (_) {
        final tamaraCheckout = uniPayProivder.tamaraCheckout!;
        final merchantUrls =
            uniPayProivder.uniPayData.credentials.tamaraCredential!.merchantUrl;
        return TamaraCheckoutView(
          tamaraUrls: TamaraUrls(
            checkoutUrl: tamaraCheckout.checkoutUrl,
            successUrl: merchantUrls.success,
            failedUrl: merchantUrls.failure,
            cancelUrl: merchantUrls.cancel,
          ),
          onPaymentSuccess: (orderId) {
            UniTamara.processTamaraPayment(context, UniPayStatus.success,
                transactionId: orderId);
          },
          onPaymentFailed: () {
            UniTamara.processTamaraPayment(context, UniPayStatus.failed);
          },
          onPaymentCanceled: () {
            UniTamara.processTamaraPayment(context, UniPayStatus.cancelled);
          },
        );
      },
    );
  }
}
