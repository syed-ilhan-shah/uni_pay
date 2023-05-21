import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';

import '../../../../../uni_pay.dart';
import '../../../../views/design_system.dart';

class LearnMoreTamaraWidget extends StatefulWidget {
  final num totalAmount;
  final UniPayLocale locale;
  const LearnMoreTamaraWidget(
      {Key? key, required this.totalAmount, required this.locale})
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
                url: Uri.parse(
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
