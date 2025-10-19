import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/function/translatedatabase.dart';
import 'package:ecommerce_app/screens/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/screens/cart/widgets/custom_bottom_navigationbar_cart.dart';
import 'package:ecommerce_app/screens/cart/widgets/custom_items_cart_list.dart';
import 'package:ecommerce_app/screens/cart/widgets/top_card_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartControllerImp());
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      bottomNavigationBar: GetBuilder<CartControllerImp>(builder: (controller) {
        return BottomNavigationBarCart(
          price: "${controller.priceorder}",
          discount: "${controller.discountcoupon}",
          shipping: "10",
          totalprice: "${controller.getTotalPrice()}",
          controllerCoupon: controller.controllerCoupon,
          onAplly: () {
            controller.checkcoupon();
          },
        );
      }),
      body: GetBuilder<CartControllerImp>(builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            controller.alertExitApp(didPop);
          },
          child: ListView(
            children: [
              const SizedBox(height: 10),
              TopCardCart(
                  title:
                      "You Have ${controller.totalcountitems} Items in Your List"),
              HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ...List.generate(
                        controller.data.length,
                        (index) => CustomItemsCartList(
                          name:
                              "${translateDatabase(controller.data[index].itemsNameAr, controller.data[index].itemsName)}",
                          price: "${controller.data[index].itemsprices}",
                          count: "${controller.data[index].countitems}",
                          image: '${controller.data[index].itemsImage}',
                          onAdd: () {
                            controller.addItems(
                                controller.data[index].itemsId.toString());
                          },
                          onRemove: () {
                            controller.deleteItems(
                                controller.data[index].itemsId.toString());
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
