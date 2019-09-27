import "package:flutter/material.dart";
import "package:flutter/gestures.dart";

class EventBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListenerBox(),
          BehaviorTranslucentBox(),
          IgnoreBox(),
          GestureDetectorBox(),
          FontMove(),
          OnlyMove(),
          ScaleBox(),
          FontColor()
        ],
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

//translucent
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
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
          ),
          onPointerDown: (event) => print("down0"),
        ),
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200.0, 100.0)),
            child: Center(child: Text("左上角200*100范围内非文本区域点击")),
          ),
          onPointerDown: (event) => print("down1"),
          behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
        )
      ],
    );
  }
}

//忽略PointerEvent
class IgnoreBox extends StatefulWidget {
  @override
  _IgnoreBoxState createState() => _IgnoreBoxState();
}

class _IgnoreBoxState extends State<IgnoreBox> {
  @override
  Widget build(BuildContext context) {
    return Listener(
      child: AbsorbPointer(
        child: Listener(
          child: Container(
            color: Colors.red,
            width: 200.0,
            height: 100.0,
          ),
          onPointerDown: (event) => print("in"),
        ),
      ),
      onPointerDown: (event) => print("up"),
    );
  }
}

class GestureDetectorBox extends StatefulWidget {
  @override
  _GestureDetectorBoxState createState() => _GestureDetectorBoxState();
}

class _GestureDetectorBoxState extends State<GestureDetectorBox> {
  String _operation = "No Gesture detected!"; //保存事件名
  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () => updataText("Tap"), //点击
            onDoubleTap: () => updataText("DoubleTap"), //双击
            onLongPress: () => updataText("LongPress"), //长按
            child: Container(
                width: 200.0,
                height: 100.0,
                alignment: Alignment.center,
                color: Colors.blue,
                child:
                    Text(_operation, style: TextStyle(color: Colors.white)))));
  }

  void updataText(String text) {
    setState(() {
      _operation = text;
    });
  }
}

class FontMove extends StatefulWidget {
  @override
  _FontMoveState createState() => _FontMoveState();
}

class _FontMoveState extends State<FontMove> {
  double _left = 0.0;
  double _top = 0.0;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.tight(Size(300.0, 300.0)),
        child: Stack(
          children: <Widget>[
            Positioned(
                left: _left,
                top: _top,
                child: GestureDetector(
                    onPanDown: (e) {},
                    onPanUpdate: (e) {
                      setState(() {
                        _left += e.delta.dx;
                        _top += e.delta.dy;
                      });
                    },
                    child: CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Colors.blue,
                        child: Text(
                          "A",
                          style: TextStyle(color: Colors.white),
                        ))))
          ],
        ));
  }
}

class OnlyMove extends StatefulWidget {
  @override
  _OnlyMoveState createState() => _OnlyMoveState();
}

class _OnlyMoveState extends State<OnlyMove> {
  double _top = 0.0;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.tight(Size(300.0, 300.0)),
        child: Stack(
          children: <Widget>[
            Positioned(
              top:_top,
                child: GestureDetector(
              child: CircleAvatar(child: Text("A")),
              onVerticalDragUpdate: (DragUpdateDetails detail) {
                setState(() {
                  _top += detail.delta.dy;
                });
              },
            ))
          ],
        ));
  }
}

class ScaleBox extends StatefulWidget {
  @override
  _ScaleBoxState createState() => _ScaleBoxState();
}

class _ScaleBoxState extends State<ScaleBox> {
  double _width = 100.0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child:GestureDetector(
        onScaleUpdate: (ScaleUpdateDetails details){
          setState(() {
           _width =  200*details.scale.clamp(0.8, 10.0);
          });
        },
        child:Image.network("https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action/docs/imgs/8-4.png",width:_width)
      )
    );
  }
}

class FontColor extends StatefulWidget {
  @override
  _FontColorState createState() => _FontColorState();
}

class _FontColorState extends State<FontColor> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false;
  @override 
  void dispose() {
    // TODO: implement dispose
    _tapGestureRecognizer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Text.rich(TextSpan(
      children: [
        TextSpan(text:"你好世界"),
        TextSpan(
          text:"点我变色",
          style: TextStyle(
            color:_toggle?Colors.black:Theme.of(context).accentColor,
            fontSize: 30.0
          ),
          recognizer: _tapGestureRecognizer..onTap = (){
            setState(() {
             _toggle = !_toggle; 
            });
          }
        ),
        TextSpan(
          text:"你好世界"
        )
      ]
    ));
  }
}
