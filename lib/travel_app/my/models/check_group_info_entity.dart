import 'package:meow_travel_flutter/generated/json/base/json_field.dart';
import 'package:meow_travel_flutter/generated/json/check_group_info_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class CheckGroupInfoEntity {

	late String userName;
	late String telephone;
	late String email;
	late String avatarUrl;
	late DateTime addTime;
	late double locationLat;
	late double locationLng;
	late String reportTime;
  
  CheckGroupInfoEntity();

  factory CheckGroupInfoEntity.fromJson(Map<String, dynamic> json) => $CheckGroupInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $CheckGroupInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}