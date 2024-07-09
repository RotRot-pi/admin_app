import 'package:admin_app/core/constants/routes_name.dart';
import 'package:get/get.dart';

abstract class SuccessPasswordResetController extends GetxController {
  goToLogin();
}

class SuccessPasswordResetControllerImpl
    extends SuccessPasswordResetController {
  @override
  goToLogin() {
    Get.toNamed(AppRoutes.login);
  }
}
