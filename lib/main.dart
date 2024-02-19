import 'dart:async';
import 'dart:io';
import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:c_clipboard/DeviceInfoContainer.dart';
import 'package:c_clipboard/message/Codec.dart';
import 'package:c_clipboard/message/DeviceInfo.dart';
import 'package:c_clipboard/message/Message.dart';
import 'package:c_clipboard/message/PairCreateMessage.dart';
import 'package:c_clipboard/message/PairRequestMessage.dart';

import 'CodeInputContainer.dart';
import 'message/DeviceChangeResponseMessage.dart';
import 'message/PairDeviceInfosResponseMessage2.dart';
import 'message/clipboard_message_entity.dart';
import 'message/close_message_entity.dart';
import 'message/heart_package_message_entity.dart';
import 'message/no_pair_device_response_message_entity.dart';
import 'message/pair_code_response_message_entity.dart';
import 'message/remove_pair_request_message_entity.dart';
import 'message/remove_pair_response_message_entity.dart';
import 'message/server_ready_response_message_entity.dart';
import 'message/work_error_message_entity.dart';

void showToast(type,msg){
  var color = Colors.black;
  switch(type){
    case "success":
      color = Colors.greenAccent;
    case "error":
      color = Colors.red;
    case "info":
      color = Colors.grey;
  }
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static DeviceInfo? deviceInfo;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'c_clipboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyHomeState();
  }

}
class _MyHomeState extends State<MyHomePage> with WidgetsBindingObserver {

  Socket? _socket;
  late final ValueNotifier<bool> info = ValueNotifier(false);
  List<DeviceInfo> devices = [];
  bool isConnect = false;
  String oldCode = "";
  List<String> log = [];

  void _connectToServer() async {
    // final String host = _hostController.text;
    const String host = "101.132.113.152";
    // final int port = int.tryParse(_portController.text) ?? 0;
    const int port = 8888;
    // //addLog("------------------------------------------------------------");
    // PairRequestMessage p =PairRequestMessage(message: "test",deviceInfo: DeviceInfo(socketAddr: "127.0.0.1:8080", deviceName: "xbss", deviceType: "DeskTop"));
    // var encode = jsonEncode(p.toJson());
    // List<int> content = utf8.encode(encode);
    // // var content = encode.codeUnits;
    // //addLog(encode);
    // List<int> buffer = [content.length];
    // //addLog("长度是${content.length}");
    // buffer.addAll(content);
    // //addLog(buffer.toString());
    // // 将 List<int> 转换为 Uint8List，因为 Socket.write() 需要 Uint8List
    // Uint8List uint8Buffer = Uint8List.fromList(buffer);
    // //addLog("------------------------------------------------------------");
    try {
      setState(() {
        //addLog("清除配对设施");
        devices.clear();
      });
      _socket = await Socket.connect(host, port);
      isConnect = true;
      // //addLog(_socket?.address);
      // //addLog(_socket?.address.address);
      // //addLog(_socket?.address.host);
      // _socket?.write(buffer);
      // _socket!.add(buffer);
      // _socket?.flush();

      // _socket?.listen(
      //   responseHandler,
      //   onError: (error) {
      //     //addLog('Error: $error');
      //   },
      //   onDone: () {
      //     //addLog('Disconnected from server');
      //   },
      // );
      List<int> oldbuffer = [];
      _socket?.listen((List<int> data) {
        //addLog("收到了数据");
        isConnect = true;
        oldbuffer.addAll(data);
        var result = Codec.decodeData(oldbuffer);
        oldbuffer.clear();
        oldbuffer.addAll(result.remainingData);
        var msg = result.msg;
        if(msg!=null){
          //addLog("解析出了数据");
          switch(msg.runtimeType){
            case HeartPackageMessage:

              // //addLog(msg.toString());
            case PairRequestMessage:
              //addLog(msg.toString());
            case PairCreateMessage:
              //addLog(msg.toString());
            case PairDeviceInfosResponseMessage:
              var infos = (msg as PairDeviceInfosResponseMessage).deviceInfos;
              infos.removeWhere((device) => device.socketAddr == MyApp.deviceInfo!.socketAddr);
              // infos.remove(MyApp.deviceInfo!);
              setState(() {
                devices.addAll(infos);
                showToast("success", "配对成功");
                if(oldCode==""){//手动输入的配对码配对成功了，记下此时的配对码当做老的。
                  globalKey.currentState?.setPairSuccess();
                  oldCode = globalKey.currentState!.getPairCode();
                }else{//老配对码不是空，说明是自动输入的。
                  globalKey.currentState?.setPairCode(oldCode);
                }
                readClipboard();
              });
              readClipboard();
              //addLog(msg.toString());
            case PairCodeResponseMessage:
              var message = msg as PairCodeResponseMessage;
              setState(() {
                showToast("success", "创建配对码成功.");
                globalKey.currentState?.setPairCode(message.pairCodeResponseMessage);
                oldCode = message.pairCodeResponseMessage;
              });
              //addLog(msg.toString());
            case ClipboardMessage:
              var message = msg as ClipboardMessage;
              //addLog("收到剪切板消息");
              Clipboard.setData(ClipboardData(text:message.clipboardMessage));
              showToast("info", "收到剪切板消息.");
            case ServerReadyResponseMessage:
              var addr = (msg as ServerReadyResponseMessage).serverReadyResponseMessage;
              //addLog(addr);
              setState(() {
                MyApp.deviceInfo?.socketAddr = addr;
                showToast("success", "获取设备信息成功.");
              });
              if(oldCode!=""){
                sendMessage(PairRequestMessage(code: oldCode, deviceInfo:MyApp.deviceInfo!));
              }
            case NoPairDeviceResponseMessage:
              setState(() {
                showToast("error", "没有配对的设备！");
              });
              oldCode = "";
              //addLog(msg.toString());
            case RemovePairRequestMessage:
              //addLog(msg.toString());
            case RemovePairResponseMessage:
              oldCode = "";
              setState(() {
                globalKey.currentState?.removeSelf();
                showToast("error", "您已被取消配对！");
                devices.clear();
              });
              //addLog(msg.toString());
            case WorkErrorMessage:
              showToast("error", "服务器错误！");
              //addLog(msg.toString());
            case DeviceChangeResponseMessage:
              var message = msg as DeviceChangeResponseMessage;
              //addLog(message);
              if(message.dir){
                setState(() {
                  devices.add(message.deviceInfo);
                  showToast("info", "已添加设备${message.deviceInfo.deviceName}.");
                });
              }else{
                setState(() {
                  devices.removeWhere((device) => device.socketAddr == message.deviceInfo.socketAddr);
                  // devices.remove(message.deviceInfo);
                  showToast("info", "已移除设备${message.deviceInfo.deviceName}.");
                });
              }
            case CloseMessage:
              //addLog(msg.toString());
          }
        }
        // setState(() {
        //   _response = utf8.decode(data);
        // });
      },
        onError: (error) {
          isConnect = false;
          //addLog('Error: $error');
        },
        onDone: () {
          isConnect = false;
          //addLog('Disconnected from server');
        },
      );
    } catch (e) {
      isConnect = false;
      //addLog('Error: $e');
    }
  }

  void checkConnect(){
    if(!isConnect){
      setState(() {
        globalKey.currentState?.removeSelf();
      });
      // devices.clear();
      _connectToServer();
      // if(oldCode!=""){
      //   sendMessage(PairRequestMessage(code: oldCode, deviceInfo:MyApp.deviceInfo!));
      // }
      // readClipboard();
    }else{
      readClipboard();
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //addLog("------------------获取设备信息-------------------------");
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var name = "";
    if (Platform.isIOS) {
      //addLog("This is an iOS device");
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      name = iosInfo.utsname.machine;
      //addLog('Running on ${iosInfo.utsname.machine}');
      // 在这里编写iOS特定的代码
    } else if (Platform.isAndroid) {
      //addLog("This is an Android device");
      // 在这里编写Android特定的代码
      var androidInfo = await deviceInfo.androidInfo;
      //addLog('Running on ${androidInfo.host}');
      //addLog('Running on ${androidInfo.device}');
      name = androidInfo.device;
    }
    MyApp.deviceInfo = DeviceInfo(socketAddr: "", deviceName: name, deviceType: "Phone");
    //addLog("------------------连接服务器-------------------------");
    _connectToServer();
    Timer.periodic(const Duration(seconds: 30), (timer) {
      isConnect = false;
      sendMessage(HeartPackageMessage());
    });
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
        //addLog("到前台了");
        checkConnect();
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        //addLog("应用处于不可见状态 后台======");
        break;
      case AppLifecycleState.detached: // APP结束时调用
        sendMessage(CloseMessage());
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  void readClipboard() async {
    var text = await Clipboard.getData(Clipboard.kTextPlain);
    if(text==null){
      //addLog("读取到null");
    }else{
      var content = text.text;
      //addLog("读取到${content}");
      if(content!=null){
        var clipboardMessage = ClipboardMessage();
        clipboardMessage.clipboardMessage = content;
        sendMessage(clipboardMessage);
      }
    }
  }


  void sendMessage(Message msg) {
    if (_socket == null) return;
    var bytes = Codec.encode(msg);
    _socket!.add(bytes);

    // PairRequestMessage p =PairRequestMessage(message: "test",deviceInfo: DeviceInfo(socketAddr: "127.0.0.1:8080", deviceName: "xbss", deviceType: "DeskTop"));
    // var encode = jsonEncode(p.toJson());
    // List<int> content = utf8.encode(encode);
    // // var content = encode.codeUnits;
    // //addLog(encode);
    // //addLog("长度是${content.length}");
    // List<int> buffer = [content.length];
    // buffer.addAll(content);
    // //addLog("内容是$buffer");
    // // _socket!.write(buffer);
    // _socket!.add(buffer);
    // // final String message = "nmihao";
    // // _socket!.write(message);
    // setState(() {
    //   _response = '';
    // });
  }


  void requestPairCode(){
    if (_socket == null) return;
    sendMessage(PairCreateMessage(deviceInfo:DeviceInfo(socketAddr: "106.111.212.177:31959", deviceName: "xbss", deviceType: "Phone")));
  }
  void _remove_pair(addr){
    //addLog("请求解除${addr}");
    var removePairRequestMessage = RemovePairRequestMessage();
    removePairRequestMessage.removePairRequestMessage = addr;
    sendMessage(removePairRequestMessage);
  }
  void addinfo(){
    setState(() {
      devices.add(DeviceInfo(socketAddr: "127.01.0.1", deviceName: "dev5eName", deviceType: "Computer"));
    });
  }
  void addLog(msg){
    // setState(() {
    //   log.add(msg);
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.white,
        title: const Text("CClipboard",
          style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Center(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // TextButton(onPressed:addinfo , child: Text("child")),
                CodeInputContainer(
                    key: globalKey,
                    count: 6,
                    // phone: '18888888888',
                    onRequest: () async {
                      sendMessage(PairCreateMessage(deviceInfo: MyApp.deviceInfo!));
                      // Function() cancel = MsgUtil.loading();
                      // await Future.delayed(const Duration(seconds: 1));
                      // cancel.call();
                      // MsgUtil.toast('验证码发送成功');
                      return true;
                    },
                    onResult: (code) {
                      //addLog("请求配对");
                      oldCode = "";//手动请求配对后把老配对码清空。
                      sendMessage(PairRequestMessage(code: code, deviceInfo: MyApp.deviceInfo!));
                      // _sendMessage(PairRequestMessage(message: message, deviceInfo: deviceInfo))
                    }
                ),
                const SizedBox(height: 30),
                // if(info.value)
                if(MyApp.deviceInfo!=null)
                  DeviceInfoContainer(self: true, deviceInfo: MyApp.deviceInfo!,remove: (addr){
                    _remove_pair(addr);
                  },),
                // DeviceInfoContainer(self: true, name: MyApp.deviceInfo!.deviceName, type: MyApp.deviceInfo!.deviceType),
                const SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 8),
                            DeviceInfoContainer(self: false, deviceInfo: devices[index],remove: (addr){
                              _remove_pair(addr);
                            },),
                          ]
                      );
                    },
                  ),
                ),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: log.length,
                //     itemBuilder: (context, index) {
                //       return Text(log[index]);
                //     },
                //   ),
                // )
              ],
            ),
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}