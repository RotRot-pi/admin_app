import 'package:admin_app/core/classes/request_status.dart';
import 'package:admin_app/core/functions/handing_data.dart';
import 'package:admin_app/data/datasource/remote/order/pending.dart';
import 'package:get/get.dart';

import '../../../../core/services/services.dart';
import '../../../../data/model/order.dart';

class PendingOrderController extends GetxController {
  PendingOrderData pendingOrderData = PendingOrderData(crud: Get.find());
  final AppServices _appServices = Get.find();
  List data = [];
  late RequestStatus requestStatus;
  getPendingData() async {
    data.clear();
    requestStatus = RequestStatus.loading;
    update();
    print("status1:$requestStatus");
    var response = await pendingOrderData.getData();
    //_appServices.sharedPreferences.getInt('id')!.toString()
    requestStatus = handelingData(response);
    print("status2:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response:$response ");

      for (var i = 0; i < response['data'].length; i++) {
        data.add(Order.fromJson(response['data'][i]));
      }
    } else {
      requestStatus = RequestStatus.failure;
    }
    update();
  }

  approveOrder(var userId, var orderId) async {
    requestStatus = RequestStatus.loading;
    update();
    print("status1:$requestStatus");
    print("userId:$userId");
    print("orderId:$orderId");
    print("ID: ${_appServices.sharedPreferences.getInt('id')!.toString()}");
    var response = await pendingOrderData.approveOrder(
        userId.toString(), orderId.toString());
    //_appServices.sharedPreferences.getInt('id')!.toString()
    requestStatus = handelingData(response);
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      getPendingData();
    } else {
      requestStatus = RequestStatus.failure;
    }
    update();
  }

  printOrderType(var orderType) {
    if (orderType == 0) {
      return 'Admin';
    } else {
      return 'Receive';
    }
  }

  printPaymentMethod(var paymentType) {
    if (paymentType == 0) {
      return 'Cash';
    } else if (paymentType == 1) {
      return 'Card';
    }
  }

  printOrderStatus(var orderStatus) {
    if (orderStatus == 0) {
      return 'Pending';
    } else if (orderStatus == 1) {
      return 'Approved';
    } else if (orderStatus == 2) {
      return 'Prepared';
    } else if (orderStatus == 3) {
      return 'On The Way';
    } else {
      return "Done";
    }
  }

  onNotificationRefresh() {
    getPendingData();
  }

  @override
  void onInit() {
    getPendingData();
    super.onInit();
  }
}
