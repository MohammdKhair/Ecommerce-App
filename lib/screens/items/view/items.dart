import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/shared/custom_appbar.dart';
import 'package:ecommerce_app/data/model/items_model.dart';
import 'package:ecommerce_app/screens/items/controller/items_controller.dart';
import 'package:ecommerce_app/screens/items/widget/custom_list_items.dart';
import 'package:ecommerce_app/screens/items/widget/list_categories_items.dart';
import 'package:ecommerce_app/core/shared/search/list_items_search.dart';
import 'package:ecommerce_app/core/shared/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    ItemsControllerImp itemsControllerImp = Get.put(ItemsControllerImp());
    SearchControllerImp searchControllerImp = Get.put(SearchControllerImp());
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              CustomAppBar(
                titleappbar: "Find Product",
                onPressedsearch: () {
                  searchControllerImp.onSearchItems();
                },
                onPressedfavotite: () {
                  itemsControllerImp.goToFavorite();
                },
                controller: searchControllerImp.search,
                onChanged: (val) {
                  searchControllerImp.checkSearch(val);
                },
              ),
              GetBuilder<SearchControllerImp>(builder: (controller) {
                return HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: controller.isSearch
                      ? ListItemsSearch(
                          listdatamodel: controller.listdata,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const ListCategoriesItems(),
                            GetBuilder<ItemsControllerImp>(
                              builder: (controller) {
                                return HandlingDataView(
                                  statusRequest: controller.statusRequest,
                                  widget: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.data.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.75),
                                    itemBuilder: (context, index) {
                                      return CustomListItems(
                                        itemsModel: ItemsModel.fromJson(
                                            controller.data[index]),
                                      );
                                    },
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                );
              })
            ],
          )),
    );
  }
}
