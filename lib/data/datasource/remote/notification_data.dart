import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';

class NotificationData {
  Crud crud;
  NotificationData(this.crud);
  getAllData(String usersid) async {
    var response =
        await crud.postData(AppLinks.notification, {"usersid": usersid});
    return response.fold((l) => l, (r) => r);
  }
}
