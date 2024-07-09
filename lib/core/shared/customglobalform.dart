import 'package:admin_app/core/constants/spaces.dart';
import 'package:admin_app/core/functions/validate_auth_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGlobalForm extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData? iconData;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FieldInputType? inputType;
  final bool? obscureText;
  final void Function()? onIconTap;
  const CustomGlobalForm({
    super.key,
    this.inputType,
    this.iconData,
    this.obscureText,
    this.onIconTap,
    required this.hinttext,
    required this.labeltext,
    required this.controller,
    required this.validator,
  });
  chooseInputType(FieldInputType? inputType) {
    switch (inputType) {
      case FieldInputType.email:
        return TextInputType.emailAddress;
      case FieldInputType.phone:
        return TextInputType.phone;
      case FieldInputType.password:
        return TextInputType.visiblePassword;
      case FieldInputType.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSpacing.addEdgeInsetsOnly(bottom: h20),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText ?? false,
        keyboardType: chooseInputType(inputType),
        decoration: InputDecoration(
            errorMaxLines: 3,
            hintText: hinttext,
            hintStyle: TextStyle(fontSize: s16.sp),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: AppSpacing.addEdgeInsetsSymmetric(
                vertical: p4, horizontal: p28),
            label: Container(
                margin: AppSpacing.addEdgeInsetsSymmetric(horizontal: m8),
                child: Text(
                  labeltext,
                  style: TextStyle(fontSize: s16.sp),
                )),
            suffixIcon: inputType == FieldInputType.password
                ? GestureDetector(
                    onTap: onIconTap,
                    child: obscureText == false
                        ? const Icon(Icons.lock_open_outlined)
                        : const Icon(Icons.lock_outlined),
                  )
                : Icon(iconData),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(r20))),
      ),
    );
  }
}