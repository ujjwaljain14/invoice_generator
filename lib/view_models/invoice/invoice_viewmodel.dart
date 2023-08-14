import 'dart:io';
import 'package:invoice_generator/models/bill_model.dart';
import 'package:invoice_generator/utils/utils.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class InvoiceViewModel{


  static Future saveAndOpenPdf(pw.Document pdf) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/bill.pdf");
    file.writeAsBytesSync(await pdf.save());
    String fullPath = "$documentPath/bill.pdf";
    openPdf(fullPath);
    return fullPath;
  }

  static openPdf(String path){
    OpenFilex.open(path);
  }

  static createInvoice() {
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: const pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: <pw.Widget>[
                    pw.Text("Developer's Book Store", textScaleFactor: 2),
                  ]
              )
          ),
          pw.Header(
              level: 1,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Customer Name : '),
                      pw.Text(BillModel.name.text),
                    ]
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Phone Number : '),
                        pw.Text('+91 ${BillModel.phoneNumber.text}'),
                      ]
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Email Id : '),
                        pw.Text(BillModel.email.text),
                      ]
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Bill Time : '),
                        pw.Text(BillModel.billingTime.toString()
                        ),
                      ]
                  ),
                ]
              ),
          ),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Table(
              border: const pw.TableBorder(),
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColor.fromHex('#D3D3D3'),),
                  repeat: true,
                  verticalAlignment: pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Book'),
                        ]
                    ),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('Price'),
                        ]
                    ),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('Qty'),
                        ]
                    ),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('Total'),
                        ]
                    ),
                  ],
                ),
                for(var key in BillModel.list.keys)
                  pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(8),
                              alignment: pw.Alignment.topLeft,
                              height: 30,
                              width: 150,
                              child: pw.Text(BillModel.list[key]!.name),
                            ),
                            pw.Divider(thickness: 0.5)
                          ]
                      ),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Container(
                              alignment: pw.Alignment.center,
                              height: 30,
                              // width: 70,
                              child: pw.Text(BillModel.list[key]!.price.toString(),),
                            ),
                            pw.Divider(thickness: 0.5)
                          ]
                      ),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Container(
                              height: 30,
                              alignment: pw.Alignment.center,
                              // width: 70,
                              child: pw.Text(BillModel.list[key]!.qty.toString(),),
                            ),
                            pw.Divider(thickness: 0.5)
                          ]
                      ),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Container(
                              alignment: pw.Alignment.center,
                              height: 30,
                              // width: 70,
                              child: pw.Text(BillModel.list[key]!.totalPrice.toString(),),
                            ),
                            pw.Divider(thickness: 0.5)
                          ]
                      ),
                    ],
                  ),
          ]),
          pw.Divider(thickness: 1,),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text('Total Bill Amount: ${BillModel.finalAmount.toString()}'),
            ]
          )
        ];
      },
    ));
    return pdf;
  }

  static bool checkIfDataProvided() {

    if(BillModel.name.text.trim().isEmpty){
      Utils.snackBar("Customer Name is Mandatory", "Customer field can't be empty");
      return false;
    }else if(BillModel.phoneNumber.text.trim().isEmpty){
      Utils.snackBar("Phone Number is Mandatory", "Contact Details can't be empty");
      return false;
    }else if(BillModel.phoneNumber.text.length != 10){
      Utils.snackBar("Invalid Phone Number", "Number must have 10 digits");
      return false;
    }else if(BillModel.list.isEmpty){
      Utils.snackBar("No Books Scanned", "Scan books to be billed first");
      return false;
    }
    return true;
  }


}