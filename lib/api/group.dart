import 'package:meow_travel_flutter/utils/request.dart';

class GroupApi {
  static saveOrUpdateGroup(data) {
    return Request().post(
      "/user/group/saveOrUpdateGroup",
      data: data,
    );
  }
}
