import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';

class OrdersArchiveData {
  Crud crud;
  OrdersArchiveData(this.crud);
  getAllData(String usersid) async {
    var response =
        await crud.postData(AppLinks.ordersArchive, {"usersid": usersid});
    return response.fold((l) => l, (r) => r);
  }

  rating(String ordersid, String rating, String comment) async {
    var response = await crud.postData(AppLinks.ordersRating,
        {"ordersid": ordersid, "rating": rating, "comment": comment});
    return response.fold((l) => l, (r) => r);
  }
}
