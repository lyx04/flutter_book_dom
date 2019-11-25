import "package:flutter/material.dart";

class DataShare extends InheritedWidget {
  DataShare({
    Key key,
    @required this.data,
    Widget child,
  }) : super(child: child);
  final int data;
  static DataShare of(BuildContext context) {
    print(context);
    // 定义一个便捷方法，方便子树中的Widget获取共享数据
    return context.inheritFromWidgetOfExactType(DataShare);
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(DataShare oldWidget) {
    print("-------------------------------");
    print(oldWidget.data);
    print(data);
    print("-------------------------------");
    //如果返回true，则子树中依赖（build函数中有调用）本Widget的子Widget的State.didChangeDependencies会被调用
    return oldWidget.data != data;
  }
}

class Test1Widget extends StatefulWidget {
  @override
  _Test1WidgetState createState() => _Test1WidgetState();
}

class _Test1WidgetState extends State<Test1Widget> {
  int count = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("我在Test中被调用了");
  }

  @override
  Widget build(BuildContext context) {
    return DataShare(
      data: count,
      child: Column(
        children: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return Text(
                DataShare.of(context).data.toString(),
              );
            },
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: Text("自增1"),
          )
        ],
      ),
    );
  }
}
