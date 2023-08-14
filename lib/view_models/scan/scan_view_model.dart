import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:invoice_generator/data/app_exceptions.dart';
import 'package:invoice_generator/data/network/network_api_services.dart';
import 'package:invoice_generator/models/bill_model.dart';
import 'package:invoice_generator/utils/utils.dart';

class ScanViewModel{

  static Future<void> scanBarcode()async{
    String barcodeScanned = await FlutterBarcodeScanner.scanBarcode(
      '#008000',
      'cancel',
      true,
      ScanMode.BARCODE,
    );
    if(barcodeScanned != '-1'){
      BillModel.billingTime = DateTime.now();
      if(BillModel.list.containsKey(barcodeScanned)){
        BillModel.list[barcodeScanned]!.qty++;
        //total bill amount
        updateFinalAmount(BillModel.list[barcodeScanned]!.price);
      }else{
        var apiCall = NetworkApiServices();
        try{
          var data = await apiCall.getApi('https://www.googleapis.com/books/v1/volumes?q=$barcodeScanned&key=AIzaSyAn-78CrnJNuB-rPUPqUfJQrZCeXVa3TtE');
          String name = data['items'][0]['volumeInfo']['title'];
          BillModel.list[barcodeScanned] = Books(name: name,);
          double price = BillModel.list[barcodeScanned]!.price;
          try{
            price = data['items'][0]['saleInfo']['retailPrice']['amount'];
            // rounding off to 2 decimal places
            double.parse(price.toStringAsFixed(2));
          }on NoSuchMethodError{
            throw 'Price not found in api call';
          }finally{
            BillModel.list[barcodeScanned]!.price = price;
            BillModel.list[barcodeScanned]!.totalPrice = price;
            //total bill amount
            updateFinalAmount(price);
          }
        }on InternetException{
          Utils.snackBar('No Internet Connection', "Retry after connecting to internet");
        }on InvalidBarcodeException{
          Utils.snackBar("Couldn't fetch data", "Invalid Barcode or an error occurred while loading data");
        }on RequestTimeOut{
          Utils.snackBar("Request TimeOut", "Couldn't fetch data");
        }on NoSuchMethodError{
          Utils.snackBar("Couldn't fetch data", "Invalid Barcode or an error occurred while loading data");
        }catch(e){
          // no error as we generate random price if price not available in api call
          if (e.toString() != 'Price not found in api call'){
            Utils.snackBar("Couldn't fetch data", e.toString());
          }
    }
      }

      BillModel.list[barcodeScanned]!.totalPrice = BillModel.list[barcodeScanned]!.price * BillModel.list[barcodeScanned]!.qty;
    }
  }

  static void updateFinalAmount(double price){
    BillModel.finalAmount += price;
  }
  static void removeItem(String isbnCode){
     double price = BillModel.list[isbnCode]!.price;
     BillModel.list[isbnCode]!.totalPrice -= price;
     BillModel.finalAmount -= price;
     int qty = BillModel.list[isbnCode]!.qty;
     if(qty <= 1){
       BillModel.list.remove(isbnCode);
     }else{
       BillModel.list[isbnCode]!.qty--;
     }
  }
}


// AIzaSyAn-78CrnJNuB-rPUPqUfJQrZCeXVa3TtE