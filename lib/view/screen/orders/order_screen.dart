import 'dart:io';

import 'package:admin_app/controller/order/order_screen_controller.dart';
import 'package:admin_app/view/widgets/home/cutombottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //TODO: Test this widget with and without ScreenUtil
    //TODO: Test Text size with and without sp
    //TODO: Test Text with and without FittedBox widget

    Get.put(OrderScreenControllerImpl());
    return GetBuilder<OrderScreenControllerImpl>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
        ),
        resizeToAvoidBottomInset: false,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => controller.goToCart(),
        //   shape: const CircleBorder(),
        //   backgroundColor: AppColors.secondaryColor,
        //   child:
        //       const Icon(Icons.shopping_basket_outlined, color: Colors.white),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomNavigationAppBar(),
        body: controller.pages[controller.currentPageIndex],
      );
    });
  }
}
