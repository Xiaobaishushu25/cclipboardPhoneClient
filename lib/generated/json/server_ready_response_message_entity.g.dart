import 'package:c_clipboard/generated/json/base/json_convert_content.dart';
import 'package:c_clipboard/message/server_ready_response_message_entity.dart';


ServerReadyResponseMessage $ServerReadyResponseMessageEntityFromJson(
    Map<String, dynamic> json) {
  final ServerReadyResponseMessage serverReadyResponseMessageEntity = ServerReadyResponseMessage();
  final String? serverReadyResponseMessage = jsonConvert.convert<String>(
      json['ServerReadyResponseMessage']);
  if (serverReadyResponseMessage != null) {
    serverReadyResponseMessageEntity.serverReadyResponseMessage =
        serverReadyResponseMessage;
  }
  return serverReadyResponseMessageEntity;
}

Map<String, dynamic> $ServerReadyResponseMessageEntityToJson(
    ServerReadyResponseMessage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ServerReadyResponseMessage'] = entity.serverReadyResponseMessage;
  return data;
}

extension ServerReadyResponseMessageEntityExtension on ServerReadyResponseMessage {
  ServerReadyResponseMessage copyWith({
    String? serverReadyResponseMessage,
  }) {
    return ServerReadyResponseMessage()
      ..serverReadyResponseMessage = serverReadyResponseMessage ??
          this.serverReadyResponseMessage;
  }
}