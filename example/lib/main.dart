import 'package:flutter/material.dart';
import 'package:uni_pay/uni_pay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniPay Example',
      home: PaymentView(),
    );
  }
}

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return UniPay(
      context: context,
      uniPayData: UniPayData(
        appName: "UniPay",
        locale: UniPayLocale.en,
        customerInfo: UniPayCustomerInfo(
          fullName: "Mohammad Saif",
          email: "example@mail.com",
          phoneNumber: "+966555666777",
          address: UniPayAddress(addressName: "Test Address", city: "Riyadh"),
        ),
        environment: UniPayEnvironment.development,
        credentials: UniPayCredentials(
          applePayMerchantIdentifier: "merchant.com.mystore.sa",
          paymentMethods: [
            // UniPayPaymentMethods.card,
            // UniPayPaymentMethods.applepay,
            UniPayPaymentMethods.tamara,
          ],
          moyasarCredential:
              MoyasarCredential(publishableKey: "pk_key", secretKey: "sk_key"),
          tamaraCredential: TamaraCredential(
            token: "TAMARA_TOKEN",
            merchantUrl:
                MerchantUrl(notification: "https://my-app.com/webhook"),
          ),
        ),
        orderInfo: UniPayOrder(
          transactionAmount: TransactionAmount(totalAmount: 150.55),
          orderId: DateTime.now().millisecondsSinceEpoch.toString(),
          description: "Test Order Description",
          items: [
            UniPayItem(
                id: "Product_ID", name: "Product name", quantity: 1, price: 50)
          ],
        ),
        onPaymentSucess: (res) {
          debugPrint("Payment Success ----> ${res.toMap()}");
        },
        onPaymentFailed: (res) {
          debugPrint("Payment Failed ----> ${res.toMap()}");
        },
      ),
    );
  }
}
