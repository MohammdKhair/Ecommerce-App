import 'package:ecommerce_app/core/class/handling_data_view.dart';
import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/screens/auth/verifycode_signup/controller/verifycodesignup_controller.dart';
import 'package:ecommerce_app/screens/auth/widgets/custom_text_body_auth.dart';
import 'package:ecommerce_app/screens/auth/widgets/custom_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerifyCodeSignUp extends StatelessWidget {
  const VerifyCodeSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeSignUpControllerImp());
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text("31".tr,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: AppColor.grey)),
        ),
        body: GetBuilder<VerifyCodeSignUpControllerImp>(
          builder: (controller) {
            return HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: Padding(
                  padding: const EdgeInsets.only(right: 35, left: 35),
                  child: ListView(
                    children: [
                      const SizedBox(height: 30),
                      CustomTextTitleAuth(text: "37".tr),
                      const SizedBox(height: 15),
                      CustomTextBodyAuth(
                          text: "${"32".tr} ${controller.email}"),
                      const SizedBox(height: 10),
                      OtpTextField(
                        fieldWidth: 50,
                        borderRadius: BorderRadius.circular(15),
                        numberOfFields: 5,
                        borderColor: const Color(0xFF512DA8),
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) {
                          controller.goToSuccessSignUp(verificationCode);
                        },
                      ),
                      const SizedBox(height: 40),
                      InkWell(
                        onTap: () {
                          controller.reSend();
                        },
                        child: const Center(
                            child: Text("Resend verfiy code",
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 22))),
                      )
                    ],
                  ),
                ));
          },
        ));
  }
}
