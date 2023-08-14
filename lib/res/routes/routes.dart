import 'package:get/get.dart';
import 'package:invoice_generator/res/routes/routes_name.dart';
import 'package:invoice_generator/view/bills/generate_bill_screen.dart';
import 'package:invoice_generator/view/bills/past_bills_screen.dart';
import 'package:invoice_generator/view/customers/customer_data_screen.dart';
import 'package:invoice_generator/view/home/home_screen.dart';
import 'package:invoice_generator/view/scan/scan_view.dart';
import '../../view/splash_screen.dart';

class AppRoutes{

  static appRoutes()=>
    [
      GetPage(
          name: RoutesName.splashScreen,
          page: ()=> const SplashScreen(),
          transition: Transition.noTransition
      ),
      GetPage(
          name: RoutesName.homeScreen,
          page: ()=> const HomeScreen(),
          transition: Transition.fadeIn
      ),
      GetPage(
          name: RoutesName.generateBill,
          page: ()=> const GenerateBillScreen(),
      ),
      GetPage(
          name: RoutesName.scanItem,
          page: ()=> const ScanView(),
      ),
      GetPage(
        name: RoutesName.pastBillsScreen,
        page: ()=> const PastBillsScreen(),
      ),
      GetPage(
          name: RoutesName.customerDataScreen,
          page: ()=> const CustomerDataScreen(),
      ),
    ];
}