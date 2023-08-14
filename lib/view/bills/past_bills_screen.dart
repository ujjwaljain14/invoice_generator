import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/data/network/providers/bill_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../components/text_field.dart';
import '../../res/colors/app_color.dart';
import '../../view_models/invoice/invoice_viewmodel.dart';

class PastBillsScreen extends StatefulWidget {
  const PastBillsScreen({Key? key}) : super(key: key);

  static final TextEditingController searchController = TextEditingController();

  @override
  State<PastBillsScreen> createState() => _PastBillsScreenState();
}

class _PastBillsScreenState extends State<PastBillsScreen> {

  @override
  void initState() {
    PastBillsScreen.searchController.clear();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.colorFour,
          title: Text('past_bills'.tr, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColor.whiteColor)),
        ),
        backgroundColor: AppColor.colorThree,
        body: Column(
        children: [
          Padding(padding: EdgeInsets.all(height*0.006)),
          CustomTextField(
            function: (){
              BillProvider().refresh;
              setState(() {});
            },
            controller: PastBillsScreen.searchController,
            icon: const Icon(Icons.search),
            labelText: 'search'.tr,
            width: width*0.97,
            color: AppColor.colorFour.withOpacity(0.8),
            behavior: FloatingLabelBehavior.never,
          ),
          SizedBox(height: height*0.01,),
          Expanded(
            child: Consumer<BillProvider>(
              builder: (context, billProvider, child) {
                return ListView.builder(
                  itemCount: BillProvider.list.length,
                  itemBuilder: (context, index){
                      Map item = BillProvider.list[index];
                      return InkWell(
                        onTap: () async{
                          BillProvider().dataReloadForPastBills(item['key']);
                          final pdf = InvoiceViewModel.createInvoice();
                          await InvoiceViewModel.saveAndOpenPdf(pdf);
                        },
                        child: SizedBox(
                          height: height*0.15,
                          child: Card(
                            margin: EdgeInsets.all(width*0.01),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            color: AppColor.colorTwo,
                            elevation: 10,
                           shadowColor: AppColor.colorThree,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Row(
                                     children: [
                                       const Icon(Icons.person),
                                       Text(item['name']),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       const Icon(Icons.phone),
                                       Text(item["phone_number"].toString()),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       const Icon(Icons.mail),
                                       Text(item["email"]),
                                     ],
                                   ),

                                 ],
                               ),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Row(
                                     children: [
                                       const Icon(Icons.money),
                                       Text(item["billing_amt"].toString()),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       const Icon(Icons.calendar_month),
                                       Text(DateFormat('yyyy-MM-dd').format(item['time']).toString()),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       const Icon(Icons.access_time_filled_outlined),
                                       Text(DateFormat.Hms().format(item['time']).toString()),
                                     ],
                                   ),
                                 ],
                               ),
                             ],
                           )
                          ),
                        ),
                      );
                  },
                );
              }
            )
          )
        ],
    ),
    );
  }
}
