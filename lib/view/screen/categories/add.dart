import 'package:admin_app/controller/categories/add_controller.dart';
import 'package:admin_app/core/constants/spaces.dart';
import 'package:admin_app/core/shared/customglobalform.dart';
import 'package:admin_app/view/widgets/handeling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddCategoryController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Category"),
          centerTitle: true,
        ),
        body: Padding(
          padding: AppSpacing.addEdgeInsetsAll(p24),
          child: GetBuilder<AddCategoryController>(builder: (controller) {
            return HandelingDataView(
                requestStatus: controller.requestStatus,
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CustomGlobalForm(
                          hinttext: "Enter Category Name",
                          labeltext: "Category Name",
                          controller: controller.nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          }),
                      CustomGlobalForm(
                          hinttext: "Enter Category Name Arabic",
                          labeltext: "Category Name Arabic",
                          controller: controller.nameArController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      TextButton(
                          onPressed: () => controller.chooseImage(),
                          child: const Text("Pick Image")),
                      if (controller.image != null)
                        SvgPicture.file(controller.image!),
                      ElevatedButton(
                          onPressed: () => controller.addData(),
                          child: const Text("Add Category"))
                    ],
                  ),
                ));
          }),
        ));
  }
}
