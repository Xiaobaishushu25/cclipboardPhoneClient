import 'package:c_clipboard/generated/json/base/json_convert_content.dart';
import 'package:c_clipboard/message/remove_pair_request_message_entity.dart';


RemovePairRequestMessage $RemovePairRequestMessageEntityFromJson(
    Map<String, dynamic> json) {
  final RemovePairRequestMessage removePairRequestMessageEntity = RemovePairRequestMessage();
  final String? removePairRequestMessage = jsonConvert.convert<String>(
      json['RemovePairRequestMessage']);
  if (removePairRequestMessage != null) {
    removePairRequestMessageEntity.removePairRequestMessage =
        removePairRequestMessage;
  }
  return removePairRequestMessageEntity;
}

Map<String, dynamic> $RemovePairRequestMessageEntityToJson(
    RemovePairRequestMessage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['RemovePairRequestMessage'] = entity.removePairRequestMessage;
  return data;
}

extension RemovePairRequestMessageEntityExtension on RemovePairRequestMessage {
  RemovePairRequestMessage copyWith({
    String? removePairRequestMessage,
  }) {
    return RemovePairRequestMessage()
      ..removePairRequestMessage = removePairRequestMessage ??
          this.removePairRequestMessage;
  }
}