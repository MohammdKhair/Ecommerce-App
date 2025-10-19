// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/items_data.dart';
import 'package:ecommerce_app/data/model/items_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ItemsController extends GetxController {
  intialData();
  changeCat(String val);
  getItems(String categoriesid);
  goToItemsDetails(ItemsModel itemsmodel);
  goToFavorite();
  setFavorite(id, val);
  addFavorite(String itemid);
  removeFavorite(String itemid);
  refreshItemsCount();
}

class ItemsControllerImp extends ItemsController {
  MyServices myServices = Get.find();
  List categories = [];
  late String categoriesid;
  ItemsData itemsData = ItemsData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  List data = [];
  Map isFavorite = {};
  String deliveryTime = "";

  @override
  getItems(categoriesid) async {
    data.clear();
    isFavorite.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await itemsData.getData(
        categoriesid, myServices.sharedPreferences.getString('id')!);
    print("Full Response=========: ${response.toString()}");
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        data.addAll(response['data']);
        for (var item in data) {
          isFavorite[item['items_id']] = item['favorite'];
        }
        print("=====================$isFavorite");
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  refreshItemsCount() {
    getItems(categoriesid);
    super.refresh();
  }

  @override
  setFavorite(id, val) {
    isFavorite[id] = val;
    print('======== set $isFavorite');
    update();
  }

  @override
  addFavorite(itemid) async {
    var response = await itemsData.addFavorite(
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
    var response = await itemsData.removeFavorite(
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
  intialData() {
    deliveryTime = myServices.sharedPreferences.getString("deliveryTime")!;
    categories = Get.arguments['categories'];
    categoriesid = Get.arguments['categoriesid'];
    getItems(categoriesid);
  }

  @override
  changeCat(val) {
    categoriesid = val;
    getItems(categoriesid);
    update();
  }

  @override
  goToItemsDetails(itemsmodel) {
    Get.toNamed(AppRoute.itemsDetails, arguments: {"itemsmodel": itemsmodel});
  }

  @override
  goToFavorite() {
    Get.toNamed(AppRoute.favorite);
  }

  @override
  void onInit() {
    intialData();
    super.onInit();
  }
}
