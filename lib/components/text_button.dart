import 'package:flutter/material.dart';

import '../res/colors/app_color.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    this.buttonColor = AppColor.colorFour,
    this.textColor = AppColor.whiteColor,
    this.loading = false,
    this.width = 60,
    this.height = 50,
    required this.onPress,
    required this.title,
  }) : super(key: key);

  final bool loading;
  final String title;
  final double height, width;
  final VoidCallback onPress;
  final Color textColor, buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: loading ?
          const Center(child: CircularProgressIndicator()) :
          Center(child: Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor),))
      ),
    );
  }
}
