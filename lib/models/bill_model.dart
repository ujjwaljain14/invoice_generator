
import 'dart:math';

import 'package:flutter/cupertino.dart';

class BillModel{
  BillModel();

  static TextEditingController name= TextEditingController();
  static TextEditingController phoneNumber= TextEditingController();
  static TextEditingController email= TextEditingController();
  static Map<String, Books> list = {};
  static double finalAmount = 0;
  static DateTime billingTime = DateTime(2023);

  Map toJson(){
    Map temp = {};
    var c= list.keys.map((key){
      temp[key]=list[key]!.toJson();
      return list[key]!.toJson();
    });

    debugPrint('console value printing $c');
    return {
      'name' : name.text,
      'phone_number' : phoneNumber.text,
      'email' : email.text,
      'final_amt' : finalAmount,
      'bill_time' : billingTime,
      'list' : temp,
    };
  }

  factory BillModel.fromJson(Map json) {

    // Making map {ISBN : BOOK}
    Map<String, Books> temp = {};
    var c= json['list'].keys.map((key){
      temp[key]=Books.fromJson(json['list'][key]);
      return json['list'][key];
    });

    debugPrint('console value printing $c');

    name.text = json['name'];
    phoneNumber.text = json['phone_number'];
    email.text = json['email'];
    finalAmount = json['final_amt'];
    billingTime = json['bill_time'];
    list = temp;
    return BillModel();
    // return BillModel(name: json['name'], qty: json['qty'], price:json['price'], totalPrice: json['totalPrice']);
  }

}

class Books{

  Books({this.name = "",this.qty = 1, price, this.totalPrice=0}):price= (Random().nextInt(400) + 199.99);

  String name;
  int qty;
  // double price = Random().nextInt(400) + 199.99;
  double price;
  double totalPrice = 0;

  Map toJson(){
    return {
      'name' : name,
      'qty' : qty,
      'price' : price,
      'totalPrice' : totalPrice,
    };

  }

  factory Books.fromJson(Map json) {
    return Books(name: json['name'], qty: json['qty'], price:json['price'], totalPrice: json['totalPrice']);
  }
}