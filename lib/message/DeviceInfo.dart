class DeviceInfo {
  String socketAddr;
  String deviceName;
  String deviceType;

  DeviceInfo({
    required this.socketAddr,
    required this.deviceName,
    required this.deviceType,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
      socketAddr: json['socket_addr'] as String,
      deviceName: json['device_name'] as String,
      deviceType: json['device_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'socket_addr': socketAddr,
      'device_name': deviceName,
      'device_type': deviceType,
    };
  }
}