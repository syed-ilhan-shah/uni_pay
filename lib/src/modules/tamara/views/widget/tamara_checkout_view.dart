import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:uni_pay/src/views/design_system.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../../../core/keys/api_keys.dart';

class TamaraCheckoutView extends StatefulWidget {
  ///* Contains the checkout url and the success, failed and cancel callbacks
  final TamaraUrls tamaraUrls;
  final ValueChanged<String?> onPaymentSuccess;
  final VoidCallback onPaymentFailed;
  final VoidCallback onPaymentCanceled;
  const TamaraCheckoutView(
      {Key? key,
      required this.tamaraUrls,
      required this.onPaymentSuccess,
      required this.onPaymentFailed,
      required this.onPaymentCanceled})
      : super(key: key);

  @override
  State<TamaraCheckoutView> createState() => _TamaraCheckoutViewState();
}

class _TamaraCheckoutViewState extends State<TamaraCheckoutView> {
  final _viewKey = GlobalKey();
  late InAppWebViewController inAppViewController;
  final ValueNotifier<UniPayCurrentState> _currentStateNotifier =
      ValueNotifier(UniPayCurrentState.loading);
  @override
  Widget build(BuildContext context) {
    final tamaraUrls = widget.tamaraUrls;
    return Scaffold(
      body: Stack(
        children: [
          InAppWebView(
            key: _viewKey,
            initialOptions: ApiKeys.webViewGroupOptions,
            initialUrlRequest:
                URLRequest(url: Uri.parse(tamaraUrls.checkoutUrl)),
            shouldOverrideUrlLoading: (controller, action) async {
              inAppViewController = controller;
              String? currentLoadedUrl = action.request.url?.toString();
              uniLog("Url: $currentLoadedUrl");
              NavigationActionPolicy actionPolicy =
                  NavigationActionPolicy.ALLOW;
              if (currentLoadedUrl != null) {
                //* Success
                if (currentLoadedUrl.startsWith(tamaraUrls.successUrl)) {
                  actionPolicy = NavigationActionPolicy.CANCEL;
                  String? orderId =
                      action.request.url?.queryParameters["orderId"];
                  widget.onPaymentSuccess.call(orderId);
                }
                //* Failed
                else if (currentLoadedUrl.startsWith(tamaraUrls.failedUrl)) {
                  actionPolicy = NavigationActionPolicy.CANCEL;
                  widget.onPaymentFailed.call();
                }
                //* Cancelled
                else if (currentLoadedUrl.startsWith(tamaraUrls.cancelUrl)) {
                  actionPolicy = NavigationActionPolicy.CANCEL;
                  widget.onPaymentCanceled.call();
                }
              }
              return actionPolicy;
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                _currentStateNotifier.value = UniPayCurrentState.success;
              }
            },
          ),
          ValueListenableBuilder(
            valueListenable: _currentStateNotifier,
            builder: (_, state, ___) => Visibility(
                visible: state.isLoading,
                child: UniPayDesignSystem.loadingIndicator()),
          ),
        ],
      ),
    );
  }
}

class TamaraUrls {
  final String checkoutUrl;
  final String successUrl;
  final String failedUrl;
  final String cancelUrl;

  TamaraUrls({
    required this.checkoutUrl,
    required this.successUrl,
    required this.failedUrl,
    required this.cancelUrl,
  });
}
