import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';

import '../../../../../uni_pay.dart';
import '../../../../views/design_system.dart';

class LearnMoreTamaraWidget extends StatefulWidget {
  final num totalAmount;
  final UniPayLocale locale;
  final WebUri? url;
  const LearnMoreTamaraWidget(
      {Key? key, required this.totalAmount, required this.locale, this.url})
      : super(key: key);

  @override
  State<LearnMoreTamaraWidget> createState() => _LearnMoreTamaraWidgetState();
}

class _LearnMoreTamaraWidgetState extends State<LearnMoreTamaraWidget> {
  final ValueNotifier<UniPayCurrentState> _stateNotifier =
      ValueNotifier(UniPayCurrentState.loading);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: 10.br),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: 100.w,
        height: 60.h,
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: widget.url ??
                    WebUri(
                      UniTamara.getTamaraCDN(
                          price: widget.totalAmount, locale: widget.locale),
                    ),
              ),
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  _stateNotifier.value = UniPayCurrentState.success;
                }
              },
            ),
            ValueListenableBuilder(
              valueListenable: _stateNotifier,
              builder: (_, state, ___) => Visibility(
                visible: state.isLoading,
                child: UniPayDesignSystem.loadingIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// https://cdn-sandbox.tamara.co/widget-v2/tamara-widget.html?lang=en&public_key=pk_1257cd35-99f8-40b5-ae9d-fc4e2f884a69&country=SA&amount=350&inline_type=2