// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';
import 'package:ecommerce_app/core/function/translatedatabase.dart';
import 'package:ecommerce_app/data/model/favorite_model.dart';
import 'package:ecommerce_app/screens/favorite/controller/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListFavoriteItems extends GetView<FavoriteControllerImp> {
  final FavoriteModel favoriteModel;
  const CustomListFavoriteItems({
    super.key,
    required this.favoriteModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      // onTap: () => controller.goToItemsDetails(favoriteModel),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: "${favoriteModel.itemsId}",
                child: CachedNetworkImage(
                  imageUrl:
                      "${AppLinks.imageItems}/${favoriteModel.itemsImage}",
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                "${translateDatabase(favoriteModel.itemsNameAr, favoriteModel.itemsName)}",
                style: const TextStyle(
                    color: AppColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Rating 3.5 ",
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 22,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        ...List.generate(
                            5,
                            (index) => const Icon(
                                  Icons.star,
                                  size: 14,
                                ))
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${favoriteModel.itemsPrice} \$",
                    style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "sans"),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.deleteFavorite(
                            favoriteModel.favoriteId.toString(),favoriteModel.favoriteItemsid);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColor.primaryColor,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
