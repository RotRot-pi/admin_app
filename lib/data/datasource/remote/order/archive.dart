import 'package:admin_app/core/classes/crud.dart';

import 'package:admin_app/core/constants/api_link.dart';

class ArchiveOrderData {
  Crud crud;
  ArchiveOrderData({
    required this.crud,
  });

  getData() async {
    var response = await crud.post(ApiLink.viewArchiveOrder, {});
    print("ArchiveOrder");
    return response.fold((l) => l, (r) => r);
  }
}
