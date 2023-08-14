
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:invoice_generator/models/bill_model.dart';
import 'package:invoice_generator/view/bills/past_bills_screen.dart';

class BillProvider extends ChangeNotifier{

  BillProvider(){
    refresh();
  }

  final billBox = Hive.box('billData_box');
  static List<Map<String, dynamic>> list = [];

  void dataReloadForPastBills(key){
    final item = billBox.get(key);
    BillModel.fromJson(item);
  }

  void refresh() {
    final data = billBox.keys.map((key) {
      final item = billBox.get(key);
      return {
        'key':key,
        "name" : item["name"],
        "phone_number" : item["phone_number"],
        "email" : item["email"],
        "books" : item["list"],
        "billing_amt" : item["final_amt"],
        "time" : item["bill_time"] as DateTime,
      };
    }).toList();
    list = data.where((element){
          return (
              element['name'].toLowerCase().contains(PastBillsScreen.searchController.text.toLowerCase())
              ||
              element['phone_number'].toLowerCase().contains(PastBillsScreen.searchController.text.toLowerCase())
              ||
              element['email'].toLowerCase().contains(PastBillsScreen.searchController.text.toLowerCase())
          );
        }).toList();
    notifyListeners();
  }

  void addBill()async{
    var data = BillModel().toJson();
    await billBox.add(data);
    refresh();
  }

}