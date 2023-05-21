import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uni_pay/src/core/keys/api_keys.dart';
import 'package:uni_pay/src/core/models/uni_pay_res.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/uni_enums.dart';
import 'package:uni_pay/src/utils/utils.dart';

import '../../../../core/models/uni_pay_data.dart';
import '../../../../providers/uni_pay_provider.dart';
import '../models/t_checkout.dart';
import '../models/tamara_data.dart';
import 'package:http/http.dart' as http_client;

class UniTamara {
  UniTamara._();

  ///* Generate checkout urls for tamara
  static Future<TamaraCheckoutData?> generateTamaraCheckoutUrls(
      UniPayData uniPayData) async {
    final order = uniPayData.orderInfo;
    final customer = uniPayData.customerInfo;
    TamaraData tamaraData = TamaraData(
      orderReferenceId: order.orderId,
      totalAmount: TotalAmount(
        amount: order.transactionAmount.totalAmount,
        currency: order.transactionAmount.currency.currencyCode,
      ),
      description: order.description,
      countryCode: uniPayData.customerInfo.address.country.countryCode,
      locale: uniPayData.locale.localeCode,
      items: order.items
          .map((item) => Items(
                referenceId: item.id,
                type: item.itemType.name,
                name: item.name,
                sku: item.sku,
                quantity: item.quantity,
                totalAmount: TotalAmount(
                  amount: item.totalPrice,
                  currency: order.transactionAmount.currency.currencyCode,
                ),
              ))
          .toList(),
      consumer: ConsumerModel(
        firstName: customer.fullName.firstName,
        lastName: customer.fullName.lastName,
        phoneNumber: customer.phoneNumber,
        email: customer.email,
      ),
      shippingAddress: ShippingAddress(
        firstName: customer.fullName.firstName,
        lastName: customer.fullName.lastName,
        line1: customer.address.addressName,
        city: customer.address.city,
        countryCode: customer.address.country.countryCode,
      ),
      taxAmount: TaxAmount(
        amount: order.transactionAmount.totalAmount.vat.formattedString,
        currency: order.transactionAmount.currency.currencyCode,
      ),
      shippingAmount: ShippingAmount(
        amount: order.transactionAmount.totalAmount.formattedString,
        currency: order.transactionAmount.currency.currencyCode,
      ),
      merchantUrl: uniPayData.credentials.tamaraCredential!.merchantUrl,
    );

    TamaraCheckoutData? checkout = await UniTamara.tamaraCheckout(tamaraData);
    return checkout;
  }

  ///* Call tamara checkout
  static Future<TamaraCheckoutData?> tamaraCheckout(
      TamaraData tamaraData) async {
    try {
      String data = jsonEncode(tamaraData.toJson());
      // uniPrint(data);
      http_client.Response response = await http_client.post(
        Uri.parse(ApiKeys.tamaraCheckoutUrl),
        headers: ApiKeys.tamaraHeaders,
        body: data,
      );
      // uniLog(
      //     "${ApiKeys.tamaraCheckoutUrl} - ${ApiKeys.tamaraHeaders}---> ${response.body}");

      if (response.statusCode.isSuccess) {
        TamaraCheckoutData checkout =
            TamaraCheckoutData.fromJson(json.decode(response.body));
        if (checkout.checkoutUrl.isNotEmpty) return checkout;
      }
    } on HttpException catch (e) {
      uniPrint(e.message);
    }

    return null;
  }

  ///* Process the Tamara payment
  static void processTamaraPayment(BuildContext context, UniPayStatus status,
      {String? transactionId}) {
    UniPayResponse response = UniPayResponse(status: status);
    //* Success
    if (status.isSuccess) {
      response.transactionId = transactionId ??
          "TAMARA_TRXN_${uniPayProivder.uniPayData.orderInfo.orderId}}";
    }
    uniPayProivder.handlePaymentsResponseAndCallback(context,
        response: response);
    // //* Cancelled
    // else if (status.isCancelled) {
    //   uniPayProivder.uniPayData.onPaymentFailed.call(response);
    // }
    // //* Failed
    // else {
    //   uniPayProivder.uniPayData.onPaymentFailed.call(response);
    // }
  }

  ///* Verify payment
  static String getTamaraCDN({
    required num price,
    required UniPayLocale locale,
  }) {
    return "https://cdn.tamara.co/widget/tamara-introduction.html?lang=${locale.name}&price=$price&currency=SAR&countryCode=SA&colorType=default&showBorder=true&paymentType=installment&numberOfInstallments=3&disableInstallment=false&disablePaylater=true&widgetType=product-widget";
  }
}
