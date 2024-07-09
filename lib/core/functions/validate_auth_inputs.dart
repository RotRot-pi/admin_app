import 'package:get/get.dart';

enum FieldInputType { adminname, email, phone, password, number }

validateAuthInputs(String val, int max, int min, FieldInputType type) {
  if (val.isEmpty) {
    return "required field";
  }
  switch (type) {
    case FieldInputType.adminname:
      if (!GetUtils.isUsername(val)) return "Invalid adminname";
      break;
    case FieldInputType.email:
      if (!GetUtils.isEmail(val)) return "Invalid email";
      break;

    case FieldInputType.phone:
      if (!GetUtils.isPhoneNumber(val)) return "Invalid phone number";
      break;
    case FieldInputType.password:
      if (!val.contains(RegExp(r'[A-Z]')) ||
          !val.contains(RegExp(r'[a-z]')) ||
          !val.contains(RegExp(r'[0-9]'))) {
        return "Password must contain at least one uppercase letter one lowercase letter and one number";
      }
    case FieldInputType.number:
      if (!GetUtils.isNum(val)) return "Invalid number";
      break;
  }
  if (val.length < min) {
    return " minimum length is $min";
  }
  if (val.length > max) {
    return " maximum length is $max";
  }

  return null;
}

//Refactored and Shortened function 
//
// String? validateAuthInputs(String val, int max, int min, FieldInputType type) {
//   if (val.isEmpty) return "required field";
//   final Map<FieldInputType, bool Function(String)> validators = {
//     FieldInputType.adminname: GetUtils.isUsername,
//     FieldInputType.email: GetUtils.isEmail,
//     FieldInputType.phone: GetUtils.isPhoneNumber,
//     FieldInputType.password: (v) => RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).+$').hasMatch(v),
//   };
  
//   if (!validators[type]!(val)) {
//     return "Invalid ${type.name}";
//   } else if (val.length < min) {
//     return "Minimum length is $min";
//   } else if (val.length > max) {
//     return "Maximum length is $max";
//   }
//   return null; // Indicates validation passed
// }