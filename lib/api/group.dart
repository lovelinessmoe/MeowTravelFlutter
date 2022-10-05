import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:meow_travel_flutter/utils/request.dart';

class GroupApi {
  static saveOrUpdateGroup(data) {
    return Request().post(
      "/user/group/saveOrUpdateGroup",
      data: data,
    );
  }

  static getPageGroup(current, int? size, bool onlyShowMyJoin) {
    return Request().get(
      "/user/group/getPageGroup",
      params: {
        "current": current,
        "size": size ?? 10,
        "onlyShowMyJoin": onlyShowMyJoin
      },
    );
  }

  static joinGroup(String groupId) {
    return Request().post(
      "/user/group/joinGroup",
      params: {"groupId": groupId},
    );
  }

  static checkDaily(String groupId, BaiduLocation location) {
    return Request().post("/user/group/checkDaily", params: {
      "groupId": groupId,
    }, data: {
      "locationLat": location.latitude ?? "",
      "locationLng": location.longitude ?? ""
    });
  }

  static getMyGroup() {
    return Request().get(
      "/user/group/getMyGroup",
    );
  }

  static getGroupCheckInfo(String groupId) {
    return Request()
        .get("/user/group/getGroupCheckInfo", params: {"groupId": groupId});
  }
}
