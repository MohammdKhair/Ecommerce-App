import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/data/datasource/static/static.dart';
import 'package:ecommerce_app/screens/onbording/controller/onboarding_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomSliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: controller.pageController,
        onPageChanged: (value) {
          controller.onPageChanged(value);
        },
        itemCount: onBoardingList.length,
        itemBuilder: (context, i) => Column(
              children: [
                Image.asset(
                  onBoardingList[i].image!,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        onBoardingList[i].title!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColor.black),
                      ),
                      const SizedBox(height: 20),
                      Text(onBoardingList[i].body!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              height: 2,
                              color: AppColor.grey,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ));
  }
}
