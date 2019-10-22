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
  Animation<Color> _animation;
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        duration: Duration(seconds: 5), vsync: this);
    Animation curve = new CurvedAnimation(
        parent: _animationController, curve: Curves.fastLinearToSlowEaseIn);
    _animation = ColorTween(begin: Colors.red, end: Colors.blue).animate(curve);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        return DecoratedBox(
          decoration:BoxDecoration(color:_animation.value),
          child: child,
        );
      },
      child:FlatButton(
          onPressed: () {
            _animationController.forward();
          },
          child: Text("变色"),
        ),
    );
  }
}

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
            _decorationColor = Colors.red;
          });
        },
      ),
    );
  }
}
