// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/home_data.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {
  intialData();
  getData();
  goToItems(List categories, String categoriesid);
  goToFavorite();
  goToItemsDetails(itemsmodel);
}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();

  String? username;
  String? id;
  String? lang;
  String titleHome = "";
  String bodyHome = "";
  String deliveryTime = "";
  String contactus = "";

  HomeData homeData = HomeData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  List categories = [];
  List items = [];
  List settings = [];

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.getData();
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        categories.addAll(response['categories']);
        items.addAll(response['items']);
        settings.addAll(response['settings']);
        titleHome = settings[0]["settings_titlehome"];
        bodyHome = settings[0]["settings_bodyhome"];
        deliveryTime = settings[0]["settings_deliverytime"].toString();
        contactus = settings[0]["settings_contactus"];
        myServices.sharedPreferences.setString("deliveryTime", deliveryTime);
        myServices.sharedPreferences.setString("contactus", contactus);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  intialData() {
    lang = myServices.sharedPreferences.getString("lang");
    username = myServices.sharedPreferences.getString("username");
    id = myServices.sharedPreferences.getString("id");
    getData();
  }

  @override
  goToItems(categories, categoriesid) {
    Get.toNamed(AppRoute.items,
        arguments: {"categories": categories, "categoriesid": categoriesid});
  }

  @override
  void onInit() {
    intialData();
    super.onInit();
  }

  @override
  goToFavorite() {
    Get.toNamed(AppRoute.favorite);
  }

  @override
  goToItemsDetails(itemsmodel) {
    Get.toNamed(AppRoute.itemsDetails, arguments: {"itemsmodel": itemsmodel});
  }
}
