import 'package:admin_app/core/classes/crud.dart';
import 'package:admin_app/core/constants/api_link.dart';

class FavoriteData {
  final Crud crud;

  FavoriteData(this.crud);

  getData(var adminId) async {
    print("id from crud:$adminId");
    var response = await crud.post(ApiLink.favoriteView, {
      "admins_id": adminId.toString(),
    });
    print("FavoriteData");
    return response.fold((l) => l, (r) => r);
  }

  deleteData(var favoriteId) async {
    var response = await crud.post(ApiLink.deleteFavorite, {
      "favorite_id": favoriteId.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
