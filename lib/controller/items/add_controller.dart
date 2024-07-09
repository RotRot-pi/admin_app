import 'dart:io';

import 'package:admin_app/controller/items/view_controller.dart';
import 'package:admin_app/core/classes/request_status.dart';
import 'package:admin_app/core/constants/routes_name.dart';
import 'package:admin_app/core/constants/spaces.dart';
import 'package:admin_app/core/functions/handing_data.dart';
import 'package:admin_app/core/shared/file_upload.dart';
import 'package:admin_app/data/datasource/remote/category.dart';
import 'package:admin_app/data/datasource/remote/item_data.dart';
import 'package:admin_app/data/model/categories.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddItemController extends GetxController {
  ItemData viewData = ItemData(crud: Get.find());
  List data = [];
  List<SelectedListItem> dropDownItems = [];
  File? image;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController nameArController;
  late TextEditingController descriptionController;
  late TextEditingController descriptionArController;
  late TextEditingController priceController;
  late TextEditingController discountController;
  late TextEditingController countController;
  late TextEditingController categoryIdController;
  late TextEditingController categoryNameController;
  late RequestStatus requestStatus;
  addData() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (image == null) {
      Get.showSnackbar(const GetSnackBar(message: "Please Select Image"));
    } else {
      requestStatus = RequestStatus.loading;
      print("status1:$requestStatus");
      var response = await viewData.addData({
        "items_name": nameController.text,
        "items_name_ar": nameArController.text,
        "items_description": descriptionController.text,
        "items_description_ar": descriptionArController.text,
        "items_price": priceController.text,
        "items_discount": discountController.text,
        "items_count": countController.text,
        "items_category": categoryIdController.text,
        "items_datetime":
            DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString(),
      }, image!);
      requestStatus = handelingData(response);
      print("status2:$requestStatus");
      if (requestStatus == RequestStatus.success &&
          response['status'] == 'success') {
        print("response:$response ");

        Get.offNamed(AppRoutes.viewItems);
        ViewItemController c = Get.find();
        c.getData();
      } else {
        Get.showSnackbar(const GetSnackBar(message: "Failed to Add Item"));
      }
    }

    update();
  }

  getCategories() async {
    List categories = [];
    CategoryData categoryData = CategoryData(crud: Get.find());
    var response = await categoryData.getData();
    requestStatus = handelingData(response);
    print("status2:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response:$response ");
      categories = response['data'];
      for (var i in categories) {
        dropDownItems.add(SelectedListItem(
          name: Category.fromMap(i).categoriesName,
          value: Category.fromMap(i).categoriesId.toString(),
        ));
      }
    } else {
      requestStatus;
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

  chooseSource() async {
    await Get.bottomSheet(Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: AppSpacing.addEdgeInsetsAll(p12),
            child: const Text('Choose Image Source'),
          ),
          const Divider(),
          Padding(
            padding: AppSpacing.addEdgeInsetsAll(p12),
            child: GestureDetector(
              onTap: () async {
                image = await imageUploadFromCamera();
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(Icons.image),
                  AppSpacing.addWidth(w12),
                  const Text('Camera'),
                ],
              ),
            ),
          ),
          Padding(
            padding: AppSpacing.addEdgeInsetsAll(p12),
            child: GestureDetector(
              onTap: () async {
                image = await fileUploadFromGalary(false);
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(Icons.camera_alt),
                  AppSpacing.addWidth(w12),
                  const Text('Gallery'),
                ],
              ),
            ),
          ),
        ],
      ),
    ));

    update();
  }

  @override
  void onInit() {
    requestStatus = RequestStatus.notInitialized;
    nameController = TextEditingController();
    nameArController = TextEditingController();
    descriptionController = TextEditingController();
    descriptionArController = TextEditingController();
    priceController = TextEditingController();
    discountController = TextEditingController();
    countController = TextEditingController();
    categoryIdController = TextEditingController();
    categoryNameController = TextEditingController();
    getCategories();
    super.onInit();
  }
}
