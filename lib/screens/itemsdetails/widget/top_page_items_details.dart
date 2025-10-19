import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';
import 'package:ecommerce_app/screens/itemsdetails/controller/itemsdetails_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopPageItemsDetails extends GetView<ItemsDetailsControllerImp> {
  const TopPageItemsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(
            color: AppColor.secondColor,
          ),
        ),
        Positioned(
            top: 45.0,
            right: Get.width / 8,
            left: Get.width / 8,
            child: Hero(
              tag: "${controller.itemsModel.itemsId}",
              child: CachedNetworkImage(
                imageUrl:
                    "${AppLinks.imageItems}/${controller.itemsModel.itemsImage!}",
                height: 200,
                fit: BoxFit.fill,
              ),
            ))
      ],
    );
  }
}
