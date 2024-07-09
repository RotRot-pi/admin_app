import 'package:admin_app/core/classes/crud.dart';

import 'package:admin_app/core/constants/api_link.dart';

class NotificationData {
  Crud crud;
  NotificationData({
    required this.crud,
  });

  getData(var adminId) async {
    var response = await crud
        .post(ApiLink.notificationView, {'admin_id': adminId.toString()});
    print("NotificationData");
    return response.fold((l) => l, (r) => r);
  }
}
