import 'dart:math';
import "package:flutter/material.dart";

class Customcircular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: ListView(
      children: <Widget>[],
    ));
  }
}

class Vircular extends StatelessWidget {
  Vircular({
    this.strokeWidth = 2.0,
    @required this.radius,
    @required this.colors,
    this.stops,
    this.stroleCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = 2 * pi,
    this.value,
  });

  // 粗细
  final double strokeWidth;

  //圆的半径
  final double radius;

  //两端是否为圆角
  final bool stroleCapRound;

  //当前进度
  final double value;

  //渐变颜色
  final List<Color> colors;

  //渐变颜色终点值
  final List<double> stops;

  //进度条的总弧度2*pi为整圆pi代表180度
  final double totalAngle;

  //进度条背景色
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    if (stroleCapRound) {
      // asin()返回一个数的反正弦值
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: CircularProgressPainter(
          strokeWidth: strokeWidth,
          stroleCapRound: stroleCapRound,
          backgroundColor: backgroundColor,
          value: value,
          total: totalAngle,
          radius: radius,
          colors: _colors,
        ),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  CircularProgressPainter({
    this.strokeWidth: 10.0,
    this.stroleCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.radius,
    this.total = 2 * pi,
    @required this.colors,
    this.stops,
    this.value,
  });

  final double strokeWidth;
  final bool stroleCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double> stops;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }
    double _offset = strokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;
    if (stroleCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth));
    }
    Rect rect = Offset(_offset, _offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    var paint = Paint()
      ..strokeCap = stroleCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    // 先画背景
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    // 再画前景，应用渐变
    if (_value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);

      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class GradientCircularProgressRoute extends StatefulWidget {
  @override
  GradientCircularProgressRouteState createState() {
    return new GradientCircularProgressRouteState();
  }
}

class GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: <Widget>[
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: <Widget>[
                          Vircular(
                            // No gradient
                            colors: [Colors.blue, Colors.blue],
                            radius: 50.0,
                            strokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          Vircular(
                            colors: [Colors.red, Colors.orange],
                            radius: 50.0,
                            strokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          Vircular(
                            colors: [Colors.red, Colors.orange, Colors.red],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            value: _animationController.value,
                          ),
                          Vircular(
                            colors: [Colors.teal, Colors.cyan],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            stroleCapRound: true,
                            value: CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.decelerate)
                                .value,
                          ),
                          // TurnBox(
                          //   turns: 1 / 8,
                          //   child: Vircular(
                          //       colors: [Colors.red, Colors.orange, Colors.red],
                          //       radius: 50.0,
                          //       strokeWidth: 5.0,
                          //       stroleCapRound: true,
                          //       backgroundColor: Colors.red[50],
                          //       totalAngle: 1.5 * pi,
                          //       value: CurvedAnimation(
                          //               parent: _animationController,
                          //               curve: Curves.ease)
                          //           .value),
                          // ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: Vircular(
                                colors: [Colors.blue[700], Colors.blue[200]],
                                radius: 50.0,
                                strokeWidth: 3.0,
                                stroleCapRound: true,
                                backgroundColor: Colors.transparent,
                                value: _animationController.value),
                          ),
                          Vircular(
                            colors: [
                              Colors.red,
                              Colors.amber,
                              Colors.cyan,
                              Colors.green[200],
                              Colors.blue,
                              Colors.red
                            ],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            stroleCapRound: true,
                            value: _animationController.value,
                          ),
                        ],
                      ),
                      Vircular(
                        colors: [Colors.blue[700], Colors.blue[200]],
                        radius: 100.0,
                        strokeWidth: 20.0,
                        value: _animationController.value,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Vircular(
                          colors: [Colors.blue[700], Colors.blue[300]],
                          radius: 100.0,
                          strokeWidth: 20.0,
                          value: _animationController.value,
                          stroleCapRound: true,
                        ),
                      ),
                      //剪裁半圆
                      ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: .5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                                //width: 100.0,
                                // child: TurnBox(
                                //   turns: .75,
                                //   child: Vircular(
                                //     colors: [Colors.teal, Colors.cyan[500]],
                                //     radius: 100.0,
                                //     strokeWidth: 8.0,
                                //     value: _animationController.value,
                                //     totalAngle: pi,
                                //     stroleCapRound: true,
                                //   ),
                                // ),
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 104.0,
                        width: 200.0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                              height: 200.0,
                              top: .0,
                              // child: TurnBox(
                              //   turns: .75,
                              //   child: Vircular(
                              //     colors: [Colors.teal, Colors.cyan[500]],
                              //     radius: 100.0,
                              //     strokeWidth: 8.0,
                              //     value: _animationController.value,
                              //     totalAngle: pi,
                              //     stroleCapRound: true,
                              //   ),
                              // ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "${(_animationController.value * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
