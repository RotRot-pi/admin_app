import 'dart:io';

import 'package:admin_app/controller/categories/view_controller.dart';
import 'package:admin_app/core/classes/request_status.dart';
import 'package:admin_app/core/constants/routes_name.dart';
import 'package:admin_app/core/functions/handing_data.dart';
import 'package:admin_app/core/shared/file_upload.dart';
import 'package:admin_app/data/datasource/remote/category.dart';
import 'package:admin_app/data/model/categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryController extends GetxController {
  CategoryData viewData = CategoryData(crud: Get.find());
  List data = [];
  File? image;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var categoriesId;
  var categoriesOldImage;
  late TextEditingController nameController;
  late TextEditingController nameArController;
  late RequestStatus requestStatus;
  editData() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    requestStatus = RequestStatus.loading;
    print("status1:$requestStatus");
    var response = await viewData.editData({
      "category_id": categoriesId.toString(),
      "category_name": nameController.text,
      "category_name_ar": nameArController.text,
      "old_image": categoriesOldImage
    }, image);
    requestStatus = handelingData(response);
    print("status2:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response:$response ");

      Get.offNamed(AppRoutes.viewCategory);
      ViewCategoryController c = Get.find();
      c.getData();
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          message: "Edit Failed",
        ),
      );
    }

    update();
  }

  // pickImage(var source) async {
  //   //show dialoge to choose camera or galary

  //   //editing from gaglery or camera
  //   if (source == "camera") {
  //     ImagePicker picker = ImagePicker();
  //     image = await picker.pickImage(source: ImageSource.camera);
  //     if (image != null) {
  //       image = File(image!.path) as XFile?;
  //     }
  //     update();
  //   } else {
  //     //edit image from gallery
  //     ImagePicker picker = ImagePicker();
  //     image = await picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       image = XFile(image!.path);
  //     }
  //     update();
  //   }
  // }

  chooseSource() async {
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    image = await imageUploadFromCamera();
                  },
                  child: const Text('Camera'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      image = await fileUploadFromGalary();
                    },
                    child: const Text('Gallery'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    requestStatus = RequestStatus.notInitialized;
    nameController = TextEditingController();
    nameArController = TextEditingController();
    Category category = Get.arguments;
    categoriesId = category.categoriesId;
    categoriesOldImage = category.categoriesImage;
    nameController.text = category.categoriesName;
    nameArController.text = category.categoriesNameAr;
    super.onInit();
  }
}
