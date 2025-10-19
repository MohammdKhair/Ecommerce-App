import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/screens/address/address_view/controller/address_view_controller.dart';
import 'package:ecommerce_app/screens/address/address_view/widget/cart_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  get i => null;

  @override
  Widget build(BuildContext context) {
    Get.put(AddressViewControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Addresses"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoute.addressAdd);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: GetBuilder<AddressViewControllerImp>(builder: (controller) {
        return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: controller.data.length,
                itemBuilder: (context, i) {
                  return CartAddress(
                    addressModel: controller.data[i],
                    onDelete: () {
                      controller.deleteAddress(
                          controller.data[i].addressId.toString());
                    },
                  );
                },
              ),
            ));
      }),
    );
  }
}
