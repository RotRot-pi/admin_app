import 'dart:io';

import 'package:admin_app/core/classes/crud.dart';

import 'package:admin_app/core/constants/api_link.dart';
import 'package:image_picker/image_picker.dart';

class CategoryData {
  Crud crud;
  CategoryData({
    required this.crud,
  });

  getData() async {
    var response = await crud.post(ApiLink.viewCategory, {});
    return response.fold((l) => l, (r) => r);
  }

  addData(Map data, File image) async {
    var response =
        await crud.addRequestWithImageOne(ApiLink.addCategory, data, image);

    return response.fold((l) => l, (r) => r);
  }

  editData(Map data, [File? image]) async {
    var response;

    if (image == null) {
      response = await crud.post(ApiLink.editCategory, data);
    } else {
      response =
          await crud.addRequestWithImageOne(ApiLink.editCategory, data, image);
    }

    return response.fold((l) => l, (r) => r);
  }

  deleteData(var categoryId, var image) async {
    var response = await crud.post(ApiLink.deleteCategory,
        {"category_id": categoryId.toString(), 'image': image});

    return response.fold((l) => l, (r) => r);
  }
}
