// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_app/core/constants/spaces.dart';
import 'package:admin_app/core/functions/validate_auth_inputs.dart';

class CustomDropDownSearch extends StatefulWidget {
  final String? title;
  final List<SelectedListItem>? listData;
  final TextEditingController dropDownSelectedName;
  final TextEditingController dropDownSelectedId;
  const CustomDropDownSearch({
    Key? key,
    required this.title,
    required this.listData,
    required this.dropDownSelectedName,
    required this.dropDownSelectedId,
  }) : super(key: key);
  @override
  State<CustomDropDownSearch> createState() => _CustomDropDownSearchState();
}

class _CustomDropDownSearchState extends State<CustomDropDownSearch> {
  showMenu(BuildContext context) {
    DropDownState(
      DropDown(
        bottomSheetTitle: Text(
          "${widget.title}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.listData ?? [],
        selectedItems: (List<dynamic> selectedList) {
          print(selectedList);
          SelectedListItem selectedListItem = selectedList[0];
          widget.dropDownSelectedName.text = selectedListItem.name;
          widget.dropDownSelectedId.text = selectedListItem.value.toString();
          // List<String> list = [];
          // for (var item in selectedList) {
          //   if (item is SelectedListItem) {
          //     list.add(item.name);
          //   }
          // }
          // showSnackBar(list.toString());
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dropDownSelectedName,
      cursorColor: Colors.black,
      onTap: () {
        FocusScope.of(context).unfocus();
        showMenu(context);
      },
      showCursor: false,
      decoration: InputDecoration(
          errorMaxLines: 3,
          hintText: widget.dropDownSelectedName.text == ""
              ? widget.title
              : widget.dropDownSelectedName.text,
          hintStyle: TextStyle(fontSize: s16.sp),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              AppSpacing.addEdgeInsetsSymmetric(vertical: p4, horizontal: p28),
          label: Container(
              margin: AppSpacing.addEdgeInsetsSymmetric(horizontal: m8),
              child: Text(
                "${widget.title}",
                style: TextStyle(fontSize: s16.sp),
              )),
          suffixIcon: const Icon(Icons.arrow_drop_down_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(r20))),
    );
  }
}
