import 'package:c_clipboard/message/heart_package_message_entity.dart';


HeartPackageMessage $HeartPackageMessageEntityFromJson(
    Map<String, dynamic> json) {
  final HeartPackageMessage heartPackageMessageEntity = HeartPackageMessage();
  final List<
      dynamic>? heartPackageMessage = (json['HeartPackageMessage'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (heartPackageMessage != null) {
    heartPackageMessageEntity.heartPackageMessage = heartPackageMessage;
  }
  return heartPackageMessageEntity;
}

Map<String, dynamic> $HeartPackageMessageEntityToJson(
    HeartPackageMessage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['HeartPackageMessage'] = entity.heartPackageMessage;
  return data;
}

extension HeartPackageMessageEntityExtension on HeartPackageMessage {
  HeartPackageMessage copyWith({
    List<dynamic>? heartPackageMessage,
  }) {
    return HeartPackageMessage()
      ..heartPackageMessage = heartPackageMessage ?? this.heartPackageMessage;
  }
}