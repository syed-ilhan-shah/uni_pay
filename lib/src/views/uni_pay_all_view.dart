import 'package:flutter/material.dart';
import 'package:uni_pay/src/modules/moyasar/views/moyasar_card_widget.dart';
import 'package:uni_pay/src/modules/moyasar/views/uni_pay_moyasar_view.dart';
import 'package:uni_pay/src/utils/extension.dart';

import '../../uni_pay.dart';
import '../constant/uni_text.dart';
import '../modules/applepay/uni_apple_pay.dart';
import '../modules/tamara/views/tamara_pay_view.dart';
import 'design_system.dart';

class UniPayGatewayView extends StatefulWidget {
  const UniPayGatewayView({Key? key}) : super(key: key);

  @override
  State<UniPayGatewayView> createState() => _UniPayGatewayViewState();
}

class _UniPayGatewayViewState extends State<UniPayGatewayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniPayDesignSystem.appBar(title: UniPayText.checkout),
      body: _allPaymentView(),
    );
  }

  Widget _allPaymentView() {
    return ValueListenableBuilder(
        valueListenable: UniPayControllers.uniPayPaymentMethods,
        builder: (context, uniPayPaymentMethods, __) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///* Apple Pay View
                const UniPayApplePay(),
                30.vs,

                ///* Moyasar View
                CardPaymentWidget(
                  widgetData: WidgetData(
                    currentStatus: uniPayPaymentMethods.isCard,
                    locale: UniPayControllers.uniPayData.locale,
                    onChange: (s) => UniPayControllers.changePaymentMethod(
                        UniPayPaymentMethods.card),
                  ),
                ),
                const Divider(),

                ///* Tamara View
                TamaraSplitPlanWidget(
                  widgetData: WidgetData(
                    currentStatus: uniPayPaymentMethods.isTamara,
                    locale: UniPayControllers.uniPayData.locale,
                    totalAmount: UniPayControllers
                        .uniPayData.orderInfo.transactionAmount.totalAmount,
                    onChange: (s) => UniPayControllers.changePaymentMethod(
                        UniPayPaymentMethods.tamara),
                  ),
                ),
                const Spacer(),

                //* Pay Now Button
                UniPayDesignSystem.primaryButton(
                  isBottomBarButton: true,
                  isDisabled: uniPayPaymentMethods.isNotSpecified,
                  title: UniPayText.payNow,
                  onPressed: () {
                    //* Go to Tamara view
                    if (uniPayPaymentMethods.isTamara) {
                      context.uniPushReplacement(const UniPayTamara());
                    }
                    //* Go to Moyasar view
                    else if (uniPayPaymentMethods.isCard) {
                      context.uniPushReplacement(const UniPayCard());
                    }
                  },
                ),
              ],
            ),
          );
        });
  }
}
