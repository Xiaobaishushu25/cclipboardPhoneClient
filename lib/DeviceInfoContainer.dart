import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:c_clipboard/example.dart';
import 'package:c_clipboard/main.dart';
import 'package:c_clipboard/message/DeviceInfo.dart';

class DeviceInfoContainer extends StatefulWidget{
  final bool self;
  final DeviceInfo deviceInfo;
  final Function(String addr) remove;
  const DeviceInfoContainer({super.key,required this.self,required this.deviceInfo,required this.remove});
  @override
  State createState()=>_DeviceInfoContainerState();
}
class _DeviceInfoContainerState extends State<DeviceInfoContainer> with SingleTickerProviderStateMixin{
  bool showButton = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 100), vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-0.1, 0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  void toggleButtonVisibility() {
    setState(() {
      var status = _controller.status;
      if(status==AnimationStatus.dismissed){
        _controller.forward(from: 0);
      }else if(status==AnimationStatus.completed){
        _controller.reverse();
      }
      showButton = !showButton;
    });
  }
  void rowComplete() {
    var status = _controller.status;
    if(status==AnimationStatus.completed){
      setState(() {
        _controller.reverse();
        showButton = !showButton;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
      rowComplete();
    },
    child:SlideTransition(
      position: _offsetAnimation,
      child: Row(
        children: [
          const SizedBox(width: 50),
          if (widget.deviceInfo.deviceType == "Phone")
            SvgPicture.asset('assets/svg/phone.svg', width: 40, height: 40,)
          else
            SvgPicture.asset('assets/svg/computer.svg', width: 40, height: 40,),
          const SizedBox(width: 25,),
          if (widget.self)
            SizedBox(
              width: 110,
              child: Text(
                widget.deviceInfo.deviceName,
                style: const TextStyle(color: Colors.blue,),
              ),
            )
          else
            SizedBox(width: 110, child: Text(widget.deviceInfo.deviceName),),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              toggleButtonVisibility();
            },
            child:Align(
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/svg/spot.svg', width: 20, height: 20,),
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: showButton ? 1 : 0, // 控制按钮的显示或隐藏
            child: Visibility(
                visible: showButton, // 控制按钮的显示或隐藏
                child: Transform.translate(
                  offset: const Offset(-5.0, 0.0),
                  child:  SizedBox(
                    width: 35,
                    height: 35,
                    child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0), // 设置圆角大小
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.red), // 设置红色背景
                          foregroundColor: MaterialStateProperty.all(Colors.white), // 设置白色字体
                          padding: MaterialStateProperty.all(EdgeInsets.zero), // 移除内边距
                        ),
                        onPressed:(){
                          showToast("info", "请求移除${widget.deviceInfo.deviceName}");
                          widget.remove.call(widget.deviceInfo.socketAddr);
                          },
                        child: const Text("解除")
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    ));
  }
}


