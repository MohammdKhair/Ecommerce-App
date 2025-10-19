import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/shared/custom_appbar.dart';
import 'package:ecommerce_app/core/shared/search/list_items_search.dart';
import 'package:ecommerce_app/core/shared/search/search_controller.dart';
import 'package:ecommerce_app/screens/offers/controller/offers_controller.dart';
import 'package:ecommerce_app/screens/offers/widget/custom_list_offers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OffersControllerImp());
    SearchControllerImp searchControllerImp = Get.put(SearchControllerImp());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GetBuilder<OffersControllerImp>(builder: (controller1) {
          return HandlingDataView(
            statusRequest: controller1.statusRequest,
            widget: ListView(
              children: [
                CustomAppBar(
                  titleappbar: "Find Product",
                  onPressedsearch: () {
                    searchControllerImp.onSearchItems();
                  },
                  onPressedfavotite: () {
                    controller1.goToFavorite();
                  },
                  controller: searchControllerImp.search,
                  onChanged: (val) {
                    searchControllerImp.checkSearch(val);
                  },
                ),
                const SizedBox(height: 20),
                GetBuilder<SearchControllerImp>(builder: (controller2) {
                  return controller2.isSearch
                      ? ListItemsSearch(
                          listdatamodel: controller2.listdata,
                        )
                      : HandlingDataView(
                          statusRequest: controller1.statusRequest,
                          widget: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller1.data.length,
                            itemBuilder: (context, index) {
                              return CustomListOffers(
                                itemsModel: controller1.data[index],
                              );
                            },
                          ));
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
