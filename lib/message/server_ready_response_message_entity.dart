import 'package:c_clipboard/generated/json/base/json_field.dart';
import 'package:c_clipboard/generated/json/server_ready_response_message_entity.g.dart';
import 'dart:convert';

import 'package:c_clipboard/message/Message.dart';
export 'package:c_clipboard/generated/json/server_ready_response_message_entity.g.dart';

@JsonSerializable()
class ServerReadyResponseMessage implements Message{
	@JSONField(name: "ServerReadyResponseMessage")
	late String serverReadyResponseMessage = '';

	ServerReadyResponseMessage();

	factory ServerReadyResponseMessage.fromJson(Map<String, dynamic> json) => $ServerReadyResponseMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $ServerReadyResponseMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  int getTypeId() {
    return 6;
  }
}