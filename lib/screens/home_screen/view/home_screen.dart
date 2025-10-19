import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/core/function/alertexitapp.dart';
import 'package:ecommerce_app/screens/home_screen/controller/home_screen_controller.dart';
import 'package:ecommerce_app/screens/home_screen/widget/custom_buttomappbar_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              controller.goToCart();
            },
            backgroundColor: AppColor.primaryColor,
            foregroundColor: Colors.white,
            child: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const CustomButtomAppBarHome(),
          body: PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              alertExitApp(didPop);
            },
            child: controller.listPage.elementAt(controller.currentpage),
          ),
        );
      },
    );
  }
}
