import 'dart:convert';
import 'dart:typed_data';

import 'package:c_clipboard/message/Message.dart';
import 'package:c_clipboard/message/heart_package_message_entity.dart';
import 'package:c_clipboard/message/pair_code_response_message_entity.dart';
import 'package:c_clipboard/message/remove_pair_request_message_entity.dart';
import 'package:c_clipboard/message/remove_pair_response_message_entity.dart';
import 'package:c_clipboard/message/server_ready_response_message_entity.dart';
import 'package:c_clipboard/message/work_error_message_entity.dart';

import 'DeviceChangeResponseMessage.dart';
import 'PairCreateMessage.dart';
import 'PairDeviceInfosResponseMessage2.dart';
import 'PairRequestMessage.dart';
import 'clipboard_message_entity.dart';
import 'close_message_entity.dart';
import 'no_pair_device_response_message_entity.dart';

class Codec{
  final messageTypeMap = {
    0: "HeartPackageMessage",
    1: "PairRequestMessage",
    2: "PairCreateMessage",
    3: "PairDeviceInfosResponseMessage",
    4: "PairCodeResponseMessage",
    5: "ClipboardMessage",
    6: "ServerReadyResponseMessage",
    7: "NoPairDeviceResponseMessage",
    8: "RemovePairRequestMessage",
    9: "RemovePairResponseMessage",
    10: "WorkErrorMessage",
    11: "DeviceChangeResponseMessage",
    12: "CloseMessage",
  };
  // 反序列化函数
  static Message fromJsonAsMessage(int typeId, Map<String, dynamic> json) {
    switch (typeId) {
      case 0:
        return HeartPackageMessage.fromJson(json) as Message;
      case 1:
        return PairRequestMessage.fromJson(json) as Message;
      case 2:
        return PairCreateMessage.fromJson(json) as Message;
      case 3:
        return PairDeviceInfosResponseMessage.fromJson(json) as Message;
      case 4:
        return PairCodeResponseMessage.fromJson(json) as Message;
      case 5:
        return ClipboardMessage.fromJson(json) as Message;
      case 6:
        return ServerReadyResponseMessage.fromJson(json) as Message;
      case 7:
        return NoPairDeviceResponseMessage.fromJson(json) as Message;
      case 8:
        return RemovePairRequestMessage.fromJson(json) as Message;
      case 9:
        return RemovePairResponseMessage.fromJson(json) as Message;
      case 10:
        return WorkErrorMessage.fromJson(json) as Message;
      case 11:
        return DeviceChangeResponseMessage.fromJson(json) as Message;
      case 12:
        return CloseMessage.fromJson(json) as Message;
      default:
        throw ArgumentError('Unsupported typeId: $typeId');
    }
  }
  static List<int> encode(Message msg){
    var json = jsonEncode(msg.toJson());
    int typeId = msg.getTypeId();
    List<int> content = utf8.encode(json);
    final bytes = Uint8List(content.length + 1 + 4);
    final buffer = ByteData.view(bytes.buffer);

    int offset = 0;

    buffer.setUint8(offset, typeId);
    offset += 1;

    buffer.setInt32(offset, content.length);
    offset += 4;

    for (int i = 0; i < content.length; i++) {
      buffer.setUint8(offset + i, content[i]);
    }
    return bytes;
  }
  static bool checkEntireMessage(List<int> data){
    var encodedData = Uint8List.fromList(data);
    if (encodedData.length < 5) {
      // Not enough data to decode header
      return false; // Return null to indicate insufficient data
    }
    ByteData byteData = encodedData.buffer.asByteData();
    int typeId = byteData.getUint8(0);
    int contentLength = byteData.getInt32(1);
    if (encodedData.length < 5 + contentLength) {
      // Not enough data to decode content
      return false; // Return null to indicate insufficient data
    }

    return true;
  }
  static DecodeResult decodeData(List<int> data) {
    var encodedData = Uint8List.fromList(data);
    if (encodedData.length < 5) {
      // Not enough data to decode header
      return DecodeResult(null,data);
    }
    ByteData byteData = encodedData.buffer.asByteData();

    // Decode type id
    int typeId = byteData.getUint8(0);
    print("消息类型id是${typeId}");
    // Decode content length
    int contentLength = byteData.getInt32(1);
    if (encodedData.length < 5 + contentLength) {
      return DecodeResult(null,data);
    }
    // Decode content
    Uint8List content = Uint8List.sublistView(encodedData, 5, 5 + contentLength);
    // Convert remaining data to List<int>
    List<int> remainingData = [];
    if (encodedData.length > 5 + contentLength) {
      remainingData = encodedData.sublist(5 + contentLength).toList();
    }

    Map<String, dynamic> json = decodeJsonFromUint8List(content);
    //反序列化过程
    Message msg = fromJsonAsMessage(typeId, json);
    return DecodeResult(msg, remainingData);
  }

  static Map<String, dynamic> decodeJsonFromUint8List(Uint8List data) {
    // Step 1: Convert Uint8List to String
    String jsonString = utf8.decode(data);
    print("反序列化过程的json字符串是${jsonString}");
    // Step 2: Parse string to JSON
    Map<String, dynamic> json = jsonDecode(jsonString);
    print("反序列化过程的json是${json}");
    return json;
  }
  // static Uint8List encodeData(int typeId, List<int> content) {
  //   final bytes = Uint8List(content.length + 1 + 4);
  //   final buffer = ByteData.view(bytes.buffer);
  //
  //   int offset = 0;
  //
  //   buffer.setUint8(offset, typeId);
  //   offset += 1;
  //
  //   buffer.setInt32(offset, content.length);
  //   offset += 4;
  //
  //   for (int i = 0; i < content.length; i++) {
  //     buffer.setUint8(offset + i, content[i]);
  //   }
  //
  //   return bytes;
  // }
}
class DecodeResult{
  Message? msg;
  List<int> remainingData = [];
  DecodeResult(this.msg, this.remainingData);
}