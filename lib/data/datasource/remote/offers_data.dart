import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';

class OffersData {
  Crud crud;
  OffersData(this.crud);
  getData(String userid) async {
    var response = await crud.postData(AppLinks.offers, {"userid" : userid});
    return response.fold((l) => l, (r) => r);
  }

  addFavorite(String userid, String itemid) async {
    var response = await crud
        .postData(AppLinks.favoriteAdd, {"userid": userid, "itemid": itemid});
    return response.fold((l) => l, (r) => r);
  }

  removeFavorite(String userid, String itemid) async {
    var response = await crud.postData(
        AppLinks.favoriteRemove, {"userid": userid, "itemid": itemid});
    return response.fold((l) => l, (r) => r);
  }
}
