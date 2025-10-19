import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/screens/itemsdetails/controller/itemsdetails_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubItemsList extends GetView<ItemsDetailsControllerImp> {
  const SubItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          controller.subItems.length,
          (index) => Container(
            height: 60,
            width: 90,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: controller.subItems[index]['active'] == 1
                    ? AppColor.fourthColor
                    : AppColor.wihte,
                border: Border.all(color: AppColor.fourthColor),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                controller.subItems[index]['name'],
                style: TextStyle(
                    color: controller.subItems[index]['active'] == 1
                        ? AppColor.wihte
                        : AppColor.fourthColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}
