import 'package:dio/dio.dart';
import 'package:meow_travel_flutter/utils/request/request.dart';

class Auth {
  static login(data) {
    data["client_id"] = "meow_travel";
    data["client_secret"] = "123456";
    data["grant_type"] = "captcha";

    return Request().post("/auth/oauth/token",
        data: data,
        options: Options(contentType: 'application/x-www-form-urlencoded'));
  }

  static captcha() {
    return Request().post(
      "/user/auth/captcha",
    );
  }
}
