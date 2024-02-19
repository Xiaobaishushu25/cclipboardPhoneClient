import 'package:c_clipboard/generated/json/base/json_convert_content.dart';
import 'package:c_clipboard/message/pair_device_infos_response_message_entity.dart';
import 'package:c_clipboard/message/DeviceInfo.dart';



PairDeviceInfosResponseMessage $PairDeviceInfosResponseMessageEntityFromJson(
    Map<String, dynamic> json) {
  final PairDeviceInfosResponseMessage pairDeviceInfosResponseMessageEntity = PairDeviceInfosResponseMessage();
  final List<
      DeviceInfo>? pairDeviceInfosResponseMessage = (json['PairDeviceInfosResponseMessage'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<DeviceInfo>(e) as DeviceInfo).toList();
  if (pairDeviceInfosResponseMessage != null) {
    pairDeviceInfosResponseMessageEntity.pairDeviceInfosResponseMessage =
        pairDeviceInfosResponseMessage;
  }
  return pairDeviceInfosResponseMessageEntity;
}

Map<String, dynamic> $PairDeviceInfosResponseMessageEntityToJson(
    PairDeviceInfosResponseMessage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['PairDeviceInfosResponseMessage'] =
      entity.pairDeviceInfosResponseMessage.map((v) => v.toJson()).toList();
  return data;
}

extension PairDeviceInfosResponseMessageEntityExtension on PairDeviceInfosResponseMessage {
  PairDeviceInfosResponseMessage copyWith({
    List<DeviceInfo>? pairDeviceInfosResponseMessage,
  }) {
    return PairDeviceInfosResponseMessage()
      ..pairDeviceInfosResponseMessage = pairDeviceInfosResponseMessage ??
          this.pairDeviceInfosResponseMessage;
  }
}