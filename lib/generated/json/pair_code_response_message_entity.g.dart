import 'package:c_clipboard/generated/json/base/json_convert_content.dart';
import 'package:c_clipboard/message/pair_code_response_message_entity.dart';


PairCodeResponseMessage $PairCodeResponseMessageEntityFromJson(
    Map<String, dynamic> json) {
  final PairCodeResponseMessage pairCodeResponseMessageEntity = PairCodeResponseMessage();
  final String? pairCodeResponseMessage = jsonConvert.convert<String>(
      json['PairCodeResponseMessage']);
  if (pairCodeResponseMessage != null) {
    pairCodeResponseMessageEntity.pairCodeResponseMessage =
        pairCodeResponseMessage;
  }
  return pairCodeResponseMessageEntity;
}

Map<String, dynamic> $PairCodeResponseMessageEntityToJson(
    PairCodeResponseMessage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['PairCodeResponseMessage'] = entity.pairCodeResponseMessage;
  return data;
}

extension PairCodeResponseMessageEntityExtension on PairCodeResponseMessage {
  PairCodeResponseMessage copyWith({
    String? pairCodeResponseMessage,
  }) {
    return PairCodeResponseMessage()
      ..pairCodeResponseMessage = pairCodeResponseMessage ??
          this.pairCodeResponseMessage;
  }
}