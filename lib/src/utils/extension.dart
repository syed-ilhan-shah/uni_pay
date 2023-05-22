import 'package:flutter/material.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/utils/uni_enums.dart';

extension NumExt on num {
  ///* Vat amount 15% of total amount
  num get vat => (this * 0.15).formattedValue;

  ///* Return [BorderRadius] for widget
  BorderRadius get br => BorderRadius.circular(toDouble());

  ///* Get value like `50.90999 to 50.90` or `50.00 to 50`
  num get formattedValue {
    if (this % 1 == 0) {
      return toInt();
    } else {
      return double.parse(toStringAsFixed(2));
    }
  }

  ///* Format to String
  String get formattedString => formattedValue.toString();

  //* Is success
  bool get isSuccess => this == 200;

  ///* Convert to halala
  int get amountInHalala => (this * 100).formattedValue.toInt();

  Widget get vs => SizedBox(height: rSp);
  Widget get hs => SizedBox(width: rSp);
}

extension StringExt on String {
  String get firstName {
    final name = split(" ");
    return name.first;
  }

  String get lastName {
    final name = split(" ");
    String lastName = "";
    if (name.length > 1) {
      name.removeAt(0);
      lastName = name.join(" ");
    }
    return lastName;
  }

  UniPayPaymentMethods get uniPayPaymentMethod {
    switch (this) {
      case "creditcard":
        return UniPayPaymentMethods.card;
      case "applepay":
        return UniPayPaymentMethods.applepay;
      case "stcpay":
        return UniPayPaymentMethods.stcpay;
      case "tamara":
        return UniPayPaymentMethods.tamara;
      default:
        return UniPayPaymentMethods.notSpecified;
    }
  }
}

extension BuildContextExt on BuildContext {
  ///* Go previous view
  void uniPop() => Navigator.of(this).pop();

  ///* Back to the parent view tree
  void uniParentPop() {
    if (mounted) {
      Navigator.of(this).pop();
    }
  }

  ///* Go to next view
  void uniPush(Widget widget) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => widget));

  ///* Go to next view and remove current view from tree
  void uniPushReplacement(Widget widget) => Navigator.pushReplacement(
      this, MaterialPageRoute(builder: (_) => widget));
}
