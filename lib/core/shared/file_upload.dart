import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

imageUploadFromCamera() async {
  XFile? file = await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 90);
  if (file != null) {
    print("Success, path ${file.path}");
    return File(file.path);
  }
  return null;
}

fileUploadFromGalary([isSvg = false]) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions:
        isSvg ? ["svg", "SVG"] : ["jpg", "jpeg", "png", "PNG", "gif"],
  );
  if (result != null) {
    return File(result.files.single.path!);
  }
  return null;
}
