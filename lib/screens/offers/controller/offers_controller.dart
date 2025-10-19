// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/offers_data.dart';
import 'package:ecommerce_app/data/model/items_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OffersController extends GetxController {
  getOffers();
  goToItemsDetails(itemsmodel);
  addFavorite(itemid);
  removeFavorite(itemid);
  setFavorite(id, val);
  goToFavorite();
}

class OffersControllerImp extends OffersController {
  MyServices myServices = Get.find();
  OffersData offersData = OffersData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  List<ItemsModel> data = [];
  Map isFavorite = {};
  String deliveryTime = "";

  @override
  getOffers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await offersData.getData(myServices.sharedPreferences.getString("id")!);
    print("Full Response=========: ${response.toString()}");
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List listdata = response["data"];
        data.addAll(listdata.map((e) => ItemsModel.fromJson(e)));
        for (var item in listdata) {
          isFavorite[item['items_id']] = item['favorite'];
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToFavorite() {
    Get.toNamed(AppRoute.favorite);
  }

  @override
  setFavorite(id, val) {
    isFavorite[id] = val;
    print('======== set $isFavorite');
    update();
  }

  @override
  addFavorite(itemid) async {
    var response = await offersData.addFavorite(
        myServices.sharedPreferences.getString('id')!, itemid);
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.rawSnackbar(
            duration: const Duration(milliseconds: 1000),
            title: "اشعار",
            messageText: const Text("تم اضافة المنتج للمفضلة"));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  removeFavorite(itemid) async {
    var response = await offersData.removeFavorite(
        myServices.sharedPreferences.getString('id')!, itemid);
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.rawSnackbar(
            duration: const Duration(milliseconds: 1000),
            title: "اشعار",
            messageText: const Text("تم حذف المنتج من المفضلة"));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToItemsDetails(itemsmodel) {
    Get.toNamed(AppRoute.itemsDetails, arguments: {"itemsmodel": itemsmodel});
  }

  @override
  void onInit() {
    deliveryTime = myServices.sharedPreferences.getString("deliveryTime")!;
    getOffers();
    super.onInit();
  }
}
