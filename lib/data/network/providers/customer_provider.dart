import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:invoice_generator/models/bill_model.dart';
import 'package:invoice_generator/view/customers/customer_data_screen.dart';

class CustomerProvider extends ChangeNotifier{
  final customerBox = Hive.box('customerData_box');
  static List<Map<String, dynamic>> list = [];

  CustomerProvider(){
    refresh();
  }

  void refresh() {
    final data = customerBox.keys.map((key) {
      final item = customerBox.get(key);
      return {'key':key, 'CustomerDetails':item,};
    }).toList();
    list = data.where((element){
      return (
          element['CustomerDetails']['name'].toLowerCase().contains(CustomerDataScreen.searchController.text.toLowerCase())
          ||
          element['CustomerDetails']['phone_number'].toLowerCase().contains(CustomerDataScreen.searchController.text.toLowerCase())
          ||
          element['CustomerDetails']['email'].toLowerCase().contains(CustomerDataScreen.searchController.text.toLowerCase())
      );
    }).toList();
    notifyListeners();
  }

  void addCustomer()async{
    if(checkExistingUser()){
      var data = {
        "name" : BillModel.name.text.trim(),
        "phone_number" : BillModel.phoneNumber.text.trim(),
        "email" : BillModel.email.text.trim(),
        "visitedTimes" : 1,
        "money_spent": BillModel.finalAmount,
      };
      await customerBox.add(data);
    }
    refresh();
  }

  bool checkExistingUser(){
    bool flag = true;
    customerBox.keys.map((key){
      if(customerBox.get(key)["phone_number"] == BillModel.phoneNumber.text){
        // Increasing Number of times Visited by one
        customerBox.get(key)['visitedTimes'] = customerBox.get(key)['visitedTimes'] + 1;
        // Updating Name
        customerBox.get(key)['name'] = BillModel.name.text.trim();
        customerBox.get(key)['money_spent'] += BillModel.finalAmount;
        //  Updating Email
        if(BillModel.email.text.trim().isNotEmpty){
          customerBox.get(key)['email'] = BillModel.email.text.trim();
        }
        customerBox.put(key, customerBox.get(key));
        flag = false;
      }
    }).toList();
    return flag;
  }
}