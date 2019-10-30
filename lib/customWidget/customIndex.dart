import "package:flutter/material.dart";

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[TransitionWidget(), MyText()],
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
    _controller.value = widget.turns;
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

class _TransitionWidgetState extends State<TransitionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _trues = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      lowerBound: -double.infinity,
      upperBound: double.infinity,
      vsync: this,
    );
    _controller.value = _trues;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: RotationTransition(
        turns: _controller,
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.red,
        ),
      ),
      onTap: () {
        setState(() {
          _trues += 0.2;
        });
        _controller.animateTo(
          _trues,
          duration: Duration(milliseconds: 500),
        );
      },
    );
  }
}

class MyRichText extends StatefulWidget {
  MyRichText({
    Key key,
    this.text,
    this.linkStyle,
  }) : super(key: key);

  final String text;
  final TextStyle linkStyle;
  @override
  _MyRichTextState createState() => _MyRichTextState();
}

class _MyRichTextState extends State<MyRichText> {
  TextSpan _textSpan;
  @override
  Widget build(BuildContext context) {
    return RichText(text: _textSpan);
  }

  TextSpan parseText(String text) {
    return TextSpan(
      text: text,
      style: widget.linkStyle
    );
    // return
  }

  @override
  void didUpdateWidget(MyRichText oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      _textSpan = parseText(widget.text);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textSpan = parseText(widget.text);
  }
}

class MyText extends StatefulWidget {
  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    String _text =
        "fdslkfjsdklfjsdklfjsdklfjsdkl2fjsdlkfsdfsdf/https://www.baidu.com";
    return MyRichText(text: _text, linkStyle: TextStyle(color: Colors.black));
  }
}
