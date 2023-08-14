import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_generator/res/colors/app_color.dart';
import 'package:invoice_generator/res/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorFour,
      body: Center(
        child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText('welcome'.tr, speed: const Duration(milliseconds: 100),textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColor.whiteColor)),
            ],
          isRepeatingAnimation: false,
          onFinished: () {
            Get.offAndToNamed(RoutesName.homeScreen);
          },
        )

      ),
    );
  }
}
