import "package:flutter/material.dart";

class NotificBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
            child: Column(
      children: <Widget>[ScrollBox(), CustomBox()],
    )));
  }
}

class ScrollBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.tight(Size(300.0, 500.0)),
        child: Scrollbar(
            child: NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  print(notification);
                  // switch (notification.runtimeType) {
                  //   case ScrollStartNotification:
                  //     print("开始滚动");
                  //     break;
                  //   case ScrollUpdateNotification:
                  //     print("正在滚动");
                  //     break;
                  //   case ScrollEndNotification:
                  //     print("滚动停止");
                  //     break;
                  //   case OverscrollNotification:
                  //     print("滚动到边界");
                  //     break;
                  // }
                },
                child: ListView.builder(
                  itemCount: 80,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${index}"),
                    );
                  },
                ))));
  }
}

//自定义通知
class Custom extends Notification {
  Custom(this.msg);
  final String msg;
}

//分发通知
class CustomBox extends StatefulWidget {
  @override
  _CustomBoxState createState() => _CustomBoxState();
}

class _CustomBoxState extends State<CustomBox> {
  String _msg = "";
  @override
  Widget build(BuildContext context) {
    return NotificationListener<Custom>(
        onNotification: (notification) {
          print(notification.msg);
          return false;
        },
        child: NotificationListener<Custom>(
          onNotification: (notification) {
            setState(() {
              _msg += notification.msg + "";
            });
            return true;
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Builder(
                  builder: (context) {
                    return RaisedButton(
                        onPressed: () {
                          return Custom("hi").dispatch(context);
                        },
                        child: Text("send notification"));
                  },
                ),
                Text(_msg)
              ],
            ),
          ),
        ));
  }
}
