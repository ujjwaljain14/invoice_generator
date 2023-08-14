import 'package:flutter/material.dart';
import '../res/colors/app_color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.labelText,
    this.height = 50,
    this.width = 100,
    this.color = AppColor.colorFour,
    this.prefixText='',
    this.keyboard = TextInputType.text,
    this.function,
    this.behavior = FloatingLabelBehavior.auto,
  }) : super(key: key);

  final TextEditingController controller;
  final double height, width;
  final Color color;
  final String labelText;
  final Icon icon;
  final String prefixText;
  final TextInputType keyboard;
  final VoidCallback? function;
  final FloatingLabelBehavior behavior;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        onChanged: (s){
          function!();
        },
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          fillColor: color.withOpacity(0.4),
          focusColor: Colors.green,
          filled: true,
            prefixIcon: icon,
            floatingLabelBehavior: behavior,
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            prefixText: prefixText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(width: 10, style: BorderStyle.none))

        ),
      ),
    );
  }
}
