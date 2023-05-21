import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';
import 'package:uni_pay/src/modules/moyasar/core/services/uni_moyasar.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';

import '../../uni_pay.dart';
import '../core/keys/api_keys.dart';

class UniPayApplePay extends StatelessWidget {
  const UniPayApplePay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (uniPayProivder.uniPayData.credentials.paymentMethods.isApplePay) {
      return Container(
        height: 45.rSp,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: 10.rSp.br),
        child: ApplePay(
          config: ApiKeys.moyasarPaymentConfig,
          onPaymentResult: (r) =>
              UniPayMoyasarGateway.processMoyasarPayment(context, result: r),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
