import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

GlobalKey<_CodeInputContainerState> globalKey = GlobalKey();
/// 验证码输入框
class CodeInputContainer extends StatefulWidget {
  final int count;
  // final String phone;
  final Function(String code) onResult;
  /// 重新发起获取验证码
  /// [return] 是否发起"获取验证码"操作成功
  final Future<bool> Function() onRequest;

  const CodeInputContainer({
    super.key,
    required this.count,
    // required this.phone,
    required this.onResult,
    required this.onRequest,
  });

  @override
  State<CodeInputContainer> createState() => _CodeInputContainerState();
}

class _CodeInputContainerState extends State<CodeInputContainer> with WidgetsBindingObserver {
  late final ValueNotifier<String> code = ValueNotifier('');
  late FocusNode inputFocus = FocusNode();

  bool canRequestPairCode = true;
  // Timer? timer;
  final int seconds = 60;
  late final ValueNotifier<int> timeCount = ValueNotifier(seconds);
  DateTime? pausedTime;

  void setPairSuccess(){
    setState(() {
      canRequestPairCode = false;
    });
  }
  void setPairCode(rcode){
    setState(() {
      print("进来设置配对码");
      canRequestPairCode = false;
      code.value = rcode;
    });
  }
  String getPairCode(){
    return code.value;
  }
  void removeSelf(){
    setState(() {
      canRequestPairCode = true;
      code.value = '';
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      inputFocus.requestFocus();
      // startTimer();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// 适配页面切换、熄屏时倒计时混乱问题
    if (state == AppLifecycleState.resumed) {
      if (pausedTime != null) {
        int seconds = DateTime.now().difference(pausedTime!).inSeconds;
        pausedTime = null;
        timeCount.value = max(0, timeCount.value - seconds);
        // startTimer();
      }
    } else if (state == AppLifecycleState.paused) {
      // timer?.cancel();
      pausedTime = DateTime.now();
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    // timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(40.0,0.0),
          child:  const Text(
            '配对码',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // const Text(
        //   '输入配对码',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 24,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        // const SizedBox(height: 8),
        // Text(
        //   '验证码已发送至 ${handlePhone(widget.phone)}',
        //   style: const TextStyle(color: Colors.grey, fontSize: 13),
        // ),
        const SizedBox(height: 20),
        buildCodeInput(),
        GestureDetector(
          onTap: () {
            /// 点击时弹出输入键盘
            SystemChannels.textInput.invokeMethod('TextInput.show');
            inputFocus.requestFocus();
          },
          child: buildCodeView(),
        ),
        const SizedBox(height: 15),
        // if (!restart)
        //   ValueListenableBuilder<int>(
        //     valueListenable: timeCount,
        //     builder: (context, value, child) {
        //       return Text(
        //         '$value 秒后可重新获取',
        //         style: const TextStyle(color: Colors.grey, fontSize: 13),
        //       );
        //     },
        //   ),
        // GestureDetector(
        //   onTap: () async {
        //     if(canRequestPairCode){
        //       requestPairCode();
        //     }
        //     // if (await widget.onRestart.call()) {
        //     //   setState(() {
        //     //     canRequestPairCode = false;
        //     //   });
        //     //   requestPairCode();
        //     //   // startTimer();
        //     // }
        //   },
        //   child: const Text(
        //     '没有配对码？点击创建.',
        //     style: TextStyle(color: Colors.red, fontSize: 13),
        //   ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // 水平居中
          children: [
            GestureDetector(
              onTap: () async {
                if(canRequestPairCode){
                  widget.onRequest.call();
                  // requestPairCode();
                }
              },
              child: buildPairButton(),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPairButton(){
    if(canRequestPairCode){
      return const Text(
        '没有配对码？点击创建.',
        style: TextStyle(color: Colors.red, fontSize: 15),
      );
    }else{
      return const Text(
        '配对成功.',
        style: TextStyle(color: Colors.green, fontSize: 15),
      );
    }
  }


  Widget buildCodeInput() {
    return SizedBox(
      height: 0,
      width: 0,
      child: TextField(
        enabled: canRequestPairCode,
        controller: TextEditingController(text: code.value),
        focusNode: inputFocus,
        maxLength: widget.count,
        keyboardType: TextInputType.number,
        // 禁止长按复制
        enableInteractiveSelection: false,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        inputFormatters: [
          // 只允许输入数字
          FilteringTextInputFormatter(RegExp("^[0-9]*\$"), allow: true)
        ],
        onChanged: (v) async {
          code.value = v;
          if (v.length == widget.count) widget.onResult.call(v);
        },
      ),
    );
  }

  Widget buildCodeView() {
    return ValueListenableBuilder<String>(
      valueListenable: code,
      builder: (context, value, child) {
        return GridView.count(
          padding: EdgeInsets.zero,
          // padding: const EdgeInsets.only(left: 25.0,right: 25.0),
          crossAxisCount: widget.count,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: 8,
          childAspectRatio: 0.95,
          children: List.generate(widget.count, (int i) => i).map((index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: ((index < widget.count && index == value.length) ||
                    (inputFocus.hasFocus && value.isEmpty && index == 0))
                    ? Border.all(width: 1, color: Colors.red)
                    : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: (value.length > index)
                  ? Text(
                value[index],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              )
                  : null,
            );
          }).toList(),
        );
      },
    );
  }
}

