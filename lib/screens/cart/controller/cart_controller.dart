// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/cart_data.dart';
import 'package:ecommerce_app/data/model/cart_model.dart';
import 'package:ecommerce_app/data/model/coupon_model.dart';
import 'package:ecommerce_app/screens/itemsdetails/controller/itemsdetails_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CartController extends GetxController {
  view();
  addItems(String itemsid);
  deleteItems(String itemsid);
  checkcoupon();
  getTotalPrice();
  goToCheckout();
}

class CartControllerImp extends CartController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  CartData cartData = CartData(Get.find());
  List<CartModel> data = [];
  double priceorder = 0.0;
  int totalcountitems = 0;
  late ItemsDetailsControllerImp itemsDetailsControllerImp;
  TextEditingController? controllerCoupon;
  CouponModel? couponModel;
  int? discountcoupon = 0;
  String? couponname;
  String? couponid;

  @override
  view() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await cartData.viewCart(myServices.sharedPreferences.getString('id')!);
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      priceorder = 0;
      totalcountitems = 0;
      if (response['status'] == "success") {
        List responsdata = response["datacart"];
        Map countprice = response["countprice"];
        data.clear();
        data.addAll(responsdata.map((e) => CartModel.fromJson(e)));
        priceorder = double.parse(countprice['totalprice'].toString());
        totalcountitems = int.parse(countprice['totalcount'].toString());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  addItems(itemsid) async {
    var response = await cartData.addCart(
        myServices.sharedPreferences.getString('id')!, itemsid);
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        view();
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
        view();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  checkcoupon() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.checkCoupon(controllerCoupon!.text);
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Map<String, dynamic> coupondata = response['data'];
        couponModel = CouponModel.fromJson(coupondata);
        discountcoupon = couponModel!.couponDiscount;
        couponname = couponModel!.couponName;
        couponid = couponModel!.couponId.toString();
      } else {
        Get.snackbar("Warning", "Coupon Not Valid");
        discountcoupon = 0;
        couponname = null;
        couponid = null;
      }
    }
    update();
  }

  @override
  getTotalPrice() {
    return (priceorder - priceorder * discountcoupon! / 100);
  }

  @override
  goToCheckout() {
    if (data.isEmpty) return Get.snackbar("تنبيه", "السلة فارغة");
    Get.toNamed(AppRoute.checkout, arguments: {
      "couponid": couponid ?? "0",
      "priceorder": priceorder.toString(),
      "discountcoupon" : discountcoupon.toString()
    });
  }

  @override
  void onInit() {
    controllerCoupon = TextEditingController();
    view();
    if (Get.previousRoute == "/itemsdetails") {
      itemsDetailsControllerImp = Get.find();
    }
    super.onInit();
  }

  alertExitApp(didpop) {
    if (didpop) {
      return;
    } else {
      if (Get.previousRoute == "/itemsdetails") {
        Get.back();
        itemsDetailsControllerImp.refreshItemsCount();
      } else {
        Get.back();
      }
    }
  }
}
