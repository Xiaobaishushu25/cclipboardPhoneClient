import 'package:c_clipboard/generated/json/base/json_field.dart';
import 'package:c_clipboard/generated/json/remove_pair_response_message_entity.g.dart';
import 'dart:convert';

import 'package:c_clipboard/message/Message.dart';
export 'package:c_clipboard/generated/json/remove_pair_response_message_entity.g.dart';

@JsonSerializable()
class RemovePairResponseMessage implements Message {
	@JSONField(name: "RemovePairResponseMessage")
	late List<dynamic> removePairResponseMessage = [];

	RemovePairResponseMessage();

	factory RemovePairResponseMessage.fromJson(Map<String, dynamic> json) => $RemovePairResponseMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $RemovePairResponseMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  int getTypeId() {
    return 9;
  }
}