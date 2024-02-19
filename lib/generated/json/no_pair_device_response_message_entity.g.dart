import 'package:c_clipboard/message/no_pair_device_response_message_entity.dart';


NoPairDeviceResponseMessage $NoPairDeviceResponseMessageEntityFromJson(
    Map<String, dynamic> json) {
  final NoPairDeviceResponseMessage noPairDeviceResponseMessageEntity = NoPairDeviceResponseMessage();
  final List<
      dynamic>? noPairDeviceResponseMessage = (json['NoPairDeviceResponseMessage'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (noPairDeviceResponseMessage != null) {
    noPairDeviceResponseMessageEntity.noPairDeviceResponseMessage =
        noPairDeviceResponseMessage;
  }
  return noPairDeviceResponseMessageEntity;
}

Map<String, dynamic> $NoPairDeviceResponseMessageEntityToJson(
    NoPairDeviceResponseMessage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['NoPairDeviceResponseMessage'] = entity.noPairDeviceResponseMessage;
  return data;
}

extension NoPairDeviceResponseMessageEntityExtension on NoPairDeviceResponseMessage {
  NoPairDeviceResponseMessage copyWith({
    List<dynamic>? noPairDeviceResponseMessage,
  }) {
    return NoPairDeviceResponseMessage()
      ..noPairDeviceResponseMessage = noPairDeviceResponseMessage ??
          this.noPairDeviceResponseMessage;
  }
}