import 'dart:io';

import 'package:admin_app/core/classes/crud.dart';

import 'package:admin_app/core/constants/api_link.dart';

class ItemData {
  Crud crud;
  ItemData({
    required this.crud,
  });

  getData() async {
    var response = await crud.post(ApiLink.viewItems, {});
    print("ItemData");
    return response.fold((l) => l, (r) => r);
  }

  deleteData(var itemId, var image) async {
    var response = await crud.post(
        ApiLink.deleteItems, {"items_id": itemId.toString(), 'image': image});

    return response.fold((l) => l, (r) => r);
  }

  addData(Map data, File image) async {
    var response =
        await crud.addRequestWithImageOne(ApiLink.addItems, data, image);

    return response.fold((l) => l, (r) => r);
  }

  editData(Map data, [File? image]) async {
    var response;

    if (image == null) {
      response = await crud.post(ApiLink.editItems, data);
    } else {
      response =
          await crud.addRequestWithImageOne(ApiLink.editItems, data, image);
    }

    return response.fold((l) => l, (r) => r);
  }
}
