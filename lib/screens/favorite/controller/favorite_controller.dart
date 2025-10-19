// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/favorite_data.dart';
import 'package:ecommerce_app/data/model/favorite_model.dart';
import 'package:ecommerce_app/screens/items/controller/items_controller.dart';
import 'package:get/get.dart';
import '../../../core/class/status_request.dart';

abstract class FavoriteController extends GetxController {
  viewFavorite();
  deleteFavorite(String favoriteid, favoriteitemid);
  alertExitApp(didpop);
  goBack();
}

class FavoriteControllerImp extends FavoriteController {
  MyServices myServices = Get.find();
  FavoriteData favoriteData = FavoriteData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  List<FavoriteModel> data = [];
  List responsedata = [];
  late ItemsControllerImp itemsControllerImp;

  @override
  viewFavorite() async {
    statusRequest = StatusRequest.loading;
    var response = await favoriteData
        .viewFavorite(myServices.sharedPreferences.getString('id')!);
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        responsedata = response['data'];
        data.addAll(responsedata.map((e) => FavoriteModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  deleteFavorite(favoriteid, favoriteitemid) {
    var response = favoriteData.deleteFavorite(favoriteid);
    print("====================Controller $response");
    data.removeWhere((element) => element.favoriteId.toString() == favoriteid);
    update();
    // itemsControllerImp.setFavorite(favoriteitemid, 0);
  }

  @override
  alertExitApp(didpop) {
    if (didpop) {
      return;
    } else {
      if (Get.previousRoute == "/items") {
        Get.back();
        itemsControllerImp.refreshItemsCount();
      } else {
        Get.back();
      }
    }
  }

  @override
  void onInit() {
    viewFavorite();
    if (Get.previousRoute == "/items") {
      itemsControllerImp = Get.find();
    }
    super.onInit();
  }

  @override
  goBack() {
    if (Get.previousRoute == "/items") {
      Get.back();
      itemsControllerImp.refreshItemsCount();
    } else {
      Get.back();
    }
  }
}
