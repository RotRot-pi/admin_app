import 'package:admin_app/core/classes/request_status.dart';
import 'package:admin_app/core/functions/handing_data.dart';
import 'package:admin_app/data/datasource/remote/order/accepted.dart';
import 'package:get/get.dart';

import '../../../../core/services/services.dart';
import '../../../../data/model/order.dart';

class AcceptedOrderController extends GetxController {
  AcceptedOrderData acceptedOrderData = AcceptedOrderData(crud: Get.find());
  final AppServices _appServices = Get.find();
  List data = [];
  late RequestStatus requestStatus;
  getAccetepedOrders() async {
    data.clear();
    requestStatus = RequestStatus.loading;
    update();
    print("status1:$requestStatus");
    var response = await acceptedOrderData.getData();
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

  orderPrepare(var userId, var orderId, var orderType) async {
    requestStatus = RequestStatus.loading;
    update();
    print("status1:$requestStatus");
    print("adminId:$userId");
    print("orderId:$orderId");
    print("orderType:$orderType");
    var response = await acceptedOrderData.orderPrepare(
        userId.toString(), orderId.toString(), orderType.toString());
    requestStatus = handelingData(response);
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      getAccetepedOrders();
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
      return 'Accepted';
    } else if (orderStatus == 2) {
      return 'Rejected';
    } else if (orderStatus == 3) {
      return 'Delivered';
    } else {
      return "Archived";
    }
  }

  onNotificationRefresh() {
    getAccetepedOrders();
  }

  @override
  void onInit() {
    getAccetepedOrders();
    super.onInit();
  }
}
