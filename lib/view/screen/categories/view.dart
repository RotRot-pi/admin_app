import 'package:admin_app/controller/categories/view_controller.dart';
import 'package:admin_app/core/constants/api_link.dart';
import 'package:admin_app/core/constants/colors.dart';
import 'package:admin_app/core/constants/routes_name.dart';
import 'package:admin_app/core/constants/spaces.dart';
import 'package:admin_app/data/model/categories.dart';
import 'package:admin_app/view/widgets/handeling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class ViewCategoryScreen extends StatelessWidget {
  const ViewCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewCategoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        centerTitle: true,
      ),
      body: Padding(
        padding: AppSpacing.addEdgeInsetsAll(p24),
        child: GetBuilder<ViewCategoryController>(
          builder: (controller) {
            return HandelingDataView(
              requestStatus: controller.requestStatus,
              child: PopScope(
                onPopInvoked: (didPop) => controller.goToHome(),
                canPop: false,
                child: ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      Category category = controller.data[index];
                      return CategoyWidget(
                          category: category, controller: controller);
                    }),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addCategory),
        shape: const CircleBorder(),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

//Build a custom widget for the viewing the category

class CategoyWidget extends StatelessWidget {
  final Category category;
  final ViewCategoryController controller;
  const CategoyWidget(
      {super.key, required this.category, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whiteTextColor,
      ),
      child: Card(
        color: AppColors.whiteTextColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                  child: SvgPicture.network(
                      height: 40,
                      "${ApiLink.categoriesImageFolder}${category.categoriesImage}")),
              AppSpacing.addWidth(w16),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.categoriesName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      Jiffy.parse(category.categoriesDatetime)
                          .format(pattern: "yyyy-MM-dd"),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              AppSpacing.addWidth(w16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        controller.goToEdit(category);
                      },
                      icon: const Icon(Icons.edit_outlined)),
                  IconButton(
                      onPressed: () {
                        controller.deleteCategoryDialog(
                            category.categoriesId, category.categoriesImage);
                      },
                      icon: const Icon(Icons.delete_outline)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
