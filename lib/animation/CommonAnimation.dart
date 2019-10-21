import "package:flutter/material.dart";

class CommonAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[CommonA(), CommonC()],
      ),
    ));
  }
}

class CommonA extends StatefulWidget {
  @override
  _CommonAState createState() => _CommonAState();
}

class _CommonAState extends State<CommonA> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 5000),
          transitionBuilder: (Widget child, Animation<double> animtion) {
            return FadeTransition(child: child, opacity: animtion);
          },
          child: Text("$_count",
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.display1),
        ),
        RaisedButton(
          child: Text("+1"),
          onPressed: () {},
        )
      ],
    ));
  }
}

class CommonC extends StatefulWidget {
  @override
  _CommonCState createState() => _CommonCState();
}

class _CommonCState extends State<CommonC> {
  int _colors = 1;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 5000),
          child: Container(
            key:ValueKey(_colors),
            width: 100.0,
            height: 100.0,
            color: _colors % 2 == 0 ? Colors.blue : Colors.red,
          ),
          transitionBuilder: (Widget child, Animation<double> animation) {
            Tween tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
            return SlideTransitionX(
              child: child,
              position: animation,
              direction: AxisDirection.up,
            );
          },
        ),
        RaisedButton(
          child: Text("通用动画"),
          onPressed: () {
            setState(() {
              _colors += 1;
            });
          },
        )
      ],
    ));
  }
}

//通用动画
class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.child,
    this.direction = AxisDirection.down,
  })  : assert(position != null),
        super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        // TODO: Handle this case.
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        // TODO: Handle this case.
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        // TODO: Handle this case.
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        // TODO: Handle this case.
        break;
    }
  }

  Tween<Offset> _tween;
  final bool transformHitTests;
  Animation<double> get position => listenable;
  final Widget child;
  final AxisDirection direction;

  @override
  Widget build(BuildContext context) {
    print(_tween.evaluate(position));
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          // TODO: Handle this case.
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          // TODO: Handle this case.
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          // TODO: Handle this case.
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          // TODO: Handle this case.
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
