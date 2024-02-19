import 'package:c_clipboard/generated/json/base/json_field.dart';
import 'package:c_clipboard/generated/json/clipboard_message_entity.g.dart';
import 'dart:convert';

import 'package:c_clipboard/message/Message.dart';
export 'package:c_clipboard/generated/json/clipboard_message_entity.g.dart';

@JsonSerializable()
class ClipboardMessage implements Message{
	@JSONField(name: "ClipboardMessage")
	late String clipboardMessage = '';

	ClipboardMessage();

	factory ClipboardMessage.fromJson(Map<String, dynamic> json) => $ClipboardMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $ClipboardMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  int getTypeId() {
    return 5;
  }
}