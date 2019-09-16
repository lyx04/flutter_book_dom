import "package:flutter/material.dart";

class EventBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Column(
        children: <Widget>[ListenerBox(),BehaviorTranslucentBox()],
      ),
    );
  }
}

class ListenerBox extends StatefulWidget {
  @override
  _ListenerBoxState createState() => _ListenerBoxState();
}

class _ListenerBoxState extends State<ListenerBox> {
  PointerEvent _event;
  @override
  Widget build(BuildContext context) {
    return Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (PointerDownEvent event) => print("box b"),
        // onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
        // onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
        child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200.0, 150.0)),
            child: Center(child: Text("Box a"))));
  }
}

class BehaviorTranslucentBox extends StatefulWidget {
  @override
  _BehaviorTranslucentBoxState createState() => _BehaviorTranslucentBoxState();
}

class _BehaviorTranslucentBoxState extends State<BehaviorTranslucentBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
  children: <Widget>[
    Listener(
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(Size(300.0, 200.0)),
        child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue)),
      ),
      onPointerDown: (event) => print("down0"),
    ),
    Listener(
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(Size(200.0, 100.0)),
        child: Center(child: Text("左上角200*100范围内非文本区域点击")),
      ),
      onPointerDown: (event) => print("down1"),
      //behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
    )
  ],
);
  }
}