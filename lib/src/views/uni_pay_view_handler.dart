import 'package:flutter/material.dart';
import 'package:uni_pay/src/utils/extension.dart';

import '../../uni_pay.dart';
import '../modules/moyasar/views/uni_pay_moyasar_view.dart';
import '../utils/extension/size_extension.dart';
import 'design_system.dart';
import 'uni_pay_all_view.dart';

class UniPayViewHandler extends StatefulWidget {
  const UniPayViewHandler({Key? key}) : super(key: key);

  @override
  State<UniPayViewHandler> createState() => _UniPayViewHandlerState();
}

class _UniPayViewHandlerState extends State<UniPayViewHandler> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _viewHandler());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: UniPayDesignSystem.loadingIndicator());
  }

  Future _viewHandler() async {
    ScreenSizes.init(context);

    uniPayProivder.initUniPay();

    final uniPayData = uniPayProivder.uniPayData;

    ///* Check for Tamara checkout
    if (uniPayData.credentials.paymentMethods.length == 1 &&
        uniPayData.credentials.paymentMethods.first.isTamara) {
      context.uniPushReplacement(const UniPayTamara());
    } else if ((uniPayData.credentials.paymentMethods.length == 1 &&
            uniPayData.credentials.paymentMethods.first.isMoyasar) ||
        uniPayData.credentials.paymentMethods.length == 2 &&
            uniPayData.credentials.paymentMethods.isMoyasarGateway) {
      context.uniPushReplacement(const UniPayCard());
    } else {
      context.uniPushReplacement(const UniPayGatewayView());
    }
  }
}
