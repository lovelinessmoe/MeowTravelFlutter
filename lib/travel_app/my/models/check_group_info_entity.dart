
class CheckGroupInfoEntity {

	String? userId;
	String? userName;
	String? telephone;
	String? email;
	String? avatarUrl;
	DateTime? addTime;
	bool? isLeader;
	double? locationLat;
	double? locationLng;
	String? reportTime;


	CheckGroupInfoEntity();

  CheckGroupInfoEntity.allArgs(
      this.userId,
      this.userName,
      this.telephone,
      this.email,
      this.avatarUrl,
      this.addTime,
      this.isLeader,
      this.locationLat,
			this.locationLng,
      this.reportTime);

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userName": userName,
      "telephone": telephone,
      "email": email,
      "avatarUrl": avatarUrl,
      "addTime": addTime,
      "isLeader": isLeader,
      "locationLat": locationLat,
      "locationLng": locationLng,
      "reportTime": reportTime,
    };
  }

	factory CheckGroupInfoEntity.fromJson(Map<String, dynamic> json) {
    return CheckGroupInfoEntity.allArgs(
      json["userId"],
      json["userName"],
      json["telephone"],
      json["email"],
      json["avatarUrl"],
      DateTime.parse(json["addTime"]),
      json["leader"],
      json["locationLat"],
      json["locationLng"],
      json["reportTime"],
    );
  }
//

}