
class CheckGroupInfoEntity {

	String? userName;
	String? telephone;
	String? email;
	String? avatarUrl;
	DateTime? addTime;
	double? locationLat;
	double? locationLng;
	String? reportTime;


	CheckGroupInfoEntity();

  CheckGroupInfoEntity.allArgs(
      this.userName,
      this.telephone,
      this.email,
      this.avatarUrl,
      this.addTime,
      this.locationLat,
			this.locationLng,
      this.reportTime);

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "telephone": telephone,
      "email": email,
      "avatarUrl": avatarUrl,
      "addTime": addTime,
      "locationLat": locationLat,
      "locationLng": locationLng,
      "reportTime": reportTime,
    };
  }

	factory CheckGroupInfoEntity.fromJson(Map<String, dynamic> json) {
    return CheckGroupInfoEntity.allArgs(
      json["userName"],
      json["telephone"],
      json["email"],
      json["avatarUrl"],
      DateTime.parse(json["addTime"]),
      json["locationLat"],
      json["locationLng"],
      json["reportTime"],
    );
  }
//

}