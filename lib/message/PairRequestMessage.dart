import 'dart:convert';

import 'package:c_clipboard/message/Message.dart';

import 'DeviceInfo.dart';
// class DeviceInfoM {
//   String socketAddr;
//   String deviceName;
//   String deviceType;
//
//   DeviceInfoM({
//     required this.socketAddr,
//     required this.deviceName,
//     required this.deviceType,
//   });
//
//   factory DeviceInfoM.fromJson(Map<String, dynamic> json) {
//     return DeviceInfoM(
//       socketAddr: json['socket_addr'] as String,
//       deviceName: json['device_name'] as String,
//       deviceType: json['device_type'] as String,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'socket_addr': socketAddr,
//       'device_name': deviceName,
//       'device_type': deviceType,
//     };
//   }
// }
class PairRequestMessage implements Message{
  String code;
  DeviceInfo deviceInfo;

  PairRequestMessage({
    required this.code,
    required this.deviceInfo,
  });

  factory PairRequestMessage.fromJson(Map<String, dynamic> json) {
    return PairRequestMessage(
      code: json['PairRequestMessage'][0] as String,
      deviceInfo: DeviceInfo.fromJson(json['PairRequestMessage'][1] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'PairRequestMessage': [code, deviceInfo.toJson()]
    };
  }

  @override
  int getTypeId() {
    return 1;
  }
}