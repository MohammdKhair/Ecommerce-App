import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/core/function/translatedatabase.dart';
import 'package:ecommerce_app/screens/itemsdetails/controller/itemsdetails_controller.dart';
import 'package:ecommerce_app/screens/itemsdetails/widget/add_button.dart';
import 'package:ecommerce_app/screens/itemsdetails/widget/price_and_count.dart';
import 'package:ecommerce_app/screens/itemsdetails/widget/subitems_list.dart';
import 'package:ecommerce_app/screens/itemsdetails/widget/top_page_items_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsDetails extends StatelessWidget {
  const ItemsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ItemsDetailsControllerImp itemsDetailsControllerImp =
        Get.put(ItemsDetailsControllerImp());
    return Scaffold(
      bottomNavigationBar: AddButton(onPressed: () {
        itemsDetailsControllerImp.goToCard();
      }),
      body: GetBuilder<ItemsDetailsControllerImp>(builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: ListView(
            children: [
              const TopPageItemsDetails(),
              const SizedBox(height: 70),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${translateDatabase(controller.itemsModel.itemsNameAr, controller.itemsModel.itemsName)}",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColor.fourthColor),
                    ),
                    PriceAndCount(
                      onAdd: () {
                        controller.add();
                      },
                      onRemove: () {
                        controller.remove();
                      },
                      price: "${controller.itemsModel.itemsPriceDiscount}\$",
                      count: "${controller.countitems}",
                    ),
                    Text(
                        "${translateDatabase(controller.itemsModel.itemsDescAr, controller.itemsModel.itemsDesc)}",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                color: AppColor.grey2,
                                fontWeight: FontWeight.normal)),
                    const SizedBox(height: 15),
                    Text(
                      "Color",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColor.fourthColor),
                    ),
                    const SizedBox(height: 10),
                    const SubItemsList()
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
