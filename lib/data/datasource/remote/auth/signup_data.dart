import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';

class SignUpData {
  Crud crud;
  SignUpData(this.crud);
  postData(String username, String email, String password, String phone) async {
    var response = await crud.postData(AppLinks.signup, {
      "username": username,
      "email": email,
      "password": password,
      "phone": phone,
    });
    return response.fold((l) => l, (r) => r);
  }
}
