import 'package:admin_app/controller/order/order_screen_controller.dart';
import 'package:admin_app/core/constants/spaces.dart';
import 'package:admin_app/view/widgets/home/cutombottomappbarbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CustomNavigationAppBar extends StatelessWidget {
  const CustomNavigationAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderScreenControllerImpl>(builder: (controller) {
      return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: m12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int index = 0; index < controller.pages.length; index++) ...[
              Flexible(
                child: CustomBottomAppBarButton(
                  onPressed: () => controller.changePage(index),
                  name: controller.bottomAppBarItems[index]['name'],
                  icon: controller.bottomAppBarItems[index]['icon'],
                  isActive: controller.isPageActive(index),
                ),
              ),
              // if (index == 1)
              //   const Spacer(), // Add a Spacer right after the second button
            ],
          ],
        ),
      );
    });
  }
}
