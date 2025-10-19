// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/core/constant/app_image.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';
import 'package:ecommerce_app/core/function/translatedatabase.dart';
import 'package:ecommerce_app/data/model/items_model.dart';
import 'package:ecommerce_app/screens/offers/controller/offers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListOffers extends GetView<OffersControllerImp> {
  final ItemsModel itemsModel;
  const CustomListOffers({
    super.key,
    required this.itemsModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.goToItemsDetails(itemsModel),
      child: Card(
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: "${itemsModel.itemsId}",
                    child: CachedNetworkImage(
                      imageUrl:
                          "${AppLinks.imageItems}/${itemsModel.itemsImage}",
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    "${translateDatabase(itemsModel.itemsNameAr, itemsModel.itemsName)}",
                    style: const TextStyle(
                        color: AppColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Icon(
                          Icons.timer_sharp,
                          color: AppColor.grey,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${controller.deliveryTime} Mintue",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontFamily: "sans"),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${itemsModel.itemsPriceDiscount} \$",
                        style: const TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "sans"),
                      ),
                      GetBuilder<OffersControllerImp>(
                        builder: (controller) {
                          return IconButton(
                              onPressed: () {
                                if (controller.isFavorite[itemsModel.itemsId] ==
                                    1) {
                                  controller.setFavorite(itemsModel.itemsId, 0);
                                  controller.removeFavorite(
                                      itemsModel.itemsId.toString());
                                } else {
                                  controller.setFavorite(itemsModel.itemsId, 1);
                                  controller.addFavorite(
                                      itemsModel.itemsId.toString());
                                }
                              },
                              icon: Icon(
                                controller.isFavorite[itemsModel.itemsId] == 1
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColor.primaryColor,
                              ));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            if (itemsModel.itemsDiscount != 0)
              const Positioned(
                  child: CircleAvatar(
                radius: 23,
                backgroundImage: AssetImage(AppImage.sale),
              ))
          ],
        ),
      ),
    );
  }
}
