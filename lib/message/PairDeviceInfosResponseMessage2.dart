import 'DeviceInfo.dart';
import 'Message.dart';
//反序列化过程的json是{"PairDeviceInfosResponseMessage":[{"socket_addr":"180.127.102.56:25430","device_name":"Xiaobaishushu","device_type":"DeskTop"},{"socket_addr":"180.127.102.56:23050","device_name":"emulator64_x86_64_arm64","device_type":"Phone"}]}
//反序列化过程的json是{PairDeviceInfosResponseMessage: [{socket_addr: 180.127.102.56:25430, device_name: Xiaobaishushu, device_type: DeskTop}, {socket_addr: 180.127.102.56:23226, device_name: emulator64_x86_64_arm64, device_type: Phone}]}
class PairDeviceInfosResponseMessage implements Message {
  List<DeviceInfo> deviceInfos;

  PairDeviceInfosResponseMessage({
    required this.deviceInfos,
  });

  factory PairDeviceInfosResponseMessage.fromJson(Map<String, dynamic> json) {
    return PairDeviceInfosResponseMessage(
      deviceInfos: List<DeviceInfo>.from(json['PairDeviceInfosResponseMessage'].map((deviceJson) => DeviceInfo.fromJson(deviceJson as Map<String, dynamic>))),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'PairDeviceInfosResponseMessage2': deviceInfos.map((deviceInfo) => deviceInfo.toJson()).toList()
    };
  }

  @override
  int getTypeId() {
    return 1;
  }
}