
import 'package:c_clipboard/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FatherOutContainer extends StatefulWidget {
  const FatherOutContainer({super.key});

  @override
  State<FatherOutContainer> createState() => _FatherOutContainerState();
}

class _FatherOutContainerState extends State<FatherOutContainer> {
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

  // 这里是父组件方法
  void fatherFunction(String param) {
    print("这里是父组件方法 params:${param}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 600,
      color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 100,
          ),
          SubChild(
            key: globalKey,
            onPressedCallback: (param) {
              fatherFunction(param);
            },
          ),
          SizedBox(
            width: 20,
            height: 40,
          ),
          TextButton(
            child: Text("点击调用子组件方法"),
            onPressed: () {
              String arg = "来自父组件的参数";
              globalKey.currentState?.subFunction(arg);
            },
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}


