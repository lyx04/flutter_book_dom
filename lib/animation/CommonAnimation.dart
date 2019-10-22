import "package:flutter/material.dart";

class CommonAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[CommonA(), CommonB()],
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
            var tween =
                new Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                    .animate(animtion);
            // return FadeTransition(
            //   child:child,
            //   opacity:animtion
            // );
            return MySlideTransition(child: child, position: tween);
          },
          child: Text("$_count",
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.display1),
        ),
        RaisedButton(
          child: Text("+1"),
          onPressed: () {
            setState(() {
              _count += 1;
            });
          },
        )
      ],
    ));
  }
}

class MySlideTransition extends AnimatedWidget {
  MySlideTransition(
      {Key key,
      @required Animation<Offset> position,
      this.transformHitTests = true,
      this.child})
      : assert(position != null),
        super(key: key, listenable: position);
  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      child: child,
      transformHitTests: transformHitTests,
    );
  }
}

class CommonB extends StatefulWidget {
  @override
  _CommonBState createState() => _CommonBState();
}

class _CommonBState extends State<CommonB> {
  int _color = 1;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              var tween = new Tween<Offset>(
                      begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                  .animate(animation);
              return MySlideTransition(
                child: child,
                position: tween,
              );
            },
            child: Column(
              key: ValueKey(_color),
              children: <Widget>[
                Container(
                    width: 100.0,
                    height: 100.0,
                    color: _color % 2 == 0 ? Colors.red : Colors.black)
              ],
            )),
        RaisedButton(
          child: Text("动画变色"),
          onPressed: () {
            setState(() {
              _color += 1;
            });
          },
        )
      ],
    ));
  }
}
