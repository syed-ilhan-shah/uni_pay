import 'package:flutter/material.dart';

import '../../../uni_pay.dart';

class WidgetData {
  final bool currentStatus;
  final ValueChanged<bool> onChange;
  final UniPayLocale locale;
  final Color? activeColor;
  final num? totalAmount;
  final UniPayCurrency currency;

  WidgetData({
    required this.currentStatus,
    required this.onChange,
    required this.locale,
    this.activeColor,
    this.totalAmount,
    this.currency = UniPayCurrency.sar,
  });
}
