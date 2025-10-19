// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/function/handling_data.dart';
import 'package:get/get.dart';

import '../../../../data/datasource/remote/auth/verifycode_signup_data.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  reSend();
  goToSuccessSignUp(String verificationCode);
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  VerifyCodeSignUpData verifyCodeSignUpData = VerifyCodeSignUpData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  String? email;

  @override
  goToSuccessSignUp(String verificationCode) async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await verifyCodeSignUpData.postData(email!, verificationCode);
    print("====================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.offNamed(AppRoute.successSignUp);
      } else {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
            title: "Error", middleText: "Verify Code Not Correct");
      }
    }
    update();
  }

  @override
  reSend() {
    verifyCodeSignUpData.resendData(email!);
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }
}
