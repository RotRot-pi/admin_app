import 'dart:developer';

import 'package:admin_app/core/classes/request_status.dart';
import 'package:admin_app/core/constants/routes_name.dart';
import 'package:admin_app/core/functions/handing_data.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/data/datasource/remote/auth/login_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LogInController extends GetxController {
  logIn();
  goToSignUp();
  goToForgetPassword();
  goToHomePage();
  showPassword();
}

class LogInControllerImpl extends LogInController {
  LoginData loginData = LoginData(crud: Get.find());
  final AppServices _appServices = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  RequestStatus requestStatus = RequestStatus.notInitialized;
  bool val = true;

  //TODO: make sure login logic work in case there is no admin
  @override
  logIn() async {
    if (formKey.currentState!.validate()) {
      print("=========Login is valid=========");
      requestStatus = RequestStatus.loading;
      update();
      var response = await loginData.postData(
        emailController.text,
        passwordController.text,
      );
      requestStatus = handelingData(response);
      print("requestStatus:$requestStatus");
      if (requestStatus == RequestStatus.success &&
          response['status'] == 'success') {
        var data = response['data'];
        if (data['admin_approve'] == 1) {
          _appServices.sharedPreferences
            ..setInt("id", data['admin_id'])
            ..setString('adminname', data['admin_name'])
            ..setString('email', data['admin_email'])
            ..setString('phone', data['admin_phone'])
            ..setInt('step', 2);
          _appServices.messaging.subscribeToTopic("admins");
          _appServices.messaging.subscribeToTopic("admins${data['admin_id']}");

          goToHomePage();
        } else {
          Get.toNamed(AppRoutes.verifySignUpCode,
              arguments: {'email': emailController.text});
        }
      } else {
        Get.defaultDialog(
          title: "warning".tr,
          middleText: "admin_already_exist".tr,
        );
        requestStatus;
      }

      update();
    } else {
      print("=========SignUp is not valid=========");
    }
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoutes.signup);
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoutes.forgetPassword);
  }

  @override
  showPassword() {
    val == false ? val = true : val = false;
    update();
  }

  @override
  void onInit() async {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    //Note:I should request the persmission first
    //then get the token
    FirebaseMessaging.instance
      ..requestPermission()
      ..getToken().then((value) {
        print("token$value");
        String? token = value;
      });
    super.onInit();
  }

  @override
  void dispose() {
    print("Login fields Disposed");
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  goToHomePage() {
    Get.offNamed(AppRoutes.home);
  }
}
