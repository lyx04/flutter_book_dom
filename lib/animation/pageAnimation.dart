import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class PageAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[PageA(), PageB(), PageC(), PageD()],
        ),
      ),
    );
  }
}

class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: FlatButton(
      child: Text("Ios版跳转"),
      onPressed: () {
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (BuildContext context) {
          return PageCommon();
        }));
      },
    )));
  }
}

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: FlatButton(
      child: Text("自定义页面跳转"),
      onPressed: () {
        Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return new FadeTransition(
                  opacity: animation, child: PageCommon());
            }));
      },
    )));
  }
}

class PageC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: FlatButton(
      child: Text("通过方法进行的页面跳转"),
      onPressed: () {
        Navigator.of(context).push(FadeRoute(builder: (BuildContext context) {
          return PageCommon();
        }));
      },
    )));
  }
}

class PageD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: InkWell(
      child: Hero(
          tag: "photo",
          child: ClipOval(
            child: Image.asset("images/10812014.jpg", width:15.0),
          )),
      onTap: () {
        Navigator.of(context).push(FadeRoute(builder: (BuildContext context) {
          return HeroCommon();
        }));
      },
    )));
  }
}

class HeroCommon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child:
                Hero(tag: "photo", child: Image.asset("images/10812014.jpg"))));
  }
}

class PageCommon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
      child: Text("PageB"),
    )));
  }
}

class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;
  final Duration transitionDuration;
  final Color barrierColor;
  final String barrierLabel;
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (isActive) {
      //判断路由页面
      return FadeTransition(opacity: animation, child: child);
    } else {
      return child;
    }
  }
}
