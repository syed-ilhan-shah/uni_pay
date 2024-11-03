import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:uni_pay/src/constant/path.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/core/controllers/web_view_controller.dart';
import 'package:uni_pay/src/modules/tamara/core/models/tamara_snippet.dart';
import 'package:uni_pay/src/theme/colors.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';

import '../../../../../uni_pay.dart';

final _browser = ChromeSafariBrowser();

class TamaraCampaign extends StatelessWidget {
  /// Is From Product Page
  final bool isFromProductPage;

  /// Campaign DTO
  final TamaraSnippet campaign;

  const TamaraCampaign({
    super.key,
    this.isFromProductPage = true,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    UniPayText.isEnglish = campaign.locale.isEnglish;

    return InkWell(
      onTap: () {
        if (!isFromProductPage) _openTamaraPaymentDialog(context);
      },
      child: Container(
        width: 100.w,
        padding: EdgeInsets.all(10.rSp),
        decoration: BoxDecoration(
          border: Border.all(color: UniPayColorsPalletes.black.withOpacity(.1)),
          borderRadius: 10.br,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isFromProductPage) logoImage(campaign),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 9.rSp),
                child: RichText(
                  text: TextSpan(
                    text: isFromProductPage
                        ? UniPayText.tamaraCampaign1
                        : UniPayText.tamaraCheckoutTitle,
                    style: UniPayTheme.uniPaySubTitleStyle,
                    children: isFromProductPage
                        ? [
                            TextSpan(
                              text: UniPayText.sar(150),
                              style: UniPayTheme.uniPayStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: UniPayColorsPalletes.black,
                              ),
                            ),
                            TextSpan(
                              text: UniPayText.tamaraCampaign2,
                            ),
                            TextSpan(
                              text: " ${UniPayText.learnMore}",
                              style: UniPayTheme.uniPayStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                color: UniPayColorsPalletes.black,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => _openTamaraPaymentDialog(context),
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            ),
            if (isFromProductPage) logoImage(campaign),
          ],
        ),
      ),
    );
  }

  /// Tamara Campaign Logo Widget
  Widget logoImage(TamaraSnippet campaign) {
    return Image.asset(
      "${UniAssetsPath.icons}/tamara-${campaign.locale.code}.png",
      fit: BoxFit.contain,
      width: 55.rw,
      package: UniAssetsPath.packageName,
    );
  }

  /// Open the Tamara payment alert dialog
  Future _openTamaraPaymentDialog(BuildContext context) async {
    return WebViewController.openBrowserPopUp(
      url: isFromProductPage
          ? campaign.productPageCampaignCDN
          : campaign.checkoutPageCampaignCDN,
    );
  }
}
