import 'package:admin_app/core/classes/crud.dart';

import 'package:admin_app/core/constants/api_link.dart';

class ResetPasswordData {
  Crud crud;
  ResetPasswordData({
    required this.crud,
  });

  postData(String email, String password) async {
    var response = await crud
        .post(ApiLink.resetPassword, {"email": email, "password": password});

    return response.fold((l) => l, (r) => r);
  }
}
