import 'package:c_clipboard/message/close_message_entity.dart';

CloseMessage $CloseMessageEntityFromJson(Map<String, dynamic> json) {
  final CloseMessage closeMessageEntity = CloseMessage();
  final List<dynamic>? closeMessage = (json['CloseMessage'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (closeMessage != null) {
    closeMessageEntity.closeMessage = closeMessage;
  }
  return closeMessageEntity;
}

Map<String, dynamic> $CloseMessageEntityToJson(CloseMessage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['CloseMessage'] = entity.closeMessage;
  return data;
}

extension CloseMessageEntityExtension on CloseMessage {
  CloseMessage copyWith({
    List<dynamic>? closeMessage,
  }) {
    return CloseMessage()
      ..closeMessage = closeMessage ?? this.closeMessage;
  }
}