// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/data/datasource/remote/home_data.dart';
import 'package:ecommerce_app/data/model/items_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SearchController extends GetxController {
  checkSearch(String val);
  onSearchItems();
  goToItemsDetails(ItemsModel itemsmodel);
  searchData();
}

class SearchControllerImp extends SearchController {
  bool isSearch = false;
  List<ItemsModel> listdata = [];
  TextEditingController? search;
  StatusRequest statusRequest = StatusRequest.none;
  HomeData homeData = HomeData(Get.find());

  @override
  checkSearch(val) {
    if (val == "") {
      isSearch = false;
      update();
    }
  }

  @override
  onSearchItems() {
    isSearch = true;
    searchData();
    update();
  }

  @override
  goToItemsDetails(itemsmodel) {
    Get.toNamed(AppRoute.itemsDetails, arguments: {"itemsmodel": itemsmodel});
  }

  @override
  searchData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.searchData(search!.text);
    print("====================Controller search $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listdata.clear();
        List responsedata = response['data'];
        listdata.addAll(responsedata.map((e) => ItemsModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    search = TextEditingController();
    super.onInit();
  }
}
