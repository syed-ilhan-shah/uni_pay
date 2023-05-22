import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/modules/tamara/views/widget/tamara_checkout_view.dart';
import 'package:uni_pay/src/views/design_system.dart';
import 'package:uni_pay/uni_pay.dart';

class UniPayTamara extends StatefulWidget {
  const UniPayTamara({Key? key}) : super(key: key);

  @override
  State<UniPayTamara> createState() => _UniPayTamaraState();
}

class _UniPayTamaraState extends State<UniPayTamara> {
  @override
  void initState() {
    UniPayControllers.initTamaraPay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniPayDesignSystem.appBar(title: UniPayText.checkoutByTamara),
      body: ValueListenableBuilder(
        valueListenable: UniPayControllers.tamaraNotifier,
        builder: (_, status, __) {
          final tamaraCheckout = UniPayControllers.tamaraCheckout;
          if (status.isLoading) {
            return UniPayDesignSystem.loadingIndicator();
          } else if (status.isSuccess && tamaraCheckout.isSuccess) {
            final merchantUrls = UniPayControllers
                .uniPayData.credentials.tamaraCredential!.merchantUrl;
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
          } else {
            return UniPayDesignSystem.errorView(
                title: tamaraCheckout.errorMessage,
                subTitle: tamaraCheckout.errors);
          }
        },
      ),
    );
  }
}
