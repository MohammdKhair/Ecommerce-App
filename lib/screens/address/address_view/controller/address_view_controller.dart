// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/address_data.dart';
import 'package:ecommerce_app/data/model/address_model.dart';
import 'package:get/get.dart';

abstract class AddressViewController extends GetxController {
  getAddress();
  deleteAddress(String addressid);
}

class AddressViewControllerImp extends AddressViewController {
  StatusRequest statusRequest = StatusRequest.none;
  AddressData addressData = AddressData(Get.find());
  MyServices myServices = Get.find();
  List<AddressModel> data = [];
  List responsedata = [];

  @override
  deleteAddress(String addressid) async {
    await addressData.deleteData(addressid);
    data.removeWhere(((element) => element.addressId.toString() == addressid));
    if (data.isEmpty) {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  @override
  getAddress() async {
    statusRequest = StatusRequest.loading;

    var response = await addressData
        .getData(myServices.sharedPreferences.getString('id')!);

    print("====================Controller $response");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        responsedata = response['data'];
        data.addAll(responsedata.map((e) => AddressModel.fromJson(e)));
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
  void onInit() {
    getAddress();
    super.onInit();
  }
}
