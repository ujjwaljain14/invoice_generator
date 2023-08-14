import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/components/card_item.dart';
import 'package:invoice_generator/res/localization/locale_type.dart';
import 'package:invoice_generator/res/routes/routes_name.dart';
import 'package:provider/provider.dart';
import '../../data/network/providers/language_provider.dart';
import '../../res/colors/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    bool language = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.colorFour,
        title: Text('home'.tr, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColor.whiteColor)),
      ),
      drawer: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          var list = languageProvider.list;
          language = list[0]['language'];
          return Drawer(
            backgroundColor: AppColor.colorThree,
            child: ListView(
              children: [
                  DrawerHeader(
                   decoration: const BoxDecoration(
                     color: AppColor.colorFour,
                   ),
                   child: Center(child: Text('settings'.tr, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColor.whiteColor),)),
                  ),
                ListTile(
                  title: Text('language'.tr, style: Theme.of(context).textTheme.titleLarge,),
                  trailing: Switch(
                    value: language ,
                    splashRadius: 0,
                    activeColor: AppColor.colorFour,
                    onChanged: (bool value) {
                      languageProvider.toggleLanguage(list[0]['key'], value);
                      Get.locale ==  LocaleType.localeOne ? Get.updateLocale(LocaleType.localeTwo) : Get.updateLocale(LocaleType.localeOne);
                    },
                  ),
                ),
              ],
            ),
          );
        }
      ),
      backgroundColor: AppColor.colorThree,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardItem(
                  icon: Icons.person,
                  title: 'customers'.tr,
                  onPress: (){
                    Get.toNamed(RoutesName.customerDataScreen);
                  },
                  height: height*0.3,
                  width: width*0.4,
                ),
                CardItem(
                    icon: Icons.newspaper_outlined,
                    title: 'past_bills'.tr,
                    onPress: (){
                      Get.toNamed(RoutesName.pastBillsScreen);
                    },
                    height: height*0.3,
                    width: width*0.4
                )
              ],
            ),
            CardItem(
              icon: Icons.inventory_outlined,
              title: 'gen_bill'.tr,
              onPress: (){
                Get.toNamed(RoutesName.generateBill);
              },
              height: height*0.2,
              width: width*0.85,
              inRow: true,
            ),
          ],
        ),
      ),
    );
  }
}
