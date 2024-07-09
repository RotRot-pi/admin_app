import 'package:admin_app/core/classes/crud.dart';

import 'package:admin_app/core/constants/api_link.dart';

class AcceptedOrderData {
  Crud crud;
  AcceptedOrderData({
    required this.crud,
  });

  getData() async {
    var response = await crud.post(ApiLink.viewAcceptedOrder, {});
    print("AccetepedOrders");
    return response.fold((l) => l, (r) => r);
  }

  orderPrepare(var userId, var orderId, var orderType) async {
    var response = await crud.post(ApiLink.orderPrepare,
        {'user_id': userId, 'order_id': orderId, 'order_type': orderType});
    print("AccetepedOrder");
    return response.fold((l) => l, (r) => r);
  }
}
