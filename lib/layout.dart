import "package:flutter/material.dart";

class LayoutBox extends StatefulWidget {
  @override
  _LayoutBoxState createState() => _LayoutBoxState();
}

class _LayoutBoxState extends State<LayoutBox> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Rowbox(),
        CoulmnsBox(),
        FlexBox(),
        WrapBox(),
        StackBox()
      ],
    );
  }
}

class Rowbox extends StatefulWidget {
  @override
  _RowboxState createState() => _RowboxState();
}

class _RowboxState extends State<Rowbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(" 我是横向布局"),
            Text(" 我是横向布局"),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("我是横向布局"),
            Text(" 我是横向布局"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Text(" 我是横向布局 "),
            Text(" 我是横向布局 "),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Text(
              " 我是横向布局 ",
              style: TextStyle(fontSize: 30.0),
            ),
            Text(" 我是横向布局 "),
          ],
        ),
      ],
    );
  }
}

class CoulmnsBox extends StatefulWidget {
  @override
  _CoulmnsBoxState createState() => _CoulmnsBoxState();
}

class _CoulmnsBoxState extends State<CoulmnsBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                    color: Colors.red,
                    child: Column(
                      children: <Widget>[Text("我是横向布局")],
                    )),
                Container(
                    color: Colors.red,
                    child: Column(
                      children: <Widget>[Text("我是横向布局")],
                    ))
              ],
            )));
  }
}

class FlexBox extends StatefulWidget {
  @override
  _FlexBoxState createState() => _FlexBoxState();
}

class _FlexBoxState extends State<FlexBox> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction:
          Axis.horizontal, //Axis.vertical纵向的需要一个确定的高度 例如使用container的height:80.0
      children: <Widget>[
        Expanded(flex: 3, child: Text("这是flex")),
        Expanded(child: Text("这是flex")),
        Expanded(flex: 2, child: Text("这是flex")),
        Expanded(flex: 2, child: Text("这是flex")),
        Expanded(flex: 2, child: Text("这是flex")),
        Expanded(flex: 2, child: Text("这是flex")),
        Expanded(flex: 2, child: Text("这是flex")),
        Expanded(flex: 2, child: Text("这是flex")),
        Expanded(flex: 2, child: Text("这是flex")),
        Expanded(flex: 2, child: Text("这是flex")),
        Expanded(flex: 2, child: Text("这是flex")),
        Expanded(flex: 2, child: Text("这是flex"))
      ],
    );
  }
}

class WrapBox extends StatefulWidget {
  @override
  _WrapBoxState createState() => _WrapBoxState();
}

class _WrapBoxState extends State<WrapBox> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      spacing: 10, //主轴方向的间距
      runSpacing: 20, //纵轴方向的间距
      runAlignment: WrapAlignment.spaceBetween,
      children: <Widget>[
        Text("这是wrap布局"),
        Text("这是wrap布局"),
        Text("这是wrap布局"),
        Text("这是wrap布局"),
        Text("这是wrap布局"),
      ],
    );
  }
}

class StackBox extends StatefulWidget {
  @override
  _StackBoxState createState() => _StackBoxState();
}

class _StackBoxState extends State<StackBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      color: Colors.red,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          Positioned(
            left: 10.0,
            child: Text("这是stack的position"),
          ),
          Positioned(
              left: 10.0,
              child: Opacity(
                  opacity: 0.1,
                  child: Container(
                      width: 50.0, height: 20.0, color: Colors.white)))
        ],
      ),
    );
  }
}
