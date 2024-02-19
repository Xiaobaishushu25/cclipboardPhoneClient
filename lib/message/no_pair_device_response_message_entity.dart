import 'package:c_clipboard/generated/json/base/json_field.dart';
import 'package:c_clipboard/generated/json/no_pair_device_response_message_entity.g.dart';
import 'dart:convert';

import 'package:c_clipboard/message/Message.dart';
export 'package:c_clipboard/generated/json/no_pair_device_response_message_entity.g.dart';

@JsonSerializable()
class NoPairDeviceResponseMessage implements Message {
	@JSONField(name: "NoPairDeviceResponseMessage")
	List<dynamic> noPairDeviceResponseMessage = [];

	NoPairDeviceResponseMessage();

	factory NoPairDeviceResponseMessage.fromJson(Map<String, dynamic> json) => $NoPairDeviceResponseMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $NoPairDeviceResponseMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  int getTypeId() {
    return 7;
  }
}