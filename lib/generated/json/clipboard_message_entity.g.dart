import 'package:c_clipboard/generated/json/base/json_convert_content.dart';
import 'package:c_clipboard/message/clipboard_message_entity.dart';


ClipboardMessage $ClipboardMessageEntityFromJson(
    Map<String, dynamic> json) {
  final ClipboardMessage clipboardMessageEntity = ClipboardMessage();
  final String? clipboardMessage = jsonConvert.convert<String>(
      json['ClipboardMessage']);
  if (clipboardMessage != null) {
    clipboardMessageEntity.clipboardMessage = clipboardMessage;
  }
  return clipboardMessageEntity;
}

Map<String, dynamic> $ClipboardMessageEntityToJson(
    ClipboardMessage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ClipboardMessage'] = entity.clipboardMessage;
  return data;
}

extension ClipboardMessageEntityExtension on ClipboardMessage {
  ClipboardMessage copyWith({
    String? clipboardMessage,
  }) {
    return ClipboardMessage()
      ..clipboardMessage = clipboardMessage ?? this.clipboardMessage;
  }
}