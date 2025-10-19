// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/datasource/remote/orders/archive_data.dart';
import 'package:ecommerce_app/data/model/orders_model.dart';
import 'package:get/get.dart';

abstract class OrdersArchiveController extends GetxController {
  getOrders();
  refreshOrders();
  String printTypeOrder(String val);
  String printPaymentMethod(String val);
  String printOrderStatus(String val);
  goToOrdersDetails(OrdersModel ordersModel);
  submitRating(String ordersid, double rating, String comment);
}

class OrdersArchiveControllerImp extends OrdersArchiveController {
  MyServices myServices = Get.find();
  OrdersArchiveData ordersArchiveData = OrdersArchiveData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  List<OrdersModel> data = [];

  @override
  String printTypeOrder(String val) {
    if (val == "0") {
      return "delivery";
    } else {
      return "Recive";
    }
  }

  @override
  String printPaymentMethod(String val) {
    if (val == "0") {
      return "Cash on Delivery";
    } else {
      return "Payment Card";
    }
  }

  @override
  String printOrderStatus(String val) {
    if (val == "0") {
      return "Await Approval";
    } else if (val == "1") {
      return "The Order is being Prepared";
    } else if (val == "2") {
      return "Ready To Picked up by Delivery man";
    } else if (val == "3") {
      return "On The Way";
    } else {
      return "Archive";
    }
  }

  @override
  getOrders() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersArchiveData
        .getAllData(myServices.sharedPreferences.getString('id')!);
    print("Full Response=========: ${response.toString()}");

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List listdata = response['data'];
        List processedData = listdata.map((item) {
          if (item is Map<String, dynamic>) {
            // تحويل أي int إلى double في الحقول العشرية
            var processedItem = Map<String, dynamic>.from(item);
            if (processedItem['orders_totalprice'] is int) {
              processedItem['orders_totalprice'] =
                  (processedItem['orders_totalprice'] as int).toDouble();
            }
            return processedItem;
          }
          return item;
        }).toList();
        data.addAll(processedData.map((e) => OrdersModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  refreshOrders() {
    getOrders();
  }

  @override
  submitRating(String ordersid, double rating, String comment) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await ordersArchiveData.rating(ordersid, rating.toString(), comment);
    print("Full Response=========: ${response.toString()}");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        getOrders();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  @override
  goToOrdersDetails(OrdersModel ordersModel) {
    Get.toNamed(AppRoute.ordersDetails,
        arguments: {"ordersModel": ordersModel});
  }
}
