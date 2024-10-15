import 'package:flutter/material.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/views/widgets/payment_options_widget.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../../constant/uni_text.dart';

class TabbySplitPlanWidget extends StatelessWidget {
  final WidgetData widgetData;
  const TabbySplitPlanWidget({Key? key, required this.widgetData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizes.init(context);
    UniPayText.isEnglish = widgetData.locale.isEnglish;
    return UniPaymentOptionWidget(
      title: UniPayText.tabbySplitBill,
      subTitle: "",
      image: "tabby",
      currentStatus: widgetData.currentStatus,
      onChange: widgetData.onChange,
      activeColor: widgetData.activeColor,
      uniPayPaymentMethods: UniPayPaymentMethods.tabby,
      subTitleWidget: UniTabbyServices.showTabbyCheckoutSnippet(
        tabbySnippet: TabbySnippet(
          totalAmountWithVat: widgetData.totalAmount ?? 0,
          currency: widgetData.currency,
          locale: widgetData.locale,
        ),
      ),
    );
  }
}
