import 'package:admin_app/core/classes/crud.dart';
import 'package:admin_app/core/constants/api_link.dart';

class CartData {
  Crud crud;
  CartData(this.crud);
  addCart(var adminsid, var itemsid, int? count) async {
    var response = await crud.post(ApiLink.addCart, {
      "admin_id": adminsid.toString(),
      "item_id": itemsid.toString(),
      "item_count": count.toString()
    });
    return response.fold((l) => l, (r) => r);
  }

  deleteCart(var adminsid, var itemsid, int? count) async {
    var response = await crud.post(ApiLink.deleteCart, {
      "admin_id": adminsid.toString(),
      "item_id": itemsid.toString(),
      "item_count": count.toString()
    });
    return response.fold((l) => l, (r) => r);
  }

  getCountCart(var adminsid, var itemsid) async {
    var response = await crud.post(ApiLink.getCountCart,
        {"admin_id": adminsid.toString(), "item_id": itemsid.toString()});
    return response.fold((l) => l, (r) => r);
  }

  viewCart(var adminsid) async {
    var response = await crud.post(ApiLink.cartView, {
      "admin_id": adminsid.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  checkCoupon(var couponName) async {
    var response = await crud.post(ApiLink.checkCoupon, {
      "coupon_name": couponName.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
