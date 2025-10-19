import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/function/validinput.dart';
import 'package:ecommerce_app/core/shared/custom_button_default.dart';
import 'package:ecommerce_app/screens/address/address_add_details/controller/address_add_details_controller.dart';
import 'package:ecommerce_app/screens/auth/widgets/custom_text_form_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressAddDetails extends StatelessWidget {
  const AddressAddDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddressAddControllerDetailsImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Adderss"),
      ),
      body: GetBuilder<AddressAddControllerDetailsImp>(builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: controller.formstate,
              child: ListView(
                children: [
                  CustomTextFormAuth(
                    controller: controller.city,
                    hintText: "city",
                    labelText: "city",
                    icon: Icons.location_city,
                    keyboardType: TextInputType.name,
                    validator: (val) {
                      return validInput(val!, 5, 100, "city");
                    },
                  ),
                  CustomTextFormAuth(
                    controller: controller.street,
                    hintText: "street",
                    labelText: "street",
                    icon: Icons.streetview,
                    keyboardType: TextInputType.streetAddress,
                    validator: (val) {
                      return validInput(val!, 5, 100, "street");
                    },
                  ),
                  CustomTextFormAuth(
                    controller: controller.name,
                    hintText: "name",
                    labelText: "name",
                    icon: Icons.near_me,
                    keyboardType: TextInputType.name,
                    validator: (val) {
                      return validInput(val!, 5, 100, "name");
                    },
                  ),
                  CustomButtonDefault(
                    text: "Add",
                    onPressed: () {
                      controller.addAddress();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
