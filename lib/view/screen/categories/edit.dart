import 'package:admin_app/controller/categories/edit_controller.dart';
import 'package:admin_app/core/constants/spaces.dart';
import 'package:admin_app/core/shared/customglobalform.dart';
import 'package:admin_app/view/widgets/handeling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditCategoryController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Category"),
          centerTitle: true,
        ),
        body: Padding(
          padding: AppSpacing.addEdgeInsetsAll(p24),
          child: GetBuilder<EditCategoryController>(builder: (controller) {
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
                          onPressed: () => controller.chooseSource(),
                          child: const Text("Pick Image")),
                      if (controller.image != null)
                        SvgPicture.file(controller.image!),
                      ElevatedButton(
                          onPressed: () => controller.editData(),
                          child: const Text("Save"))
                    ],
                  ),
                ));
          }),
        ));
  }
}
