import 'package:meow_travel_flutter/generated/json/base/json_convert_content.dart';
import 'package:meow_travel_flutter/travel_app/my/models/check_group_info_entity.dart';

CheckGroupInfoEntity $CheckGroupInfoEntityFromJson(Map<String, dynamic> json) {
	final CheckGroupInfoEntity checkGroupInfoEntity = CheckGroupInfoEntity();
	final String? userName = jsonConvert.convert<String>(json['userName']);
	if (userName != null) {
		checkGroupInfoEntity.userName = userName;
	}
	final String? telephone = jsonConvert.convert<String>(json['telephone']);
	if (telephone != null) {
		checkGroupInfoEntity.telephone = telephone;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		checkGroupInfoEntity.email = email;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatarUrl']);
	if (avatarUrl != null) {
		checkGroupInfoEntity.avatarUrl = avatarUrl;
	}
	final DateTime? addTime = jsonConvert.convert<DateTime>(json['addTime']);
	if (addTime != null) {
		checkGroupInfoEntity.addTime = addTime;
	}
	final double? locationLat = jsonConvert.convert<double>(json['locationLat']);
	if (locationLat != null) {
		checkGroupInfoEntity.locationLat = locationLat;
	}
	final double? locationLng = jsonConvert.convert<double>(json['locationLng']);
	if (locationLng != null) {
		checkGroupInfoEntity.locationLng = locationLng;
	}
	final String? reportTime = jsonConvert.convert<String>(json['reportTime']);
	if (reportTime != null) {
		checkGroupInfoEntity.reportTime = reportTime;
	}
	return checkGroupInfoEntity;
}

Map<String, dynamic> $CheckGroupInfoEntityToJson(CheckGroupInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['userName'] = entity.userName;
	data['telephone'] = entity.telephone;
	data['email'] = entity.email;
	data['avatarUrl'] = entity.avatarUrl;
	data['addTime'] = entity.addTime;
	data['locationLat'] = entity.locationLat;
	data['locationLng'] = entity.locationLng;
	data['reportTime'] = entity.reportTime;
	return data;
}