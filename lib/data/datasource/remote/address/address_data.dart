import '../../../../core/classes/crud.dart';

import 'package:get/get.dart';
import '../../../../core/constants/api_link.dart';

class AddressData {
  final Crud crud;

  AddressData(this.crud);

  getAddress(var adminId) async {
    var response = await crud.post(ApiLink.addressView, {
      "admin_id": adminId.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  addAddress(
      var adminId, var city, var street, var name, var long, var lat) async {
    var response = await crud.post(ApiLink.addAddress, {
      "admin_id": adminId.toString(),
      "city": city.toString(),
      "street": street.toString(),
      "name": name.toString(),
      "lat": lat.toString(),
      "long": long.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  deleteAddress(var addressId) async {
    var response = await crud.post(ApiLink.deleteAddress, {
      "address_id": addressId.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  updateAddress(
      var addressId, var city, var street, var name, var long, var lat) async {
    var response = await crud.post(ApiLink.updateAddress, {
      "address_id": addressId.toString(),
      "city": city.toString(),
      "street": street.toString(),
      "name": name.toString(),
      "lat": lat.toString(),
      "long": long.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
