# Payment Gateway Library by **UNICODE Team**

A library for making online payment by using Moyasar and Tamara payment gateway

# **Features support**

- **Card support (mada, visa, mastercard) - [Docs](https://moyasar.com/docs/api/#api-keys)**
- **Apple Pay - [Integration](https://help.moyasar.com/en/article/moyasar-dashboard-apple-pay-certificate-activation-9l6sd5/) and [Xcode setup](https://help.apple.com/xcode/mac/9.3/#/deva43983eb7?sub=dev44ce8ef13)**
- **Tamara - [Docs](https://docs.tamara.co/introduction/)**

![Payment Screenshot](https://raw.githubusercontent.com/UNICODE-Venture/uni_pay/main/assets/screenshots/screenshot.png)

## Getting started

Please have a look at our [/example](https://pub.dev/packages/uni_pay/example) project for a better understanding of implementations.

```dart
   UniPay(
      uniPayData: UniPayData(
        appName: "UniPay",
        locale: UniPayLocale.ar,
        customerInfo: UniPayCustomerInfo(
          fullName: "Mohammad Saif",
          email: "example@mail.com",
          phoneNumber: "+966555666777",
          address: UniPayAddress(addressName: "Test Address", city: "Riyadh"),
        ),
        environment: UniPayEnvironment.development,
        credentials: UniPayCredentials(
          paymentMethods: [
            UniPayPaymentMethods.card,
            UniPayPaymentMethods.applepay,
            UniPayPaymentMethods.tamara,
          ],
          moyasarCredential:
              MoyasarCredential(publishableKey: "pk_key", secretKey: "sk_key"),
          tamaraCredential: TamaraCredential(
            token: "Tamara_Token",
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
    )
```
