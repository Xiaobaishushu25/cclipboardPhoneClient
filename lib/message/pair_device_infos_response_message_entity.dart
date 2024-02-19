import 'package:c_clipboard/generated/json/base/json_field.dart';
import 'package:c_clipboard/generated/json/pair_device_infos_response_message_entity.g.dart';
import 'dart:convert';

import 'package:c_clipboard/message/DeviceInfo.dart';
import 'package:c_clipboard/message/Message.dart';
export 'package:c_clipboard/generated/json/pair_device_infos_response_message_entity.g.dart';

@JsonSerializable()
class PairDeviceInfosResponseMessage implements Message {
	@JSONField(name: "PairDeviceInfosResponseMessage")
	List<DeviceInfo> pairDeviceInfosResponseMessage = [];

	PairDeviceInfosResponseMessage();

	factory PairDeviceInfosResponseMessage.fromJson(Map<String, dynamic> json) => $PairDeviceInfosResponseMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $PairDeviceInfosResponseMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  int getTypeId() {
    return 3;
  }
}