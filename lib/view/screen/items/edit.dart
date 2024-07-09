import 'package:admin_app/controller/items/edit_controller.dart';
import 'package:admin_app/core/constants/spaces.dart';
import 'package:admin_app/core/functions/validate_auth_inputs.dart';
import 'package:admin_app/core/shared/customdropdownsearch.dart';
import 'package:admin_app/core/shared/customglobalform.dart';
import 'package:admin_app/view/widgets/handeling_data_view.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditItemScreen extends StatelessWidget {
  const EditItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditItemController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Item"),
          centerTitle: true,
        ),
        body: Padding(
          padding: AppSpacing.addEdgeInsetsAll(p24),
          child: GetBuilder<EditItemController>(builder: (controller) {
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
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                                value: "1",
                                groupValue: controller.activeController.text,
                                title: const Text("Visible"),
                                // subtitle: const Text("Item is visible"),
                                onChanged: (val) {
                                  controller.isActive(val);
                                }),
                          ),
                          Expanded(
                            child: RadioListTile(
                                value: "0",
                                groupValue: controller.activeController.text,
                                title: const Text("Hidden"),
                                // subtitle: const Text("Item is hidden"),
                                onChanged: (val) {
                                  controller.isActive(val);
                                }),
                          ),
                        ],
                      ),
                      AppSpacing.addHeigh(h24),
                      CustomDropDownSearch(
                          title: "Choose Category",
                          listData: controller.dropDownCategories,
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
                          onPressed: () => controller.editData(),
                          child: const Text("Save"))
                    ],
                  ),
                ));
          }),
        ));
  }
}
