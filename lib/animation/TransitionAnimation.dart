import "package:flutter/material.dart";

class TransitionAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[AnimatedDecoratedBox1(), CommonA()],
      )),
    );
  }
}

class AnimatedDecoratedBox1 extends StatefulWidget {
  @override
  _AnimatedDecoratedBox1State createState() => _AnimatedDecoratedBox1State();
}

class _AnimatedDecoratedBox1State extends State<AnimatedDecoratedBox1>
    with SingleTickerProviderStateMixin {
  Color _color = Colors.red;
  Animation<Color> _animation;
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this);
    Animation curve = new CurvedAnimation(
        parent: _animationController, curve: Curves.fastLinearToSlowEaseIn);
    _animation = ColorTween(begin: Colors.red, end: Colors.blue).animate(curve);
    _animation.addStatusListener((listener) {
      print("-----------------------$listener");
    });
  }

  @override
  void didUpdateWidget(AnimatedDecoratedBox1 oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("//////////////////////$oldWidget");
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        return DecoratedBox(
          decoration: BoxDecoration(color: _animation.value),
          child: child,
        );
      },
      child: FlatButton(
        onPressed: () {
          _animationController.forward();
        },
        child: Text("变色"),
      ),
    );
  }
}

//继承statefulWidget
class AnimatedDecoratedBox2 extends StatefulWidget {
  AnimatedDecoratedBox2({
    Key key,
    @required this.decoration,
    @required this.duration,
    this.child,
    this.curve = Curves.linear,
    this.reverseDuration,
  });

  final BoxDecoration decoration;
  final Duration duration;
  final Widget child;
  final Curve curve;
  final Duration reverseDuration;
  @override
  _AnimatedDecoratedBox2State createState() => _AnimatedDecoratedBox2State();
}

class _AnimatedDecoratedBox2State extends State<AnimatedDecoratedBox2>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  DecorationTween _tween;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    );
    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
  }

  void _updateCurve() {
    if (widget.curve != null) {
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    } else {
      _animation = _controller;
    }
  }

  @override
  void didUpdateWidget(AnimatedDecoratedBox2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.curve != oldWidget.curve) {
      _updateCurve();
      _controller.duration = widget.duration;
      _controller.reverseDuration = widget.reverseDuration;
    }
    print(widget.decoration);
    print(_tween.end);
    print(_tween.begin);
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}

class CommonA extends StatefulWidget {
  @override
  _CommonAState createState() => _CommonAState();
}

class _CommonAState extends State<CommonA> {
  Color _decorationColor = Colors.blue;
  var durantion = Duration(milliseconds: 500);
  @override
  Widget build(BuildContext context) {
    return AnimatedDecoratedBox2(
      duration: durantion,
      decoration: BoxDecoration(color: _decorationColor),
      child: FlatButton(
        child: Text(
          "AnimatedDecoratedBox",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          setState(() {
            // _decorationColor = Colors.red;
          });
        },
      ),
    );
  }
}

//继承 ImplicitlyAnimatedWidget
class AnimatedDecoratedBox3 extends ImplicitlyAnimatedWidget {
  AnimatedDecoratedBox3({
    Key key,
    @required this.decoration,
    this.child,
    Curve curve = Curves.linear, //动画曲线
    @required Duration duration, // 正向动画执行时长
    Duration reverseDuration, // 反向动画执行时长
  }) : super(
          key: key,
          curve: curve,
          duration: duration,
        );
  final BoxDecoration decoration;
  final Widget child;

  @override
  _AnimatedDecoratedBoxState createState() {
    return _AnimatedDecoratedBoxState();
  }
}

class _AnimatedDecoratedBoxState
    extends AnimatedWidgetBaseState<AnimatedDecoratedBox3> {
  DecorationTween _decoration;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: _decoration.evaluate(animation), child: widget.child);
  }

  @override
  void forEachTween(visitor) {
    // 在需要更新Tween时，基类会调用此方法
    _decoration = visitor(_decoration, widget.decoration,
        (value) => DecorationTween(begin: value));
  }
}
