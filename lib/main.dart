import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:invoice_generator/data/network/providers/bill_provider.dart';
import 'package:invoice_generator/res/colors/app_color.dart';
import 'package:invoice_generator/res/localization/languages.dart';
import 'package:invoice_generator/res/localization/locale_type.dart';
import 'package:invoice_generator/res/routes/routes.dart';
import 'package:invoice_generator/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'data/network/providers/customer_provider.dart';
import 'data/network/providers/language_provider.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('language_box');
  await Hive.openBox('billData_box');
  await Hive.openBox('customerData_box');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider(),),
        ChangeNotifierProvider(create: (context) => BillProvider(),),
        ChangeNotifierProvider(create: (context) => CustomerProvider(),),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, themeProvider, child) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            translations: Languages(),
            locale: themeProvider.list[0]['language'] ? LocaleType.localeTwo :LocaleType.localeOne,
            fallbackLocale: LocaleType.localeOne,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: AppColor.colorFour,
                secondary: AppColor.colorOne,
              ),
            ),
              // importing the list of routes
            getPages: AppRoutes.appRoutes(),
            home: const SplashScreen(),
          );
        }
      ),
    );
  }
}