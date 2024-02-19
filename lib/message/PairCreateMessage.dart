import 'DeviceInfo.dart';
import 'Message.dart';

class PairCreateMessage implements Message{
  DeviceInfo deviceInfo;

  PairCreateMessage({
    required this.deviceInfo,
  });

  factory PairCreateMessage.fromJson(Map<String, dynamic> json) {
    return PairCreateMessage(
      deviceInfo: DeviceInfo.fromJson(json['PairCreateMessage'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'PairCreateMessage': deviceInfo.toJson(),
    };
  }

  @override
  int getTypeId() {
    return 2;
  }
}