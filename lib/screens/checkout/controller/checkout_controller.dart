// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/address_data.dart';
import 'package:ecommerce_app/data/datasource/remote/checkout_data.dart';
import 'package:ecommerce_app/data/model/address_model.dart';
import 'package:get/get.dart';

abstract class CheckoutController extends GetxController {
  choosePaymentMethod(String val);
  chooseDeliveryType(String val);
  chooseShippingAddress(String val);
  getShippingAddress();
  checkout();
}

class CheckoutControllerImp extends CheckoutController {
  AddressData addressData = AddressData(Get.find());
  CheckoutData checkoutData = CheckoutData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  List<AddressModel> data = [];
  List responsedata = [];
  String? paymentMthode;
  String? deliveryType;
  String addressId = "0";
  String? couponid;
  String? priceorder;
  String? discountcoupon;

  @override
  choosePaymentMethod(val) {
    paymentMthode = val;
    update();
  }

  @override
  chooseDeliveryType(val) {
    deliveryType = val;
    update();
  }

  @override
  chooseShippingAddress(val) {
    addressId = val;
    update();
  }

  @override
  getShippingAddress() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await addressData
        .getData(myServices.sharedPreferences.getString('id')!);

    print("====================Controller $response");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        responsedata = response['data'];
        data.addAll(responsedata.map((e) => AddressModel.fromJson(e)));
        addressId = data[0].addressId.toString();
        if (data.isEmpty) {
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  checkout() async {
    if (paymentMthode == null) {
      return Get.snackbar("Error", "Please select a payment mthode");
    }
    if (deliveryType == null) {
      return Get.snackbar("Error", "Please select a order Type");
    }
    if (deliveryType == "0" && addressId == "0") {
      return Get.snackbar("Error", "Please select an address");
    }
    if (deliveryType == "1") {
      addressId = "0";
    }

    statusRequest = StatusRequest.loading;
    update();

    Map data = {
      "usersid": myServices.sharedPreferences.getString("id"),
      "addressid": addressId,
      "orderstype": deliveryType,
      "pricedelivery": "10",
      "ordersprice": priceorder,
      "couponid": couponid,
      "discountcoupon": discountcoupon,
      "paymentmethod": paymentMthode,
    };

    var response = await checkoutData.checkout(data);

    print("====================Controller $response");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        print("=============success===============");
        Get.offAllNamed(AppRoute.homeScreen);
        Get.snackbar("Success", "the order was successfully");
      } else {
        statusRequest = StatusRequest.none;
        Get.snackbar("Error", "try again");
      }
    }
    update();
  }

  @override
  void onInit() {
    couponid = Get.arguments['couponid'];
    priceorder = Get.arguments['priceorder'];
    discountcoupon = Get.arguments['discountcoupon'];
    getShippingAddress();
    super.onInit();
  }
}
