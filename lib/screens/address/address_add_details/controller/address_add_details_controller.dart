// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/address_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AddressAddControllerDetails extends GetxController {
  inialData();
  addAddress();
}

class AddressAddControllerDetailsImp extends AddressAddControllerDetails {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  AddressData addressData = AddressData(Get.find());
  MyServices myServices = Get.find();
  String? lat;
  String? long;
  TextEditingController? name;
  TextEditingController? city;
  TextEditingController? street;

  @override
  inialData() {
    name = TextEditingController();
    city = TextEditingController();
    street = TextEditingController();
    lat = Get.arguments['lat'];
    long = Get.arguments['long'];
    print("========$lat");
    print("========$long");
  }

  @override
  void dispose() {
    name?.dispose();
    city?.dispose();
    street?.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    inialData();
    super.onInit();
  }

  @override
  addAddress() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await addressData.addData(
          myServices.sharedPreferences.getString("id")!,
          name!.text,
          city!.text,
          street!.text,
          lat!,
          long!);

      print("====================Controller $response");

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offAllNamed(AppRoute.homeScreen);
          Get.snackbar("success", "Now , You Can order to this address");
        } else {
          statusRequest = StatusRequest.failure;
          Get.defaultDialog(title: "Error", middleText: "Error");
        }
      }
      update();
      print("Valid");
    } else {
      print("Not Valid");
    }
  }
}
