import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/shared/custom_appbar.dart';
import 'package:ecommerce_app/screens/favorite/controller/favorite_controller.dart';
import 'package:ecommerce_app/screens/favorite/widget/custom_list_favorite_items.dart';
import 'package:ecommerce_app/core/shared/search/list_items_search.dart';
import 'package:ecommerce_app/core/shared/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteControllerImp());
    SearchControllerImp searchControllerImp = Get.put(SearchControllerImp());
    return Scaffold(
      body: GetBuilder<FavoriteControllerImp>(
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              controller.alertExitApp(didPop);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  CustomAppBar(
                    titleappbar: "Find Product",
                    onPressedsearch: () {
                      searchControllerImp.onSearchItems();
                    },
                    onPressedfavotite: () {
                      controller.goBack();
                    },
                    controller: searchControllerImp.search,
                    onChanged: (val) {
                      searchControllerImp.checkSearch(val);
                    },
                  ),
                  GetBuilder<SearchControllerImp>(builder: (controlersearch) {
                    return HandlingDataView(
                      statusRequest: controlersearch.statusRequest,
                      widget: controlersearch.isSearch
                          ? ListItemsSearch(
                              listdatamodel: controlersearch.listdata,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                HandlingDataView(
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
                                      return CustomListFavoriteItems(
                                          favoriteModel:
                                              controller.data[index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                    );
                  })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
