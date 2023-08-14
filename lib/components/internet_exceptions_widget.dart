import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/res/colors/app_color.dart';


class InternetExceptionWidget extends StatefulWidget {
  const InternetExceptionWidget({Key? key}) : super(key: key);

  @override
  State<InternetExceptionWidget> createState() => _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, color: AppColor.error, size: MediaQuery.of(context).size.height * 0.08,),
          Text('internet_exception'.tr, style: const TextStyle(fontSize: 30),textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
