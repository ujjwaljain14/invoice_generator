import 'package:flutter/material.dart';
import 'package:invoice_generator/res/colors/app_color.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    this.height = 100,
    this.width = 150,
    this.inRow = false,
    required this.icon,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final double height, width;
  final IconData icon;
  final String title;
  final VoidCallback onPress;
  final bool inRow;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.colorOne,
      elevation: 40,
      shadowColor: AppColor.colorTwo,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onPress,
        child: SizedBox(
          height: height,
          width: width,
          child: inRow
              ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: height*0.3),
              Text(title),
            ],
          )
              :
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: height*0.2),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
