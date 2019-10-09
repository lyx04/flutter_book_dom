import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class PageAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[PageA(), PageB(), PageC(), PageD(),StaggerRoute()],
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
            child: GestureDetector(
      child: Column(
        children: <Widget>[
          Hero(
              tag: "photo",
              child: ClipOval(
                child: Image.asset("images/10812014.jpg", width: 15.0),
              )),
          Text("使用hero共享元素转换")
        ],
      ),
      onTap: () {
        Navigator.of(context).push(FadeRoute(builder: (BuildContext context) {
          return HeroCommon();
        }));
      },
    )));
  }
}


//交织动画的widget
class InterweaveAnimation extends StatelessWidget {
 final Animation<double> controller;
  Animation<Color> color;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  InterweaveAnimation({Key key,this.controller}):super(key:key){
    height = Tween<double>(
      begin: .0,
      end:300.0
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,0.6,
          curve: Curves.ease
        )
      )
    );
    color = ColorTween(
      begin: Colors.green,
      end: Colors.red
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,0.6,
          curve: Curves.ease,
        )
      )
    );
    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left:.0),
      end: EdgeInsets.only(left:300.0)
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.6,1.0,
          curve: Curves.easeOutExpo
        )
      )
    );
  }
 
  Widget _buildAnimation(BuildContext context,Widget child){
    return Container(
      alignment: Alignment.bottomCenter,
      padding:padding.value,
      child:Container(
        color:color.value,
        width:50.0,
        height:height.value
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}

class StaggerRoute extends StatefulWidget {
  @override
  _StaggerRouteState createState() => _StaggerRouteState();
}

class _StaggerRouteState extends State<StaggerRoute> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 9000),vsync: this);
  }

  Future<Null> _playAnimation() async{
    try{
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    }on TickerCanceled{

    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,//效果作用于整个widget
      onTap: (){
        _playAnimation();
      },
      child:Center(
        child:Container(
          width:300.0,
          height:300.0,
          decoration: BoxDecoration(
            color:Colors.black.withOpacity(0.1),
            border: Border.all(
              color:Colors.black.withOpacity(0.5)
            )
          ),
          child:InterweaveAnimation(
            controller: _controller,
          )
        )
      )
    );
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

