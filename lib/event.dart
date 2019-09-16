import "package:flutter/material.dart";

class EventBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Column(
        children: <Widget>[ListenerBox()],
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
