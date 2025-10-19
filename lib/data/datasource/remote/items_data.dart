import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';

class ItemsData {
  Crud crud;
  ItemsData(this.crud);
  getData(String id, String userid) async {
    var response =
        await crud.postData(AppLinks.items, {"id": id, "userid": userid});
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
