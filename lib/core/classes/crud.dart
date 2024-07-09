import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:admin_app/core/classes/request_status.dart';
import 'package:admin_app/core/functions/check_internet.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

//Enhanced version of the code
//
//
// class Crud {
//   Future<Either<RequestStatus, T>> post<T>(
//       String urlLink, Map data, T Function(Map) fromJson) async {
//     try {
//       if (!await checkInternet()) {
//         return const Left(RequestStatus.offline);
//       }

//       var response = await http.post(
//         Uri.parse(urlLink),
//         body: jsonEncode(data),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         try {
//           var responseBody = jsonDecode(response.body);
//           return Right(fromJson(responseBody));
//         } on FormatException {
//           return const Left(RequestStatus.formatError);
//         }
//       } else {
//         return const Left(RequestStatus.serverError);
//       }
//     } catch (e) {
//       // Log the exception, e.g., using print or a logging package
//       print('Exception during POST request: $e');
//       return const Left(RequestStatus.unknownError);
//     }
//   }
// }

//My version of the code
//
//

String _basicAuth =
    "Basic ${base64.encode(utf8.encode("dddd:sdfsdfsdfsdfdsf"))}";
Map<String, String> _header = {"authorization": _basicAuth};

class Crud {
  Future<Either<RequestStatus, Map>> post(String urlLink, Map data) async {
    try {
      if (!await checkInternet()) {
        print('check internet');
        return const Left(RequestStatus.offline);
      }
      var response = await http.post(

          //Note: some error requires you to use Uri.https() or Uri.http()
          Uri.parse(
            urlLink,
          ),
          body: data);
      print("response in crud:${response.statusCode}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("response.statusCode:${response.statusCode}");
        try {
          print("response.body:${response.body}");
          //NOTE: I got a format error because the body was empty
          //      So I used the conditional statement inside jsonDecode
          var responseBody =
              jsonDecode(response.body.isNotEmpty ? response.body : "{}");
          print("CRUD:$responseBody");
          return Right(responseBody);
        } on FormatException catch (e) {
          print("response.message:${e.message}");
          return const Left(RequestStatus.formatError);
        }
      } else {
        return const Left(RequestStatus.serverError);
      }
    } catch (e) {
      print("Error in crud:$e");
      return const Left(RequestStatus.unknownError);
    }
  }

  Future<Either<RequestStatus, Map>> addRequestWithImageOne(
      url, data, File? image,
      [String? namerequest]) async {
    if (namerequest == null) {
      namerequest = "image";
    }

    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(_header);

    if (image != null) {
      var length = await image.length();
      var stream = http.ByteStream(image.openRead());
      stream.cast();
      var multipartFile = http.MultipartFile(namerequest, stream, length,
          filename: basename(image.path));
      request.files.add(multipartFile);
    }

    // add Data to request
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    // add Data to request
    // Send Request
    var myrequest = await request.send();
    // For get Response Body
    var response = await http.Response.fromStream(myrequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      Map responsebody = jsonDecode(response.body);
      return Right(responsebody);
    } else {
      return const Left(RequestStatus.serverError);
    }
  }
}
