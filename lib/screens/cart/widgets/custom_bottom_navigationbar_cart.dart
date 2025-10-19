import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/screens/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/screens/cart/widgets/botton_cart.dart';
import 'package:ecommerce_app/screens/cart/widgets/button_coupon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarCart extends GetView<CartControllerImp> {
  final String price;
  final String discount;
  final String shipping;
  final String totalprice;
  final TextEditingController? controllerCoupon;
  final void Function()? onAplly;
  const BottomNavigationBarCart(
      {super.key,
      required this.price,
      required this.discount,
      required this.totalprice,
      this.controllerCoupon,
      this.onAplly,
      required this.shipping});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<CartControllerImp>(builder: (controller) {
          return controller.couponname == null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            cursorColor: AppColor.primaryColor,
                            controller: controllerCoupon,
                            decoration: const InputDecoration(
                                hintText: "Coupon Code",
                                helperStyle: TextStyle(fontFamily: "sans"),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor)),
                                border: OutlineInputBorder()),
                          )),
                      const SizedBox(width: 5),
                      Expanded(
                          flex: 1,
                          child: CustomButtonCoupon(
                            textbutton: "apply",
                            onPressed: onAplly,
                          ))
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    "Coupon Code ${controller.couponname}",
                    style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                );
        }),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Price", style: TextStyle(fontSize: 18)),
                    Text("$price \$", style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Discount", style: TextStyle(fontSize: 18)),
                    Text("$discount %", style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Shipping", style: TextStyle(fontSize: 18)),
                    Text("$shipping \$", style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 17),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Price",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor),
                    ),
                    Text(
                      "$totalprice \$",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        CustomButtonCart(
          textbutton: 'Order',
          onPressed: () {
            controller.goToCheckout();
          },
        ),
      ],
    );
  }
}
