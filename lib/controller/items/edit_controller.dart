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
import 'package:admin_app/data/model/items.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditItemController extends GetxController {
  ItemData viewData = ItemData(crud: Get.find());
  List data = [];
  List<SelectedListItem> dropDownCategories = [];
  List<SelectedListItem> dropDownActive = [];
  late SelectedListItem selectedActive;
  File? image;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController nameArController;
  late TextEditingController descriptionController;
  late TextEditingController descriptionArController;
  late TextEditingController priceController;
  late TextEditingController discountController;
  late TextEditingController countController;
  late TextEditingController activeController;
  late TextEditingController oldImage;
  late TextEditingController categoryIdController;
  late TextEditingController categoryNameController;
  late RequestStatus requestStatus;

  editData() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    requestStatus = RequestStatus.loading;
    print("status1:$requestStatus");
    var response = await viewData.editData({
      "items_id": idController.text,
      "items_name": nameController.text,
      "items_name_ar": nameArController.text,
      "items_description": descriptionController.text,
      "items_description_ar": descriptionArController.text,
      "items_price": priceController.text,
      "items_discount": discountController.text,
      "items_count": countController.text,
      "items_active": activeController.text,
      "old_image": oldImage.text,
      "items_category": categoryIdController.text,
      "items_datetime":
          DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString(),
    }, image);
    requestStatus = handelingData(response);
    print("status2:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response:$response ");

      Get.offNamed(AppRoutes.viewItems);
      ViewItemController c = Get.find();
      c.getData();
    } else {
      Get.showSnackbar(const GetSnackBar(message: "Failed to Edit Item"));
    }

    update();
  }

  isActive(val) {
    activeController.text = val;
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
        dropDownCategories.add(SelectedListItem(
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
    Item item = Get.arguments;
    idController = TextEditingController(text: item.itemsId.toString());
    nameController = TextEditingController(text: item.itemsName);
    nameArController = TextEditingController(text: item.itemsNameAr);
    descriptionController = TextEditingController(text: item.itemsDescription);
    descriptionArController =
        TextEditingController(text: item.itemsDescriptionAr);
    priceController = TextEditingController(text: item.itemsPrice.toString());
    discountController =
        TextEditingController(text: item.itemsDiscount.toString());
    countController = TextEditingController(text: item.itemsCount.toString());
    activeController = TextEditingController(text: item.itemsActive.toString());
    oldImage = TextEditingController(text: item.itemsImage);
    categoryIdController =
        TextEditingController(text: item.itemsCategory.toString());
    categoryNameController =
        TextEditingController(text: item.itemsCategoryName);
    getCategories();
    super.onInit();
  }
}
