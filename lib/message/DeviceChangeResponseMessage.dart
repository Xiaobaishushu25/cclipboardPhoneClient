import 'dart:convert';

import 'package:c_clipboard/message/Message.dart';

import 'DeviceInfo.dart';
import 'Message.dart';

class DeviceChangeResponseMessage implements Message{
  bool dir;
  DeviceInfo deviceInfo;

  DeviceChangeResponseMessage({
    required this.dir,
    required this.deviceInfo,
  });

  factory DeviceChangeResponseMessage.fromJson(Map<String, dynamic> json) {
    return DeviceChangeResponseMessage(
      dir: json['DeviceChangeResponseMessage'][0] as bool,
      deviceInfo: DeviceInfo.fromJson(json['DeviceChangeResponseMessage'][1] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'DeviceChangeResponseMessage': [dir, deviceInfo.toJson()]
    };
  }

  @override
  int getTypeId() {
    return 11;
  }
}