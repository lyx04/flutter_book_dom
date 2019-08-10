import "package:flutter/material.dart";

class ScrollBox extends StatefulWidget {
  @override
  _ScrollBoxState createState() => _ScrollBoxState();
}

class _ScrollBoxState extends State<ScrollBox> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
            // scrollDirection: Axis.,
            // physics:BouncingScrollPhysics() ,
            physics: ClampingScrollPhysics(), //滑动到边界的样式
            child: Center(
                child: Column(
              children: <Widget>[SingleBox(),ListViewBox()],
            ))));
  }
}

class SingleBox extends StatefulWidget {
  @override
  _SingleBoxState createState() => _SingleBoxState();
}

class _SingleBoxState extends State<SingleBox> {
  String az = "abcdefghijklmnopqrstuvwxyz";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: az
            .split("")
            .map((e) => Text(
                  e,
                  textScaleFactor: 2,
                ))
            .toList(),
      ),
    );
  }
}

class ListViewBox extends StatefulWidget {
  @override
  _ListViewBoxState createState() => _ListViewBoxState();
}

class _ListViewBoxState extends State<ListViewBox> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      itemExtent: 100.0,
      shrinkWrap: true,
      children: <Widget>[
        const Text('I\'m dedicating every day to you'),
        const Text('Domestic life was never quite my style'),
        const Text('When you smile, you knock me out, I fall apart'),
        const Text('And I thought I was so smart'),
        const Text('And I thought I was so smart'),
        const Text('And I thought I was so smart'),
        const Text('And I thought I was so smart'),
      ],
    );
  }
}
