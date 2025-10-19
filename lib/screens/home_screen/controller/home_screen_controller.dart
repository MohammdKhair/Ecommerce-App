import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/screens/home/view/home.dart';
import 'package:ecommerce_app/screens/notification/view/notification.dart';
import 'package:ecommerce_app/screens/offers/view/offers.dart';
import 'package:ecommerce_app/screens/settings/view/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int index);
  goToCart();
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;
  List<Widget> listPage = [
    const Home(),
    const NotificationView(),
    const Offers(),
    const Settings(),
  ];

  List bottomappbar = [
    {"title": "home", "icon": Icons.home, "icon out": Icons.home_outlined},
    {
      "title": "notify",
      "icon": Icons.notifications_active,
      "icon out": Icons.notifications_active_outlined
    },
    {
      "title": "profile",
      "icon": Icons.person,
      "icon out": Icons.person_outline
    },
    {
      "title": "settings",
      "icon": Icons.settings,
      "icon out": Icons.settings_outlined
    },
  ];

  @override
  changePage(int index) {
    currentpage = index;
    update();
  }

  @override
  goToCart() {
    Get.toNamed(AppRoute.cart);
  }
}
