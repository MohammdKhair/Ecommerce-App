// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/cart_data.dart';
import 'package:ecommerce_app/data/model/items_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ItemsDetailsController extends GetxController {
  intialData();
  addItems(String itemsid);
  deleteItems(String itemsid);
  getCountItems(String itemsid);
  add();
  remove();
  goToCard();
  refreshItemsCount();
}

class ItemsDetailsControllerImp extends ItemsDetailsController {
  late ItemsModel itemsModel;
  StatusRequest statusRequest = StatusRequest.none;
  int countitems = 0;

  List subItems = [
    {"name": "red", "id": "1", "active": "1"},
    {"name": "blue", "id": "2", "active": "0"},
    {"name": "green", "id": "3", "active": "0"}
  ];

  MyServices myServices = Get.find();
  CartData cartData = CartData(Get.find());

  @override
  addItems(itemsid) async {
    var response = await cartData.addCart(
        myServices.sharedPreferences.getString('id')!, itemsid);
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.rawSnackbar(
            duration: const Duration(milliseconds: 1000),
            title: "اشعار",
            messageText: const Text("تم اضافة المنتج الى السلة"));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  deleteItems(itemsid) async {
    var response = await cartData.deleteCart(
        myServices.sharedPreferences.getString('id')!, itemsid);
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.rawSnackbar(
            duration: const Duration(milliseconds: 1000),
            title: "اشعار",
            messageText: const Text("تم حذف المنتج من السلة"));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  getCountItems(itemsid) async {
    var response = await cartData.getCountCart(
        myServices.sharedPreferences.getString('id')!, itemsid);
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        countitems = int.parse(response["data"].toString());
        print("============================ $countitems");
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  intialData() {
    itemsModel = Get.arguments['itemsmodel'];
    getCountItems(itemsModel.itemsId.toString());
  }

  @override
  void onInit() {
    intialData();
    super.onInit();
  }

  @override
  goToCard() {
    Get.toNamed(AppRoute.cart);
  }

  @override
  add() {
    countitems++;
    update();
    addItems(itemsModel.itemsId.toString());
  }

  @override
  remove() {
    if (countitems > 0) {
      countitems--;
      update();
      deleteItems(itemsModel.itemsId.toString());
    }
  }
  
  @override
  refreshItemsCount() {
    getCountItems(itemsModel.itemsId.toString());
  }
}
