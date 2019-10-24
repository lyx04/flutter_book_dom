import "package:flutter/material.dart";

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[TurnBoxRoute()],
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  GradientButton({
    Key key,
    this.colors,
    @required this.onTap,
    this.borderRadius,
    this.width,
    this.height,
    @required this.child,
  }) : assert(onTap != null, child != null);

  final List<Color> colors;
  final GestureTapCallback onTap;
  final BorderRadius borderRadius;
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double _width = width ?? 100.0;
    double _height = height ?? 100.0;
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _colors,
        ),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            child: child,
            constraints:
                BoxConstraints.tightFor(width: _width, height: _height),
          ),
        ),
      ),
    );
  }
}

class CostomWidget extends StatefulWidget {
  CostomWidget({
    Key key,
    this.turns = .0,
    this.duration = 200,
    this.child,
  }) : super(key: key);

  double turns;
  int duration;
  Widget child;

  @override
  _CostomWidgetState createState() => _CostomWidgetState();
}

class _CostomWidgetState extends State<CostomWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity,
    );
    // _controller.value = widget.turns;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CostomWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.duration ?? 200),
        curve: Curves.easeOutCirc,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}

class TransitionWidget extends StatefulWidget {
  @override
  _TransitionWidgetState createState() => _TransitionWidgetState();
}

class _TransitionWidgetState extends State<TransitionWidget> {
  double _truns = .0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _truns += 0.2;
        });
      },
      child: CostomWidget(
        turns: _truns,
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(color: Colors.red),
          child: Text(
            "旋转",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

class TurnBoxRoute extends StatefulWidget {
  @override
  _TurnBoxRouteState createState() => new _TurnBoxRouteState();
}

class _TurnBoxRouteState extends State<TurnBoxRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          CostomWidget(
            turns: _turns,
            child: Icon(
              Icons.refresh,
              size: 50,
            ),
          ),
          CostomWidget(
            turns: _turns,
            child: Icon(
              Icons.refresh,
              size: 150.0,
            ),
          ),
          RaisedButton(
            child: Text("顺时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns += .2;
              });
            },
          ),
          RaisedButton(
            child: Text("逆时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns -= .2;
              });
            },
          )
        ],
      ),
    );
  }
}
