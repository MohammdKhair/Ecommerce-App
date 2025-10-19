import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';

class FavoriteData {
  Crud crud;
  FavoriteData(this.crud);
  viewFavorite(String userid) async {
    var response =
        await crud.postData(AppLinks.favoriteView, {"id": userid.toString()});
    return response.fold((l) => l, (r) => r);
  }

  deleteFavorite(String favoriteid) async {
    var response = await crud
        .postData(AppLinks.deletefromfavorite, {"id": favoriteid.toString()});
    return response.fold((l) => l, (r) => r);
  }

}
