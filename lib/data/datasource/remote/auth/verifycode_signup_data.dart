import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';

class VerifyCodeSignUpData {
  Crud crud;
  VerifyCodeSignUpData(this.crud);
  postData(String email, String verifycode) async {
    var response = await crud.postData(AppLinks.verifycodesignup, {
      "email": email,
      "verifycode": verifycode,
    });
    return response.fold((l) => l, (r) => r);
  }

  resendData(String email) async {
    var response =
        await crud.postData(AppLinks.resend, {"email": email});
    return response.fold((l) => l, (r) => r);
  }
}
