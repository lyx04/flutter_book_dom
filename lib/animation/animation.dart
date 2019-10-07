import "package:flutter/material.dart";

class AnimationBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
            child: Column(
      children: <Widget>[ImgenlargeBox()],
    )));
  }
}

class AnimationImg extends AnimatedWidget {
  AnimationImg({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
  Widget build(BuildContext context) {
    final Animation<double> _animation = listenable;
    return Container(
      width: _animation.value,
      height: _animation.value,
      child: Image.asset("images/10812014.jpg",
          width: _animation.value, height: _animation.value),
      color: Colors.black,
    );
  }
}

class ImgenlargeBox extends StatefulWidget {
  @override
  _ImgenlargeBoxState createState() => _ImgenlargeBoxState();
}

class _ImgenlargeBoxState extends State<ImgenlargeBox>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //注册一个控制器
    _controller = new AnimationController(
        duration: Duration(milliseconds: 500), vsync: this);
    _animation =
        new CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    //注册一个动画的值
    _animation = new Tween(begin: 0.0, end: 200.0).animate(_controller);
    _animation.addStatusListener((state){
      if(state == AnimationStatus.completed){
        _controller.reverse();
      }else if(state == AnimationStatus.dismissed){
        _controller.forward();
      }
    });
    // ..addListener(() {//监控每一帧
    //   setState(() {});//会导致widgt的build方法重新调用
    // });==AnimationImg
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return AnimationImg(animation: _animation,);
    // return AnimatedBuilder(
    //   animation: _animation,
    //   child:Image.asset("images/10812014.jpg"),
    //   builder: (BuildContext ctx,Widget child){
    //     return Container(
    //       height: _animation.value,
    //       width:_animation.value,
    //       child:child//是将上面的child的widget传到这里
    //     );
    //   },
    // );
    return Commonenlarge(
      child: Image.asset("images/10812014.jpg"),
      animation: _animation,
    );
  }
}

//公共动画方法组件
class Commonenlarge extends StatelessWidget {
  Commonenlarge({this.child, this.animation});
  Widget child;
  Animation animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext context, Widget child) {
        return Container(
            height: animation.value, width: animation.value, child: child);
      },
    );
  }
}
