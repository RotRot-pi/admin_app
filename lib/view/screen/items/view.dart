import 'package:admin_app/controller/items/view_controller.dart';
import 'package:admin_app/core/constants/api_link.dart';
import 'package:admin_app/core/constants/colors.dart';
import 'package:admin_app/core/constants/routes_name.dart';
import 'package:admin_app/core/constants/spaces.dart';
import 'package:admin_app/data/model/items.dart';
import 'package:admin_app/view/widgets/handeling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class ViewItemsScreen extends StatelessWidget {
  const ViewItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewItemController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item"),
        centerTitle: true,
      ),
      body: Padding(
        padding: AppSpacing.addEdgeInsetsAll(p24),
        child: GetBuilder<ViewItemController>(
          builder: (controller) {
            return HandelingDataView(
              requestStatus: controller.requestStatus,
              child: PopScope(
                onPopInvoked: (didPop) => controller.goToHome(),
                canPop: false,
                child: ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      Item item = controller.data[index];
                      return ItemWidget(item: item, controller: controller);
                    }),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addItems),
        shape: const CircleBorder(),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

//Build a custom widget for the viewing the item

class ItemWidget extends StatelessWidget {
  final Item item;
  final ViewItemController controller;
  const ItemWidget({super.key, required this.item, required this.controller});

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
                  flex: 4,
                  child: Image.network(
                    height: 40,
                    "${ApiLink.itemsImageFolder}${item.itemsImage}",
                  )),
              AppSpacing.addWidth(w16),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.itemsName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      // Jiffy.parse(item.itemsDatetime)
                      //     .format(pattern: "yyyy-MM-dd"),
                      "${item.itemsCategoryName}",
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
                        controller.goToEdit(item);
                      },
                      icon: const Icon(Icons.edit_outlined)),
                  IconButton(
                      onPressed: () {
                        controller.deleteItemDialog(
                            item.itemsId, item.itemsImage);
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
