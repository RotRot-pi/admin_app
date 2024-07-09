import 'package:admin_app/core/classes/crud.dart';
import 'package:admin_app/core/constants/api_link.dart';

class FavoriteItemsData {
  final Crud crud;
  FavoriteItemsData(this.crud);

  addFavorite(var adminsId, var itemId) async {
    var response = await crud.post(ApiLink.addFavorite, {
      'admins_id': adminsId.toString(),
      'items_id': itemId.toString(),
    });
    print("FavoriteData");
    return response.fold((l) => l, (r) => r);
  }

  removeFavorite(var adminsId, var itemId) async {
    var response = await crud.post(ApiLink.removeFavorite, {
      'admins_id': adminsId.toString(),
      'items_id': itemId.toString(),
    });
    print("FavoriteData");
    return response.fold((l) => l, (r) => r);
  }
}
