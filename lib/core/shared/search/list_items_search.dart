import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';
import 'package:ecommerce_app/data/model/items_model.dart';
import 'package:ecommerce_app/core/shared/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListItemsSearch extends GetView<SearchControllerImp> {
  final List<ItemsModel> listdatamodel;

  const ListItemsSearch({super.key, required this.listdatamodel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listdatamodel.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            controller.goToItemsDetails(listdatamodel[index]);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            height: 100,
            child: Card(
              child: Row(
                children: [
                  Expanded(
                      child: CachedNetworkImage(
                          imageUrl:
                              "${AppLinks.imageItems}/${listdatamodel[index].itemsImage}")),
                  Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text(listdatamodel[index].itemsName!),
                        subtitle: Text(listdatamodel[index].categoriesName!),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
