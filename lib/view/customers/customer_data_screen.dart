import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/components/text_field.dart';
import 'package:invoice_generator/data/network/providers/customer_provider.dart';
import 'package:invoice_generator/res/colors/app_color.dart';
import 'package:provider/provider.dart';

class CustomerDataScreen extends StatefulWidget {
  const CustomerDataScreen({Key? key}) : super(key: key);

  static final TextEditingController searchController = TextEditingController();

  @override
  State<CustomerDataScreen> createState() => _CustomerDataScreenState();
}

class _CustomerDataScreenState extends State<CustomerDataScreen> {

  @override
  void initState() {
    CustomerDataScreen.searchController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.colorFour,
        title: Text('customers'.tr, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColor.whiteColor)),
      ),
      backgroundColor: AppColor.colorThree,
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(height*0.006)),
          CustomTextField(
            function: (){
              CustomerProvider().refresh;
              setState(() {});
            },
            controller: CustomerDataScreen.searchController,
            icon: const Icon(Icons.search),
            labelText: 'search'.tr,
            width: width*0.97,
            color: AppColor.colorFour.withOpacity(0.8),
            behavior: FloatingLabelBehavior.never,
          ),
          Consumer<CustomerProvider>(
            builder: (context, value, child)=>Expanded(
                  child: GridView.builder(
                    itemCount: CustomerProvider.list.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      var data = CustomerProvider.list[index]['CustomerDetails'];
                        return InkWell(
                          onTap: (){},
                          child: Container(
                            margin: EdgeInsets.all(width*0.021),
                            width: width*0.4,
                            height: height*0.3,
                            padding: EdgeInsets.all(width*0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.colorTwo,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.person),
                                    Flexible(
                                      child: Text(
                                        data['name'],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.phone),
                                    Flexible(
                                      child: Text(
                                        data['phone_number'],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.mail),
                                    Flexible(
                                      child: Text(
                                        data["email"],
                                        overflow: TextOverflow.ellipsis,

                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.shopping_bag),
                                    Flexible(
                                      child: Text(
                                        data["visitedTimes"].toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.money),
                                    Flexible(
                                      child: Text(
                                        data[ "money_spent"].toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                    },
                  )
              ),
          )
        ],
      ),
    );
  }
}
