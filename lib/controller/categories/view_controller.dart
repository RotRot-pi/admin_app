import 'package:admin_app/core/classes/request_status.dart';
import 'package:admin_app/core/constants/routes_name.dart';
import 'package:admin_app/core/functions/handing_data.dart';
import 'package:admin_app/data/datasource/remote/category.dart';
import 'package:admin_app/data/model/categories.dart';
import 'package:get/get.dart';

class ViewCategoryController extends GetxController {
  CategoryData viewData = CategoryData(crud: Get.find());
  List data = [];
  late RequestStatus requestStatus;
  getData() async {
    requestStatus = RequestStatus.loading;
    print("status1:$requestStatus");
    data.clear();
    var response = await viewData.getData();
    requestStatus = handelingData(response);
    print("status2:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response:$response ");
      for (var i in response['data']) {
        data.add(Category.fromMap(i));
      }
    } else {
      requestStatus;
    }
    update();
  }

  deleteCategoryDialog(var id, var image) {
    print("id:$id");
    print("image:$image");
    print("id type:${id.runtimeType}");
    print("image type:${image.runtimeType}");
    Get.defaultDialog(
      title: "warning".tr,
      middleText: "Are you Sure you want to delete this category",
      textConfirm: "Delete",
      textCancel: "Cancel",
      onConfirm: () {
        _deleteCategory(id, image);
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  _deleteCategory(var id, var image) async {
    await viewData.deleteData(id, image);
    data.removeWhere((element) => element.categoriesId == id);
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  goToHome() {
    Get.offAllNamed(AppRoutes.home);
  }

  goToEdit(Category category) {
    Get.toNamed(AppRoutes.editCategory, arguments: category);
  }
}
