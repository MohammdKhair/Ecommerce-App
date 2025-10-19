import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/core/function/alertexitapp.dart';
import 'package:ecommerce_app/core/function/validinput.dart';
import 'package:ecommerce_app/screens/auth/signup/controller/signup_controller.dart';
import 'package:ecommerce_app/screens/auth/widgets/custom_button_auth.dart';
import 'package:ecommerce_app/screens/auth/widgets/custom_text_body_auth.dart';
import 'package:ecommerce_app/screens/auth/widgets/custom_text_form_auth.dart';
import 'package:ecommerce_app/screens/auth/widgets/custom_text_signup_or_signin.dart';
import 'package:ecommerce_app/screens/auth/widgets/custom_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text("20".tr,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: AppColor.grey)),
        ),
        body: PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              alertExitApp(didPop);
            },
            child: GetBuilder<SignUpControllerImp>(
              builder: (controller) {
                return HandlingDataRequest(
                    statusRequest: controller.statusRequest,
                    widget: Padding(
                      padding: const EdgeInsets.only(right: 35, left: 35),
                      child: Form(
                        key: controller.formstate,
                        child: ListView(
                          children: [
                            const SizedBox(height: 40),
                            CustomTextTitleAuth(text: "27".tr),
                            const SizedBox(height: 15),
                            CustomTextBodyAuth(text: "25".tr),
                            const SizedBox(height: 35),
                            CustomTextFormAuth(
                              validator: (val) {
                                return validInput(val!, 3, 20, "username");
                              },
                              keyboardType: TextInputType.name,
                              controller: controller.username,
                              hintText: "22".tr,
                              icon: Icons.person_outline,
                              labelText: "21".tr,
                            ),
                            CustomTextFormAuth(
                              validator: (val) {
                                return validInput(val!, 5, 100, "email");
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.email,
                              hintText: "15".tr,
                              icon: Icons.email_outlined,
                              labelText: "14".tr,
                            ),
                            CustomTextFormAuth(
                              validator: (val) {
                                return validInput(val!, 3, 11, "phone");
                              },
                              keyboardType: TextInputType.phone,
                              controller: controller.phone,
                              hintText: "24".tr,
                              icon: Icons.phone_android_outlined,
                              labelText: "23".tr,
                            ),
                            GetBuilder<SignUpControllerImp>(
                                builder: (controller) {
                              return CustomTextFormAuth(
                                obscureText: controller.isshowpassword,
                                onTapIcon: controller.showPassword,
                                validator: (val) {
                                  return validInput(val!, 5, 30, "password");
                                },
                                keyboardType: TextInputType.visiblePassword,
                                controller: controller.password,
                                hintText: "17".tr,
                                icon: Icons.lock_outline,
                                labelText: "16".tr,
                              );
                            }),
                            const SizedBox(height: 50),
                            CustomButtonAuth(
                                text: "20".tr,
                                onPressed: () {
                                  controller.signUp();
                                }),
                            const SizedBox(height: 30),
                            CustomTextSignUpOrSignIn(
                              text1: "26".tr,
                              text2: "11".tr,
                              onTap: () {
                                controller.goToLogin();
                              },
                            )
                          ],
                        ),
                      ),
                    ));
              },
            )));
  }
}
