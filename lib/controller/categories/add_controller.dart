import 'dart:io';

import 'package:admin_app/controller/categories/view_controller.dart';
import 'package:admin_app/core/classes/request_status.dart';
import 'package:admin_app/core/constants/routes_name.dart';
import 'package:admin_app/core/functions/handing_data.dart';
import 'package:admin_app/core/shared/file_upload.dart';
import 'package:admin_app/data/datasource/remote/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddCategoryController extends GetxController {
  CategoryData viewData = CategoryData(crud: Get.find());
  List data = [];
  File? image;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController nameArController;
  late RequestStatus requestStatus;
  addData() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (image == null) {
      Get.showSnackbar(const GetSnackBar(message: "Please Select SVG Image"));
    } else {
      requestStatus = RequestStatus.loading;
      print("status1:$requestStatus");
      var response = await viewData.addData({
        "category_name": nameController.text,
        "category_name_ar": nameArController.text,
      }, image!);
      requestStatus = handelingData(response);
      print("status2:$requestStatus");
      if (requestStatus == RequestStatus.success &&
          response['status'] == 'success') {
        print("response:$response ");

        Get.offNamed(AppRoutes.viewCategory);
        ViewCategoryController c = Get.find();
        c.getData();
      } else {
        requestStatus = RequestStatus.failure;
      }
    }

    update();
  }

  // pickImage(var source) async {
  //   //show dialoge to choose camera or galary

  //   //adding from gaglery or camera
  //   if (source == "camera") {
  //     ImagePicker picker = ImagePicker();
  //     image = await picker.pickImage(source: ImageSource.camera);
  //     if (image != null) {
  //       image = File(image!.path) as XFile?;
  //     }
  //     update();
  //   } else {
  //     //add image from gallery
  //     ImagePicker picker = ImagePicker();
  //     image = await picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       image = XFile(image!.path);
  //     }
  //     update();
  //   }
  // }

  chooseImage() async {
    image = await fileUploadFromGalary();
    update();
  }

  @override
  void onInit() {
    requestStatus = RequestStatus.notInitialized;
    nameController = TextEditingController();
    nameArController = TextEditingController();
    super.onInit();
  }
}
