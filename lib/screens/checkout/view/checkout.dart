import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/core/constant/app_image.dart';
import 'package:ecommerce_app/screens/checkout/controller/checkout_controller.dart';
import 'package:ecommerce_app/screens/checkout/widgets/card_delivery_type.dart';
import 'package:ecommerce_app/screens/checkout/widgets/card_payment_method.dart';
import 'package:ecommerce_app/screens/checkout/widgets/card_shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    CheckoutControllerImp checkoutControllerImp =
        Get.put(CheckoutControllerImp());
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: MaterialButton(
          color: AppColor.secondColor,
          textColor: Colors.white,
          onPressed: () {
            checkoutControllerImp.checkout();
          },
          child: const Text(
            "Checkout",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: GetBuilder<CheckoutControllerImp>(builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                const Text(
                  "Choose Payment Method",
                  style: TextStyle(
                      color: AppColor.secondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(height: 10),
                CardPaymentMethod(
                  title: 'Cach On Delivery',
                  isActive: controller.paymentMthode == "0",
                  onTap: () {
                    controller.choosePaymentMethod("0"); // 0 => cash
                  },
                ),
                const SizedBox(height: 10),
                CardPaymentMethod(
                  title: 'Payment Cards',
                  isActive: controller.paymentMthode == "1",
                  onTap: () {
                    controller.choosePaymentMethod("1"); // 1 => card
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Choose Delivery Type",
                  style: TextStyle(
                      color: AppColor.secondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardDeliveryType(
                      image: AppImage.delivery,
                      title: 'Delivery',
                      isAcvtive: controller.deliveryType == "0",
                      onTap: () {
                        controller.chooseDeliveryType("0"); // 0 => delivery
                      },
                    ),
                    CardDeliveryType(
                      image: AppImage.drivethru,
                      title: 'Revice',
                      isAcvtive: controller.deliveryType == "1",
                      onTap: () {
                        controller.chooseDeliveryType("1"); // 1 => revice
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                if (controller.deliveryType == "0")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.data.isNotEmpty)
                        const Text(
                          "Shipping Address",
                          style: TextStyle(
                              color: AppColor.secondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      if (controller.data.isEmpty)
                        InkWell(
                          onTap: () {},
                          child: const Center(
                            child: Text(
                              "Please Add Shpping Address \n Click Here",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                      ...List.generate(
                        controller.data.length,
                        (index) => CardShippingAddress(
                          title: '${controller.data[index].addressName}',
                          body1: '${controller.data[index].addressCity}',
                          body2: '${controller.data[index].addressStreet}',
                          isActive: controller.addressId ==
                                  controller.data[index].addressId.toString()
                              ? true
                              : false,
                          onTap: () {
                            controller.chooseShippingAddress(
                                controller.data[index].addressId!.toString());
                          },
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        );
      }),
    );
  }
}
