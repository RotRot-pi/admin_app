import 'package:admin_app/controller/items/add_controller.dart';
import 'package:admin_app/core/constants/spaces.dart';
import 'package:admin_app/core/functions/validate_auth_inputs.dart';
import 'package:admin_app/core/shared/customdropdownsearch.dart';
import 'package:admin_app/core/shared/customglobalform.dart';
import 'package:admin_app/view/widgets/handeling_data_view.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddItemController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Item"),
          centerTitle: true,
        ),
        body: Padding(
          padding: AppSpacing.addEdgeInsetsAll(p24),
          child: GetBuilder<AddItemController>(builder: (controller) {
            return HandelingDataView(
                requestStatus: controller.requestStatus,
                child: Form(
                  key: controller.formKey,
                  child: ListView(
                    children: [
                      AppSpacing.addHeigh(h24),
                      CustomGlobalForm(
                          hinttext: "Enter Item Name",
                          labeltext: "Item Name",
                          controller: controller.nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          }),
                      CustomGlobalForm(
                          hinttext: "Enter Item Name Arabic",
                          labeltext: "Item Name Arabic",
                          controller: controller.nameArController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          }),
                      CustomGlobalForm(
                          hinttext: "Enter Item Description",
                          labeltext: "Enter Item Description",
                          controller: controller.descriptionController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          }),
                      CustomGlobalForm(
                          hinttext: "Enter Item Description Arabic",
                          labeltext: "Enter Item Description Arabic",
                          controller: controller.descriptionArController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          }),
                      CustomGlobalForm(
                          hinttext: "Enter Item Price",
                          labeltext: "Item Price",
                          controller: controller.priceController,
                          inputType: FieldInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          }),
                      CustomGlobalForm(
                          hinttext: "Enter Item Discount",
                          labeltext: "Item Name Discount",
                          controller: controller.discountController,
                          inputType: FieldInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          }),
                      CustomGlobalForm(
                          hinttext: "Enter Item Count",
                          labeltext: "Item Count",
                          controller: controller.countController,
                          inputType: FieldInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          }),
                      // CustomGlobalForm(
                      //     hinttext: "Enter Item Category",
                      //     labeltext: "Item Category",
                      //     controller: controller.nameArController,
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return "Required";
                      //       }
                      //       return null;
                      //     }),
                      CustomDropDownSearch(
                          title: "Choose Category",
                          listData: controller.dropDownItems,
                          dropDownSelectedName:
                              controller.categoryNameController,
                          dropDownSelectedId: controller.categoryIdController),
                      AppSpacing.addHeigh(h24),
                      TextButton(
                          onPressed: () => controller.chooseSource(),
                          child: const Text("Pick Image")),
                      if (controller.image != null)
                        Image.file(controller.image!, height: 100, width: 100),
                      ElevatedButton(
                          onPressed: () => controller.addData(),
                          child: const Text("Add Item"))
                    ],
                  ),
                ));
          }),
        ));
  }
}
