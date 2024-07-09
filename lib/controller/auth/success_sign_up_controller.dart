import 'package:admin_app/core/constants/routes_name.dart';
import 'package:get/get.dart';

abstract class SuccessSignUpController extends GetxController {
  goToLogin();
}

class SuccessSignUpControllerImpl extends SuccessSignUpController {
  @override
  goToLogin() {
    Get.toNamed(AppRoutes.login);
  }
}
