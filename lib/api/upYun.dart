import 'package:dio/dio.dart';
import 'package:meow_travel_flutter/utils/request.dart';

class UpYun {
  static upLoadFile(uri, filePath, fileName) async {
    var multipartFile =
        await MultipartFile.fromFile(filePath, filename: fileName);
    var data = FormData.fromMap({"uri": uri});
    var mapEntry = MapEntry("file", multipartFile);
    data.files.add(mapEntry);

    return Request().post("/user/upYun/uploadFile",
        data: data, options: Options(contentType: 'multipart/form-data'));
  }
}
