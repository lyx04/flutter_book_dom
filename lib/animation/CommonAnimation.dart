import "package:flutter/material.dart";

class CommonAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[CommonA()],
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
              return FadeTransition(
                child:child,
                opacity:animtion
              );
            },
            child: Text("$_count",
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.display1)),
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
