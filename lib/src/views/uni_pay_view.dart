import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/views/widgets/uni_pay_view_handler.dart';
import 'package:uni_pay/uni_pay.dart';

import '../constant/locale.dart';

import '../theme/colors.dart';

final uniStateKey = GlobalKey<NavigatorState>();

class UniPay extends StatefulWidget {
  ///* Provide the context of the app
  final BuildContext context;

  ///* Uni Pay Data to be used for payment request
  final UniPayData uniPayData;

  const UniPay({
    Key? key,
    required this.context,
    required this.uniPayData,
  }) : super(key: key);

  @override
  State<UniPay> createState() => _UniPayState();
}

class _UniPayState extends State<UniPay> {
  @override
  void initState() {
    super.initState();
    UniPayControllers.setUniPayData(widget.uniPayData, widget.context);
  }

  @override
  Widget build(BuildContext context) {
    final uniPayData = widget.uniPayData;
    UniPayText.isEnglish = uniPayData.locale.isEnglish;
    return MaterialApp(
      navigatorKey: uniStateKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: LocalizationsData.localizationsDelegate,
      supportedLocales: LocalizationsData.supportLocale,
      theme: UniPayTheme.theme,
      locale: UniPayText.isEnglish
          ? LocalizationsData.supportLocale.last
          : LocalizationsData.supportLocale.first,
      home: const UniPayViewHandler(),
    );
  }
}


// ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:uni_pay/src/utils/extension.dart';
// import 'package:uni_pay/uni_pay.dart';

// import '../views/widgets/payment_result_view.dart';

// UniPayProivder uniPayProivder = UniPayProivder.get(uniStateKey.currentContext!);

// class UniPayProivder extends ChangeNotifier {
//   static UniPayProivder get(BuildContext context) =>
//       Provider.of(context, listen: false);

//   ///* Uni Pay Data to be used for payment request
//   late UniPayData uniPayData;

//   ///* Set UniPayData
//   void setUniPayData(UniPayData uniPayData) {
//     this.uniPayData = uniPayData;
//     notifyListeners();
//   }

//   ///* Initialize UniPay all payment methods
//   Future initUniPay() async {
//     if (uniPayCurrentState.isNotSpecified) {
//       uniPayCurrentState = UniPayCurrentState.loading;

//       //* Check for Tamara checkout
//       if (uniPayData.credentials.paymentMethods
//           .contains(UniPayPaymentMethods.tamara)) {
//         tamaraCheckout = await UniTamara.generateTamaraCheckoutUrls(uniPayData);
//       }
//       //* Check for Moyasar gateway
//       uniPayCurrentState = uniPayData.credentials.paymentMethods.isTamaraGateway
//           ? tamaraCheckout != null
//               ? UniPayCurrentState.success
//               : UniPayCurrentState.failed
//           : UniPayCurrentState.success;
//       notifyListeners();
//     }
//   }

//   ///* Tamara checkout data
//   TamaraCheckoutData? tamaraCheckout;
//   void setTamaraCheckout(TamaraCheckoutData tamaraCheckout) {
//     this.tamaraCheckout = tamaraCheckout;
//     notifyListeners();
//   }

//   ///* State changes
//   UniPayCurrentState uniPayCurrentState = UniPayCurrentState.notSpecified;

//   ///* Uni Pay payment status
//   UniPayStatus uniPayStatus = UniPayStatus.failed;

//   ///* Handle and call the callback function for payment status
//   Future handlePaymentsResponseAndCallback(BuildContext context,
//       {required UniPayResponse response}) async {
//     uniPayStatus = response.status;
//     notifyListeners();

//     context.uniPushReplacement(const PaymentResultView());
//     await Future.delayed(const Duration(seconds: 2));

//     //* Success
//     if (response.status.isSuccess) {
//       uniPayData.onPaymentSucess.call(response);
//     }
//     //* Failed
//     else {
//       uniPayData.onPaymentFailed.call(response);
//     }
//   }

//   ///* Payment Methods
//   UniPayPaymentMethods uniPayPaymentMethods = UniPayPaymentMethods.notSpecified;
//   void changePaymentMethod(UniPayPaymentMethods paymentMethod) {
//     uniPayPaymentMethods = paymentMethod;
//     notifyListeners();
//   }
// }
