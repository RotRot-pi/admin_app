import 'package:admin_app/core/classes/request_status.dart';
import 'package:admin_app/core/constants/routes_name.dart';
import 'package:admin_app/core/functions/handing_data.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/data/datasource/remote/home_data.dart';
import 'package:admin_app/data/model/categories.dart';
import 'package:admin_app/data/model/items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeController extends SearchControllerMix {
  getData();
  initialData();
  goToItems(List categories, int categoryIndex, var categoryId);
  goToProductDetails(Item item);
}

class HomeControllerImpl extends HomeController {
  final AppServices _appServices = Get.find();
  HomeData homeData = HomeData(crud: Get.find());
  RequestStatus requestStatus = RequestStatus.notInitialized;
  late String username;
  late int id;
  late String language;
  String titleHomeCard = "";
  String descriptionHomeCard = "";
  String adminTime = "";

  List<Category> categories = [];
  List<Item> items = [];
  List homeCartSettings = [];

  @override
  getData() async {
    // await _appServices.sharedPreferences
    //   ..setInt("id", 124)
    //   ..setString('adminname', 'admin')
    //   ..setString('email', 'admin@gmail.com')
    //   ..setString('phone', '0123456789')
    //   ..setString('role', '0')
    //   ..setInt('step', 2);

    requestStatus = RequestStatus.loading;
    print("status1:$requestStatus");
    var response = await homeData.getData();
    requestStatus = handelingData(response);
    print("status2:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response:$response ");

      for (var element in response['categories']) {
        categories.add(Category.fromMap(element));
      }

      for (var element in response['itemsTopSellingView']) {
        items.add(Item.fromMap(element));
      }

      for (var element in response['home_cart_settings']) {
        homeCartSettings.add(element as Map);
      }
      titleHomeCard = homeCartSettings[0]['home_cart_settings_title'];
      descriptionHomeCard = homeCartSettings[0]['home_cart_settings_body'];
      adminTime = homeCartSettings[0]['admin_time'].toString();
      //adminTime: You can add it to shared preferences or wherever you want to save it
      _appServices.sharedPreferences.setString("adminTime", adminTime);
      print("homeCartSettings:${homeCartSettings}");
      print("categories:${categories}");
      print("items:${items}");
    } else {
      requestStatus = RequestStatus.failure;
    }

    update();
  }

  @override
  initialData() {
    id = _appServices.sharedPreferences.getInt("id")!;
    username = _appServices.sharedPreferences.getString("adminname")!;
    language = _appServices.sharedPreferences.getString("lang")!;

    print("Controller lang:$language");
  }

  @override
  goToItems(List categories, int categoryIndex, var categoryId) {
    Get.toNamed(AppRoutes.viewItems, arguments: {
      'categories': categories,
      'categoryIndex': categoryIndex,
      'categoryId': categoryId
    });
  }

  @override
  void onInit() {
    searchController = TextEditingController();
    initialData();
    getData();
    super.onInit();
  }

  @override
  goToProductDetails(Item item) {
    // TODO: implement goToProductDetails
    throw UnimplementedError();
  }
}

class SearchControllerMix extends GetxController {
  HomeData homeData = HomeData(crud: Get.find());
  late TextEditingController searchController;
  RequestStatus requestStatus = RequestStatus.notInitialized;
  bool isSeaching = false;
  List searchedItems = [];

  isSearching(String value) {
    print("Value:$value");
    if (value.isEmpty || value == "") {
      requestStatus = RequestStatus.notInitialized;
      isSeaching = false;
    }
    update();
  }

  onItemsSearch() {
    isSeaching = true;
    update();
    searchItems();
    update();
  }

  searchItems() async {
    searchedItems.clear();
    if (searchController.text.isEmpty) {
      return;
    }
    requestStatus = RequestStatus.loading;
    print("status1:$requestStatus");
    var response = await homeData.searchData(searchController.text);

    requestStatus = handelingData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        response['data'].forEach((element) {
          searchedItems.add(Item.fromMap(element));
        });

        print("searchedItems:${searchedItems}");
      } else {
        requestStatus = RequestStatus.failure;
      }
    }
    update();
  }

  // goToProductDetails(Item item) {
  //   Get.toNamed(AppRoutes.productDetails, arguments: {'item': item});
  // }

  @override
  void onInit() {
    super.onInit();
  }
}
