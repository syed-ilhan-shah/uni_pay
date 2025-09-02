import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';
import 'package:uni_pay/src/modules/moyasar/core/services/uni_moyasar.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';

import '../../../uni_pay.dart';
import '../../core/controllers/uni_pay_controller.dart';
import '../../core/keys/api_keys.dart';

class UniApplePay extends StatefulWidget {
  /// Uni Apple Pay Widget - You can pass the `context` and `UniPayData` to the widget directly
  ///
  /// or you may call `UniPayServices.initUniPay()` before using this widget to initialize the `UniPay` module
  /// both ways are valid and will work as expected

  const UniApplePay({Key? key, this.context, this.uniPayData})
      : super(key: key);

  /// Provide the context of the app
  final BuildContext? context;

  /// Uni Pay Data to be used for payment request
  final UniPayData? uniPayData;

  @override
  State<UniApplePay> createState() => _UniApplePayState();
}

class _UniApplePayState extends State<UniApplePay> {
  @override
  void initState() {
    super.initState();
    // Init UniPay with the order details payment gateway credentials before making Apple pay request
    if (widget.uniPayData != null && widget.context != null) {
      UniPayControllers.setUniPayData(
        widget.uniPayData!,
        widget.context!,
        isInitTabbySdk: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (UniPayControllers.uniPayData.credentials.paymentMethods.isApplePay) {
      return Container(
        height: 45.rSp,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: 10.rSp.br),
        child: ApplePay(
          config: ApiKeys.moyasarPaymentConfig,
          onPaymentResult: (r) => UniPayMoyasarGateway.processMoyasarPayment(
              context,
              result: r,
              isFromApplePay: true),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
