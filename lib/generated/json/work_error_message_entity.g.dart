import 'package:c_clipboard/generated/json/base/json_convert_content.dart';
import 'package:c_clipboard/message/work_error_message_entity.dart';


WorkErrorMessage $WorkErrorMessageEntityFromJson(
    Map<String, dynamic> json) {
  final WorkErrorMessage workErrorMessageEntity = WorkErrorMessage();
  final List<dynamic>? workErrorMessage = (json['WorkErrorMessage'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (workErrorMessage != null) {
    workErrorMessageEntity.workErrorMessage = workErrorMessage;
  }
  return workErrorMessageEntity;
}

Map<String, dynamic> $WorkErrorMessageEntityToJson(
    WorkErrorMessage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['WorkErrorMessage'] = entity.workErrorMessage;
  return data;
}

extension WorkErrorMessageEntityExtension on WorkErrorMessage {
  WorkErrorMessage copyWith({
    List<dynamic>? workErrorMessage,
  }) {
    return WorkErrorMessage()
      ..workErrorMessage = workErrorMessage ?? this.workErrorMessage;
  }
}