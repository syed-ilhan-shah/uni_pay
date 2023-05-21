import 'package:flutter/material.dart';
import 'package:uni_pay/src/utils/uni_enums.dart';

import '../../../constant/uni_text.dart';
import '../../../core/models/widget_data.dart';
import '../../../utils/extension/size_extension.dart';
import '../../../views/widgets/payment_options_widget.dart';

class CardPaymentWidget extends StatelessWidget {
  final WidgetData widgetData;
  const CardPaymentWidget({Key? key, required this.widgetData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizes.init(context);
    UniPayText.isEnglish = widgetData.locale.isEnglish;
    return UniPaymentOptionWidget(
      title: UniPayText.payWithCard,
      subTitle: UniPayText.payByCardSubTitle,
      image: "cards",
      currentStatus: widgetData.currentStatus,
      onChange: widgetData.onChange,
      activeColor: widgetData.activeColor,
      uniPayPaymentMethods: UniPayPaymentMethods.card,
    );
  }
}
