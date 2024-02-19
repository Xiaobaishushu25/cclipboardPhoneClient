import 'package:c_clipboard/generated/json/base/json_field.dart';
import 'package:c_clipboard/generated/json/heart_package_message_entity.g.dart';
import 'dart:convert';

import 'package:c_clipboard/message/Message.dart';
export 'package:c_clipboard/generated/json/heart_package_message_entity.g.dart';

@JsonSerializable()
class HeartPackageMessage implements Message{
	@JSONField(name: "HeartPackageMessage")
	List<dynamic> heartPackageMessage = [];

	HeartPackageMessage();

	factory HeartPackageMessage.fromJson(Map<String, dynamic> json) => $HeartPackageMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $HeartPackageMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  int getTypeId() {
    return 0;
  }
}