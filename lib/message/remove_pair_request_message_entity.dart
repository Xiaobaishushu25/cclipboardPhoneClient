
import 'package:c_clipboard/generated/json/base/json_field.dart';
import 'package:c_clipboard/generated/json/remove_pair_request_message_entity.g.dart';
import 'dart:convert';

import 'package:c_clipboard/message/Message.dart';
export 'package:c_clipboard/generated/json/remove_pair_request_message_entity.g.dart';

@JsonSerializable()
class RemovePairRequestMessage implements Message{
	@JSONField(name: "RemovePairRequestMessage")
	late String removePairRequestMessage = '';

	RemovePairRequestMessage();

	factory RemovePairRequestMessage.fromJson(Map<String, dynamic> json) => $RemovePairRequestMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $RemovePairRequestMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  int getTypeId() {
    return 8;
  }
}