### Payment Gateway Library Crafted by the **[UNICODE Team](https://www.unicodesolutions.co/)** for Seamless Transactions

A comprehensive library for seamless online payments, integrating Moyasar (Card & Apple pay), Tamara, and Tabby payment gateways. Effortlessly handle transactions, enhance user experience, and streamline your payment processing with our robust and versatile solution.

# **Features support**

- **Card support (mada, visa, mastercard, amex) - [Docs](https://moyasar.com/docs/api/#api-keys)**
- **Apple Pay - [Integration](https://help.moyasar.com/en/article/moyasar-dashboard-apple-pay-certificate-activation-9l6sd5/) and [Xcode setup](https://help.apple.com/xcode/mac/9.3/#/deva43983eb7?sub=dev44ce8ef13)**
- **Tamara - [Docs](https://docs.tamara.co/introduction/)**
- **Tabby - [Docs](https://api-docs.tabby.ai/)**

<img src="https://raw.githubusercontent.com/UNICODE-Venture/uni_pay/main/assets/screenshots/sc_ar.png" width=200, height=400 alt="UniPay Arabic by Saif"> 
<img src="https://raw.githubusercontent.com/UNICODE-Venture/uni_pay/main/assets/screenshots/sc_en.png" width=200, height=400 alt="UniPay English by Saif">

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
          address: UniPayAddress(
            addressName: "Olaya street, Al Ghadir",
            city: "Riyadh",
          ),
        ),
        environment: UniPayEnvironment.development,
        credentials: UniPayCredentials(
          applePayMerchantIdentifier: "merchant.com.mystore.sa",
          paymentMethods: [
            UniPayPaymentMethods.card,
            UniPayPaymentMethods.applepay,
            UniPayPaymentMethods.tamara,
            UniPayPaymentMethods.tabby,

          ],
          moyasarCredential:
              MoyasarCredential(publishableKey: "pk_key", secretKey: "sk_key"),
          tamaraCredential: TamaraCredential(
            token: "Tamara_Token",
            merchantUrl:
                MerchantUrl(notification: "https://my-app.com/webhook"),
          ),
          tabbyCredential: TabbyCredential(psKey: "tabby_api_key"),
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
