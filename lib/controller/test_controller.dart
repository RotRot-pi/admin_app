import 'package:admin_app/core/classes/request_status.dart';
import 'package:admin_app/core/functions/handing_data.dart';
import 'package:admin_app/data/datasource/remote/test_data.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  TestData testData = TestData(crud: Get.find());
  List data = [];
  late RequestStatus requestStatus;
  getData() async {
    requestStatus = RequestStatus.loading;
    print("status1:$requestStatus");
    var response = await testData.getData();
    requestStatus = handelingData(response);
    print("status2:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response:$response ");

      data.addAll(response['data']);
    } else {
      requestStatus;
    }
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
