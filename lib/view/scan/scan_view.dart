import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/components/text_button.dart';
import 'package:invoice_generator/view_models/scan/scan_view_model.dart';

import '../../models/bill_model.dart';
import '../../res/colors/app_color.dart';

class ScanView extends StatefulWidget {
  const ScanView({Key? key}) : super(key: key);

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {

  @override
  void initState(){
      ScanViewModel.scanBarcode().whenComplete((){
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final isbnList = BillModel.list.keys.toList(growable: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.colorFour,
        title: Text('scan'.tr, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColor.whiteColor)),
      ),
      backgroundColor: AppColor.colorThree,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: height*0.65,
              width: width*0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border:Border.all(color: AppColor.colorThree),
                  color: AppColor.colorTwo.withOpacity(0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: isbnList.isEmpty
                        ?
                    Center(
                      child: Text('no_scanned'.tr),
                    )
                        :
                    ListView.builder(
                      itemBuilder: ((context, index){
                        return ListTile(
                          leading: IconButton(
                              onPressed: () {
                                ScanViewModel.removeItem(isbnList[index]);
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline_sharp,
                                color: AppColor.error,
                              )
                          ),
                          title: Text(BillModel.list[isbnList[index]]!.name),
                          trailing: Text(BillModel.list[isbnList[index]]!.qty.toString()),
                          );
                      }),
                      itemCount: isbnList.length,
                    ),
                  ),
                  SizedBox(height: height*0.02,),
                  Padding(
                    padding: EdgeInsets.all(width*0.05),
                    child: CustomTextButton(
                      onPress: (){
                        ScanViewModel.scanBarcode().whenComplete((){
                          setState(() {});
                        });
                      },
                      title: 'add'.tr,
                      height: height*0.05,
                      width: width *0.3,
                      buttonColor: AppColor.colorFour.withOpacity(0.6),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: height*0.02,),
          CustomTextButton(
            onPress: (){
              Get.back();
            },
            title: 'done'.tr,
            height: height*0.1,
            width: width *0.5,
          )
        ],
      ),
    );
  }
}
