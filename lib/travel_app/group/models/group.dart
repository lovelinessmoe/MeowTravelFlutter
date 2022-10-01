import 'dart:convert';

class Group {
  String? groupId;
  int? groupNum;
  String? groupName;
  String? groupImg;
  String? groupShortMsg;
  DateTime? creataTime;
  bool? isOpenReport;
  List<GroupUser>? groupUser;

  Map<String, dynamic> toJson() {
    return {
      "groupId": groupId,
      "groupNum": groupNum,
      "groupName": groupName,
      "groupImg": groupImg,
      "groupShortMsg": groupShortMsg,
      "creataTime": creataTime?.toIso8601String(),
      "isOpenReport": isOpenReport,
      "groupUser": jsonEncode(groupUser),
    };
  }
}

class GroupUser {
  String? groupUserId;
  String? groupId;
  String? userId;
  bool? isLeader;
  DateTime? addTime;

  GroupUser(
      this.groupUserId, this.groupId, this.userId, this.isLeader, this.addTime);
}
