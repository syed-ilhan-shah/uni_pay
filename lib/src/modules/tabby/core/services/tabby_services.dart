import 'package:flutter/material.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/utils.dart';
import 'package:uni_pay/uni_pay.dart'
    show
        TabbyCredential,
        TabbySnippet,
        UniPayControllers,
        UniPayCustomerInfo,
        UniPayData,
        UniPayOrder,
        UniPayPaymentMethodsItr,
        UniPayResponse,
        UniPayStatus;

class TabbyServices {
  static TabbySDK? _tabbySdk;

  /// Init Tabby SDK to prepare for payment
  static void initTabbySDK(UniPayData uniPayData) {
    if (uniPayData.credentials.paymentMethods.isTabbyGateway &&
        _tabbySdk == null) {
      final tabbyCredentials = uniPayData.credentials.tabbyCredential!;
      uniLog(tabbyCredentials.psKey);
      _tabbySdk = TabbySDK();
      _tabbySdk?.setup(
        withApiKey: tabbyCredentials.psKey,
        environment: Environment.production,
      );
    }
  }

  /// Show Tabby payment snippet
  ///
  /// Please make sure you provided the required data
  static Widget showTabbySnippet({required TabbySnippet tabbySnippet}) {
    return TabbyPresentationSnippet(
      price: tabbySnippet.totalAmountWithVat.formattedString,
      currency: tabbySnippet.currency.tabbyCurrency,
      lang: tabbySnippet.locale.tabbyLang,
      textColor: tabbySnippet.textColor,
      backgroundColor: tabbySnippet.backgroundColor,
      borderColor: tabbySnippet.borderColor,
    );
  }

  /// Please make sure you provided the required data
  static Widget showTabbyCheckoutSnippet({required TabbySnippet tabbySnippet}) {
    return TabbyCheckoutSnippet(
      price: tabbySnippet.totalAmountWithVat.formattedString,
      currency: tabbySnippet.currency.tabbyCurrency,
      lang: tabbySnippet.locale.tabbyLang,
    );
  }

  /// Create Tabby session to proceed with payment
  static Future<TabbySession?> createTabbySession(UniPayData uniPayData) async {
    UniPayOrder order = uniPayData.orderInfo;
    UniPayCustomerInfo customer = uniPayData.customerInfo;
    TabbyCredential tabbyCredential = uniPayData.credentials.tabbyCredential!;

    try {
      TabbySession session =
          await _tabbySdk!.createSession(TabbyCheckoutPayload(
        merchantCode: tabbyCredential.merchantCode,
        lang: uniPayData.locale.tabbyLang,
        payment: Payment(
          amount: order.transactionAmount.totalAmount.toString(),
          currency: order.transactionAmount.currency.tabbyCurrency,
          buyer: Buyer(
            //  'card.success@tabby.ai',
            // 'otp.rejected@tabby.ai',
            email: customer.email,
            phone: customer.phoneNumber,
            name: customer.fullName,
          ),
          buyerHistory: BuyerHistory(
            loyaltyLevel: 0,
            registeredSince: customer.joinedAtDate.toUtc().toIso8601String(),
            wishlistCount: 0,
          ),
          order: Order(
            referenceId: order.orderId,
            items: order.items
                .map(
                  (item) => OrderItem(
                    title: item.name,
                    description: item.itemType.name,
                    quantity: item.quantity,
                    unitPrice: item.totalPrice.formattedString,
                    referenceId: item.sku,
                    category: item.itemType.name,
                  ),
                )
                .toList(),
          ),
          orderHistory: [
            // OrderHistoryItem(
            //   purchasedAt: DateTime.now().toUtc().toIso8601String(),
            //   amount: order.transactionAmount.totalAmount.formattedString,
            //   paymentMethod: OrderHistoryItemPaymentMethod.card,
            //   status: OrderHistoryItemStatus.newOne,
            // )
          ],
          shippingAddress: ShippingAddress(
            city: customer.address.city,
            address: customer.address.addressName,
            zip: customer.address.zipCode,
          ),
        ),
      ));
      uniLog(
          "Tabby Session ---> ${session.sessionId} ${session.paymentId} ${session.availableProducts.installments?.type}");
      return session;
    } on ServerException catch (e) {
      uniLog("Tabby ServerException: $e");
      return null;
    }
  }

  /// Process the Tabby payment
  static Future processTabbyPayment(BuildContext context, UniPayStatus status,
      {String? transactionId}) {
    UniPayResponse response = UniPayResponse(status: status);

    /// If payment is successful, then return the transaction ID
    if (status.isSuccess) {
      response.transactionId = transactionId ??
          "TABBY_TRXN_${UniPayControllers.uniPayData.orderInfo.orderId}}";
    }
    return UniPayControllers.handlePaymentsResponseAndCallback(context,
        response: response);
  }
}
