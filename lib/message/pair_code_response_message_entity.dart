import 'package:c_clipboard/generated/json/base/json_field.dart';
import 'package:c_clipboard/generated/json/pair_code_response_message_entity.g.dart';
import 'dart:convert';

import 'package:c_clipboard/message/Message.dart';
export 'package:c_clipboard/generated/json/pair_code_response_message_entity.g.dart';

@JsonSerializable()
class PairCodeResponseMessage implements Message{
	@JSONField(name: "PairCodeResponseMessage")
	late String pairCodeResponseMessage = '';

	PairCodeResponseMessage();

	factory PairCodeResponseMessage.fromJson(Map<String, dynamic> json) => $PairCodeResponseMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $PairCodeResponseMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  int getTypeId() {
    return 4;
  }
}