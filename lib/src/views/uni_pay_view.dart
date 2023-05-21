import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/utils/uni_enums.dart';
import 'package:uni_pay/src/views/uni_pay_view_handler.dart';

import '../constant/locale.dart';
import '../core/models/uni_pay_data.dart';
import 'package:provider/provider.dart';

import '../providers/uni_pay_provider.dart';
import '../theme/colors.dart';

final uniStateKey = GlobalKey<NavigatorState>();

class UniPay extends StatefulWidget {
  ///* Uni Pay Data to be used for payment request
  final UniPayData uniPayData;

  const UniPay({Key? key, required this.uniPayData}) : super(key: key);

  @override
  State<UniPay> createState() => _UniPayState();
}

class _UniPayState extends State<UniPay> {
  @override
  Widget build(BuildContext context) {
    final uniPayData = widget.uniPayData;
    UniPayText.isEnglish = uniPayData.locale.isEnglish;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UniPayProivder()..setUniPayData(uniPayData)),
      ],
      child: MaterialApp(
        navigatorKey: uniStateKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: LocalizationsData.localizationsDelegate,
        supportedLocales: LocalizationsData.supportLocale,
        theme: UniPayTheme.theme,
        locale: UniPayText.isEnglish
            ? LocalizationsData.supportLocale.last
            : LocalizationsData.supportLocale.first,
        home: const UniPayViewHandler(),
      ),
    );
  }
}
