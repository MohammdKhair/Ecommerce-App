// ignore_for_file: deprecated_member_use

import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/shared/custom_appbar.dart';
import 'package:ecommerce_app/screens/home/controller/home_controller.dart';
import 'package:ecommerce_app/screens/home/widget/custom_card_offer.dart';
import 'package:ecommerce_app/screens/home/widget/custom_title_home.dart';
import 'package:ecommerce_app/screens/home/widget/list_categories_home.dart';
import 'package:ecommerce_app/screens/home/widget/list_items_home.dart';
import 'package:ecommerce_app/core/shared/search/list_items_search.dart';
import 'package:ecommerce_app/core/shared/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    SearchControllerImp searchControllerImp = Get.put(SearchControllerImp());
    return GetBuilder<HomeControllerImp>(
      builder: (controller1) => HandlingDataView(
        statusRequest: controller1.statusRequest,
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
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
              GetBuilder<SearchControllerImp>(builder: (controller2) {
                return HandlingDataView(
                  statusRequest: controller2.statusRequest,
                  widget: controller2.isSearch
                      ? ListItemsSearch(
                          listdatamodel: controller2.listdata,
                        )
                      : Column( 
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(controller1.settings.isNotEmpty) CustomCardOffer(
                              title: controller1.titleHome,
                              body: controller1.bodyHome,
                            ),
                            CustomTitleHome(title: "52".tr),
                            const ListCategoriesHome(),
                            CustomTitleHome(title: "53".tr),
                            const ListItemsHome(),     
                          ],
                        ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
