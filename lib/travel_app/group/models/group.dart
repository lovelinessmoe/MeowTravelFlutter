class Group {
  String? groupId;
  int? groupNum;
  String? groupName;
  String? groupImg;
  String? groupShortMsg;
  DateTime? createTime;
  bool? isOpenReport;
  int? nowNum;

  Group();

  Group.allArgs(this.groupId, this.groupNum, this.groupName, this.groupImg,
      this.groupShortMsg, this.createTime, this.isOpenReport, this.nowNum);

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group.allArgs(
      json["groupId"],
      json["groupNum"],
      json["groupName"],
      json["groupImg"],
      json["groupShortMsg"],
      DateTime.parse(json["createTime"]),
      json["isOpenReport"],
      json["nowNum"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "groupId": groupId,
      "groupNum": groupNum,
      "groupName": groupName,
      "groupImg": groupImg,
      "groupShortMsg": groupShortMsg,
      "creataTime": createTime?.toIso8601String(),
      "isOpenReport": isOpenReport,
      "nowNum": nowNum,
    };
  }

  @override
  String toString() {
    return 'Group{groupId: $groupId, groupNum: $groupNum, groupName: $groupName, groupImg: $groupImg, groupShortMsg: $groupShortMsg, createTime: $createTime, isOpenReport: $isOpenReport, nowNum: $nowNum}';
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
