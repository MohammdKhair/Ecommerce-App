// ignore_for_file: deprecated_member_use

import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/core/function/translatedatabase.dart';
import 'package:ecommerce_app/data/model/categories_model.dart';
import 'package:ecommerce_app/screens/items/controller/items_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCategoriesItems extends GetView<ItemsControllerImp> {
  const ListCategoriesItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 11),
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          return CategoriesItems(
            categoriesModel:
                CategoriesModel.fromJson(controller.categories[index]),
          );
        },
      ),
    );
  }
}

class CategoriesItems extends GetView<ItemsControllerImp> {
  final CategoriesModel categoriesModel;
  const CategoriesItems({super.key, required this.categoriesModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.changeCat(categoriesModel.categoriesId.toString());
      },
      child: GetBuilder<ItemsControllerImp>(
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 5),
            decoration: controller.categoriesid ==
                    categoriesModel.categoriesId.toString()
                ? const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 3, color: AppColor.primaryColor)))
                : null,
            child: Text(
              "${translateDatabase(categoriesModel.categoriesNameAr, categoriesModel.categoriesName)}",
              style: const TextStyle(fontSize: 20, color: AppColor.grey2),
            ),
          );
        },
      ),
    );
  }
}
