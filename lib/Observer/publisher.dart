
import "package:flutter/material.dart";
import "middle.dart";

class ObserverBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[LoginA(), LoginB()],
    );
  }
}

//观察者模式中的订阅者
class LoginA extends StatefulWidget {
  @override
  _LoginAState createState() => _LoginAState();
}

class _LoginAState extends State<LoginA> {
  var userInfo;
  @override
  void initState() {
    super.initState();
    bus.on("login", (arg) {
      setState(() {
        userInfo = arg;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("${userInfo}"));
  }
}

//观察者模式中的发布者
class LoginB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlatButton(
      child: Text("登录页"),
      onPressed: () {
        bus.emit("login", {"sex": 111});
      },
    ));
  }
}
