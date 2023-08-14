import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/res/colors/app_color.dart';


class GeneralExceptionWidget extends StatefulWidget {
  const GeneralExceptionWidget({Key? key}) : super(key: key);

  @override
  State<GeneralExceptionWidget> createState() => _GeneralExceptionWidgetState();
}

class _GeneralExceptionWidgetState extends State<GeneralExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.error, color: AppColor.error, size: MediaQuery.of(context).size.height * 0.08,),
          Text('general_exception'.tr, style: const TextStyle(fontSize: 30),textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
