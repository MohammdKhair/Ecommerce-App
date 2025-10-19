// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/notification_data.dart';
import 'package:ecommerce_app/data/model/notification_model.dart';
import 'package:get/get.dart';

abstract class NotificationController extends GetxController {
  getNotification();
}

class NotificationControllerImp extends NotificationController {
  NotificationData notificationData = NotificationData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  List<NotificationModel> data = [];
  List responsedata = [];

  @override
  getNotification() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await notificationData
        .getAllData(myServices.sharedPreferences.getString('id')!);
    print("Full Response=========: ${response.toString()}");
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        responsedata = response['data'];
        data.addAll(responsedata.map((e) => NotificationModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getNotification();
    super.onInit();
  }
}
