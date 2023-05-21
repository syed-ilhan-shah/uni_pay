import 'package:flutter/material.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/views/widgets/payment_options_widget.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../../constant/uni_text.dart';
import '../../../../core/models/widget_data.dart';
import 'learn_more_widget.dart';

class TamaraSplitPlanWidget extends StatelessWidget {
  final WidgetData widgetData;
  const TamaraSplitPlanWidget({Key? key, required this.widgetData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizes.init(context);
    UniPayText.isEnglish = widgetData.locale.isEnglish;
    return UniPaymentOptionWidget(
      title: UniPayText.tamaraSplitBill,
      subTitle: UniPayText.tamaraSplitBillSubTitle,
      image: "tamara",
      currentStatus: widgetData.currentStatus,
      onChange: widgetData.onChange,
      activeColor: widgetData.activeColor,
      uniPayPaymentMethods: UniPayPaymentMethods.tamara,
      onLearnMorePressed: () {
        showDialog(
            context: context,
            builder: (_) => LearnMoreTamaraWidget(
                totalAmount: widgetData.totalAmount ?? 0,
                locale: widgetData.locale));
      },
    );
  }
}
