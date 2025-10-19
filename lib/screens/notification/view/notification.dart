import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/screens/notification/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationControllerImp());
    return GetBuilder<NotificationControllerImp>(builder: (controller) {
      return HandlingDataView(
        statusRequest: controller.statusRequest,
        widget: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const Center(
                child: Text(
                  "Notififcation",
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              ...List.generate(
                  controller.data.length,
                  (index) => Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Stack(
                            children: [
                              ListTile(
                                title: Text(
                                    controller.data[index].notificationTitle!),
                                subtitle: Text(
                                    controller.data[index].notificationBody!),
                              ),
                              Positioned(
                                  right: 5,
                                  child: Text(
                                    Jiffy.parse(controller
                                            .data[index].notificationDatetime
                                            .toString())
                                        .fromNow(),
                                    style: const TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      ))
            ],
          ),
        ),
      );
    });
  }
}
