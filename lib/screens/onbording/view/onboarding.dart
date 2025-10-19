import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/screens/onbording/controller/onboarding_controller.dart';
import 'package:ecommerce_app/screens/onbording/widgets/custom_button.dart';
import 'package:ecommerce_app/screens/onbording/widgets/custom_slidre.dart';
import 'package:ecommerce_app/screens/onbording/widgets/dot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OnBoardingControllerImp());
    return const Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: SafeArea(
            child: Column(
          children: [
            Expanded(
              flex: 4,
              child: CustomSliderOnBoarding(),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Spacer(flex: 1),
                    CustomDotControllerOnBoarding(),
                    Spacer(flex: 2),
                    CustomButtonOnBoarding()
                  ],
                )),
          ],
        )),
      ),
    );
  }
}
