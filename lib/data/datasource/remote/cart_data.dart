import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';

class CartData {
  Crud crud;
  CartData(this.crud);
  addCart(String userid, String itemid) async {
    var response = await crud
        .postData(AppLinks.cartAdd, {"userid": userid, "itemid": itemid});
    return response.fold((l) => l, (r) => r);
  }

  deleteCart(String userid, String itemid) async {
    var response = await crud
        .postData(AppLinks.cartDelete, {"userid": userid, "itemid": itemid});
    return response.fold((l) => l, (r) => r);
  }

  getCountCart(String userid, String itemid) async {
    var response = await crud
        .postData(AppLinks.cartGetCount, {"userid": userid, "itemid": itemid});
    return response.fold((l) => l, (r) => r);
  }

  viewCart(String userid) async {
    var response = await crud.postData(AppLinks.cartView, {"userid": userid});
    return response.fold((l) => l, (r) => r);
  }

  checkCoupon(String couponname) async {
    var response =
        await crud.postData(AppLinks.checkCoupon, {"couponname": couponname
        });
    return response.fold((l) => l, (r) => r);
  }
}
