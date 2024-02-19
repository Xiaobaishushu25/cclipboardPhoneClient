
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GlobalKey<_SubChildState> globalKey = GlobalKey();

// 子组件Widget
class SubChild extends StatefulWidget {
  const SubChild({
    super.key,
    required this.onPressedCallback,
  });

  final Function(String param) onPressedCallback;

  @override
  State<SubChild> createState() => _SubChildState();
}

class _SubChildState extends State<SubChild> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // 这里是子组件方法
  void subFunction(String arg) {
    print("这里是子组件方法 arg:${arg}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        color: Colors.greenAccent,
        child: Container(
          width: 200,
          height: 50,
          child: TextButton(
            child: Text("点击调用父组件方法", style: TextStyle(
                color: Colors.brown
            ),),
            onPressed: () {
              onSubBtnPressed();
            },
          ),
        )
    );
  }

  // 点击调用父组件方法
  void onSubBtnPressed() {
    print("点击调用父组件方法");
    String param = "来自子组件的参数";
    widget.onPressedCallback(param);
  }
}


