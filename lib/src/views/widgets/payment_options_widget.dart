import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../constant/path.dart';
import '../../theme/colors.dart';
import '../design_system.dart';

class UniPaymentOptionWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final bool currentStatus;
  final ValueChanged<bool>? onChange;
  final Color? activeColor;
  final UniPayPaymentMethods uniPayPaymentMethods;
  final VoidCallback? onLearnMorePressed;

  const UniPaymentOptionWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.currentStatus,
    required this.onChange,
    this.activeColor,
    required this.uniPayPaymentMethods,
    this.onLearnMorePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: UniPayColorsPalletes.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.rh),
        child: GestureDetector(
          // overlayColor: UniPayColorsPalletes.transparentMaterialColor,
          onTap: () => onChange?.call(!currentStatus),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Checkbox
              UniPayDesignSystem.checkBox(
                activeColor: activeColor ?? UniPayColorsPalletes.black,
                status: currentStatus,
                onChange: onChange,
              ),
              5.hs,
              //* Title and subtitle
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: UniPayTheme.uniPayStyle,
                    ),
                    2.vs,
                    RichText(
                      text: TextSpan(
                          text: "$subTitle ",
                          style: UniPayTheme.uniPayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.rSp,
                            color: UniPayColorsPalletes.greyTextColor,
                          ),
                          children: [
                            if (onLearnMorePressed != null)
                              TextSpan(
                                text: UniPayText.learnMore,
                                style: UniPayTheme.uniPayStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: UniPayColorsPalletes.primaryColor,
                                  fontSize: 10.rSp,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = onLearnMorePressed,
                              )
                          ]),
                    )
                  ],
                ),
              ),
              10.hs,

              //* Tamara logo
              Image.asset(
                "${UniAssetsPath.images}/$image.png",
                fit: BoxFit.contain,
                width: uniPayPaymentMethods.isTamara ? 39.rSp : 100.rw,
                height: uniPayPaymentMethods.isTamara ? 39.rSp : 40.rh,
                package: UniAssetsPath.packageName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
