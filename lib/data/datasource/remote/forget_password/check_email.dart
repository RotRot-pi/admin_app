import 'package:admin_app/core/classes/crud.dart';

import 'package:admin_app/core/constants/api_link.dart';

class CheckEmailData {
  Crud crud;
  CheckEmailData({
    required this.crud,
  });

  postData(String email) async {
    var response = await crud.post(ApiLink.checkemail, {"email": email});

    return response.fold((l) => l, (r) => r);
  }
}
