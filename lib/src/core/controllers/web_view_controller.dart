import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:uni_pay/src/utils/utils.dart';

final _webViewBrowser = TabbyChromeSafariBrowser();

class WebViewController {
  /// Open the browser with the given URL as pop-up window based on the platform.
  static Future openBrowserPopUp({required WebUri url}) {
    return _webViewBrowser.open(
      url: url,
      settings: ChromeSafariBrowserSettings(
        shareState: CustomTabsShareState.SHARE_STATE_OFF,
        presentationStyle: ModalPresentationStyle.POPOVER,
      ),
    );
  }
}

class TabbyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    uniPrint("✔ Requesting to open the browser!");
  }

  @override
  void onClosed() {
    uniPrint("✘ Requesting to close the browser!");
  }
}
