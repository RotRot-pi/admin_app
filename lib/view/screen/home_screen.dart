// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_app/controller/home_controller.dart';
import 'package:admin_app/core/constants/api_link.dart';
import 'package:admin_app/core/constants/colors.dart';
import 'package:admin_app/core/constants/image_assets.dart';
import 'package:admin_app/core/constants/routes_name.dart';
import 'package:admin_app/view/widgets/handeling_data_view.dart';
import 'package:admin_app/view/widgets/home/adminhomecard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImpl());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          titleTextStyle: TextStyle(
            color: AppColors.whiteTextColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "PlayfairDisplay",
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        //To make a widget responsive for different screen sizes
        // ScreenTypeLayout(
        //   mobile: const SizedBox(),
        //   tablet: const SizedBox(),
        // ),
        body: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //To make the Layout for different screen sizes
                crossAxisCount: getValueForScreenType<int>(
                  context: context,
                  mobile: 3,
                  tablet: 4,
                  desktop: 5,
                ),
                mainAxisExtent: 150.h),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              AdminHomeCard(
                image: AppImageAssets.avatarImage,
                title: "Users",
                onTap: () {},
              ),
              AdminHomeCard(
                image: AppImageAssets.notificationBell,
                title: "Notifcations",
                onTap: () {},
              ),
              AdminHomeCard(
                image: AppImageAssets.mailEnvelopeWithAlert,
                title: "Messages",
                onTap: () {},
              ),
              AdminHomeCard(
                image: AppImageAssets.orders,
                title: "Orders",
                onTap: () => Get.toNamed(AppRoutes.order),
              ),
              AdminHomeCard(
                image: AppImageAssets.categories,
                title: "Categoies",
                onTap: () => Get.toNamed(AppRoutes.viewCategory),
              ),
              AdminHomeCard(
                image: AppImageAssets.items,
                title: "Items",
                onTap: () => Get.toNamed(AppRoutes.viewItems),
              ),
            ]));
  }
}
