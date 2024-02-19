import 'package:c_clipboard/generated/json/base/json_field.dart';
import 'package:c_clipboard/generated/json/close_message_entity.g.dart';
import 'dart:convert';

import 'package:c_clipboard/message/Message.dart';
export 'package:c_clipboard/generated/json/close_message_entity.g.dart';

@JsonSerializable()
class CloseMessage implements Message{
	@JSONField(name: "CloseMessage")
	List<dynamic> closeMessage = [];

	CloseMessage();

	factory CloseMessage.fromJson(Map<String, dynamic> json) => $CloseMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $CloseMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  int getTypeId() {
    return 12;
  }
}