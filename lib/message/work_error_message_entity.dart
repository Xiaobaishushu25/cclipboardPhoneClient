import 'package:c_clipboard/generated/json/base/json_field.dart';
import 'package:c_clipboard/generated/json/work_error_message_entity.g.dart';
import 'dart:convert';

import 'Message.dart';

@JsonSerializable()
class WorkErrorMessage implements Message{
	@JSONField(name: "WorkErrorMessage")
	List<dynamic> workErrorMessage = [];

	WorkErrorMessage();

	factory WorkErrorMessage.fromJson(Map<String, dynamic> json) => $WorkErrorMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $WorkErrorMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  int getTypeId() {
    return 0;
  }
}