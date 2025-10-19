import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/screens/onbording/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtonOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomButtonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      child: MaterialButton(
        onPressed: () {
          controller.next();
        },
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 100),
        textColor: Colors.white,
        color: AppColor.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: Text("2".tr, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
