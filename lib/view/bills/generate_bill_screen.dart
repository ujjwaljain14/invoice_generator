import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/components/text_button.dart';
import 'package:invoice_generator/data/network/providers/bill_provider.dart';
import 'package:invoice_generator/data/network/providers/customer_provider.dart';
import 'package:invoice_generator/res/routes/routes_name.dart';
import 'package:invoice_generator/view_models/invoice/invoice_viewmodel.dart';

import '../../components/text_field.dart';
import '../../models/bill_model.dart';
import '../../res/colors/app_color.dart';

class GenerateBillScreen extends StatefulWidget {
  const GenerateBillScreen({Key? key}) : super(key: key);

  @override
  State<GenerateBillScreen> createState() => _GenerateBillScreenState();
}

class _GenerateBillScreenState extends State<GenerateBillScreen> {

  @override
  void initState() {
    // clearing the bill model data
    BillModel.name.clear();
    BillModel.phoneNumber.clear();
    BillModel.email.clear();
    BillModel.list.clear();
    BillModel.finalAmount = 0;
    super.initState();
  }

  // final newBill = BillModel();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.colorFour,
        title: Text('gen_bill'.tr, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColor.whiteColor)),
      ),
      backgroundColor: AppColor.colorThree,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height*0.1, horizontal: width * 0.1),
            child: Column(
              children: [
                Center(
                  child: CustomTextField(
                    controller: BillModel.name,
                    icon: const Icon(Icons.person),
                    labelText: 'name'.tr,
                    width: width*0.8,
                    height: height * 0.1,
                    keyboard: TextInputType.name,
                  ),
                ),
                SizedBox(height: height*0.02,),
                Center(
                  child: CustomTextField(
                    controller: BillModel.phoneNumber,
                    icon: const Icon(Icons.phone),
                    labelText: 'p_num'.tr,
                    prefixText: '+91',
                    width: width*0.8,
                    height: height * 0.1,
                    keyboard: TextInputType.phone,
                  ),
                ),
                SizedBox(height: height*0.02,),
                Center(
                  child: CustomTextField(
                    controller: BillModel.email,
                    icon: const Icon(Icons.mail),
                    labelText: 'email'.tr,
                    width: width*0.8,
                    height: height * 0.1,
                    keyboard: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: height*0.04,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextButton(
                      onPress: ()async{
                        bool condition = InvoiceViewModel.checkIfDataProvided();
                        if(condition){
                          final pdf = InvoiceViewModel.createInvoice();
                          await InvoiceViewModel.saveAndOpenPdf(pdf).whenComplete((){
                            BillProvider().addBill();
                            CustomerProvider().addCustomer();
                            Get.toNamed(RoutesName.homeScreen);
                          });
                        }
                      },
                      title: 'gen_bill'.tr,
                      width: width*0.5,
                      height: height * 0.1,
                    ),
                    Container(
                      height: width*0.2,
                      width: width*0.2,
                      decoration: BoxDecoration(color: AppColor.colorTwo, borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                          onPressed: (){
                            Get.toNamed(RoutesName.scanItem);
                          },
                          icon: Icon(Icons.qr_code_2,size: width*0.15,),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
