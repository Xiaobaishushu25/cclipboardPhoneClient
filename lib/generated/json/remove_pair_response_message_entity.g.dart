import 'package:c_clipboard/message/remove_pair_response_message_entity.dart';


RemovePairResponseMessage $RemovePairResponseMessageEntityFromJson(
    Map<String, dynamic> json) {
  final RemovePairResponseMessage removePairResponseMessageEntity = RemovePairResponseMessage();
  final List<
      dynamic>? removePairResponseMessage = (json['RemovePairResponseMessage'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (removePairResponseMessage != null) {
    removePairResponseMessageEntity.removePairResponseMessage =
        removePairResponseMessage;
  }
  return removePairResponseMessageEntity;
}

Map<String, dynamic> $RemovePairResponseMessageEntityToJson(
    RemovePairResponseMessage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['RemovePairResponseMessage'] = entity.removePairResponseMessage;
  return data;
}

extension RemovePairResponseMessageEntityExtension on RemovePairResponseMessage {
  RemovePairResponseMessage copyWith({
    List<dynamic>? removePairResponseMessage,
  }) {
    return RemovePairResponseMessage()
      ..removePairResponseMessage = removePairResponseMessage ??
          this.removePairResponseMessage;
  }
}