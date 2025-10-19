import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';

class OrdersPendingData {
  Crud crud;
  OrdersPendingData(this.crud);
  getAllData(String usersid) async {
    var response =
        await crud.postData(AppLinks.ordersPending, {"usersid": usersid});
    return response.fold((l) => l, (r) => r);
  }

  deleteData(String orderid) async {
    var response =
        await crud.postData(AppLinks.ordersDelete, {"orderid": orderid});
    return response.fold((l) => l, (r) => r);
  }
}
